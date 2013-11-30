<?php
include_once('db.php'); //should not be here
include_once('exception.php');
include_once('classes.php');

//set up the exceptions
class Account extends CustomException {} //'User with that e-mail already exists.'
class Credentials extends CustomException {} //'Incorrect user credentials.'
class Authorization extends CustomException {} //'Account is not authorized.'
class PollNotFound extends CustomException {} //'Poll is not in database.'
class MalformedAccessCode extends CustomException {} //'Access code is malformed.'
class Subscription extends CustomException {} //'Key is not correct'
class GroupNotFound extends CustomException {} //'Group is not in database'
class Activation extends CustomException {} //'Only the creator can activate/deactivate a poll'

/******* Start SESSION manager ********
	Sets the user to the anonymous user if no session exists.
	If Session is already set then it leaves it alone.
*/
if(!isset($_SESSION)) {
    session_start();
}
if(empty($_SESSION['email']) && empty($_SESSION['alias'])){
    $_SESSION['alias'] = 'anonymous';
    $_SESSION['email'] = 'anonymous@anonymous.com';
}
// ******* End SESSION manager ********

/*
	Returns the alias if set or e-mail of the logged in user.
	Will return anonymous if the user is not logged in.
	
	Authored by: Dylan
*/
function loggedInUser()
{
	if(empty($_SESSION['alias'])){
		return $_SESSION['email'];
	}else{
		return $_SESSION['alias'];
	}
}

/* Get a user's gravatar using the session email(returns size based on input)
 *	
 * Authored by: Brady, gravatar
 */
function getGravatarURL($sizePx=40) {
	$email = $_SESSION['email'];
	$size = $sizePx; // set the size of the returned photo
	$default = 'mm'; // need to set this to be somedefault not signed in avatar
	$grav_url = "http://www.gravatar.com/avatar/" . md5( strtolower( trim( $email ) ) ) . "?d=" . urlencode( $default ) . "&s=" . $size;
	return $grav_url;
}

/* Get a user's gravatar using a given email (returns size based on input)
 *	
 * Authored by: Brady, gravatar
 */
function getGravatarURLemail($email, $sizePx=40) {
	$size = $sizePx; // set the size of the returned photo
	$default = 'mm'; // need to set this to be somedefault not signed in avatar
	$grav_url = "http://www.gravatar.com/avatar/" . md5( strtolower( trim( $email ) ) ) . "?d=" . urlencode( $default ) . "&s=" . $size;
	return $grav_url;
}

/*
    Generates a random access code for accessing polls. 
    A random string of characters in the charset with a given length (default 5)
	
	Authored by: Dylan
*/
function generateAccessCode($db, $length=5){
    $charset = array("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
    $code = "";
    randomize();
	/* Checks that the key doesn't already exist in the database */
	do{
		$rand_keys = array_rand($charset, $length);
		$accessCode = '';
		for($i = 0; $i < $length; $i++){
			$accessCode .= $charset[$rand_keys[$i]];
		}
		$sql = $db->prepare("SELECT * FROM polls WHERE poll_id=:access;");
		$sql->bindValue(':access', $accessCode);
		$sql->execute();
	}while($sql->rowCount() > 0);
    return $accessCode;
}

// seed with microseconds
// found on stack overflow
function randomize()
{
  list($usec, $sec) = explode(' ', microtime());
  srand((float) $sec + ((float) $usec * 100000));
}

/*
	Authorizes a user's account so they can login with it.
	
	Authored by: Dylan
*/
function authorizeUser($db, $email, $key){
	$sql = $db->prepare("SELECT user_authorized, user_mail, user_salt FROM users WHERE user_email=:email LIMIT 1;");
	$sql->bindValue(':email', $email);
	$sql->execute();
	if($sql->rowCount() == 1){
		//there is a user with that email
		$user = $sql->fetch();
		if($key === sha1($user['Email'] . $user['Salt'])){
			//correct authorization link. authorize the e-mail
			$sql = $db->prepare("UPDATE users SET user_authorized='true' WHERE user_email=:email;");
			$sql->bindValue(':email', $email);
			$sql->execute();
			return; //success
		}else{
			throw new Authorization('Incorrect key for given email');
		}
	}else{
		throw new Authorization('E-mail not found.');
	}
}

/*
    Operation: signUp (UserDetails)
    Cross Reference: Use case Sign Up
    Preconditions:
    The UserDetails were validated by the Client
        A valid email address
        Matching password and password confirmation fields
    Postconditions:
    The UserDetails were unique to existing authenticated Accounts
    The UserDetails were used to create or update an unauthorized Account
    An email was sent to the email address in the UserDetails
	
	Authored by: Dylan, Max
*/

function signUp($db, $email, $password, $alias){
	$email = strtolower($email); //allows the user to input his email case insensitive
	if(empty($email) || empty($password)){
		throw new Account('Empty e-mail or password fields!');
	}
	// check for a valid email
	// this should work for everything except IP address server thing, should be fine
	$valid = "^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$";
	
	if (!eregi($valid , $email)){
		throw new Account('Invalid Email');
	}
    randomize();
	$salt = rand(0, 100000);
	$hash = sha1($password . $salt);
	$sql = $db->prepare("SELECT user_authorized FROM users WHERE user_email=:email;");
	$sql->bindValue(':email', $email);
	$sql->execute();
	if($sql->rowCount() > 0){
		//there is a user with that email already
		$user = $sql->fetch();
		if((bool)$user['user_authorized']){
			throw new Account('Duplicate e-mail.');
		}else{
			$sql = $db->prepare("UPDATE users SET user_hash=:hash, user_salt=:salt, user_alias=:alias, user_authorized=:authorized WHERE user_email=:email;");
		}
	}else{
		//no user with that email exists so lets make a new one
		$sql = $db->prepare("INSERT INTO users (user_email, user_hash, user_salt, user_alias, user_authorized) VALUES (:email, :hash, :salt, :alias, :authorized);");
	}
	$sql->bindValue(':email', $email);
	$sql->bindValue(':alias', $alias);
	//$sql->bindValue(':authorized', 'false'); //uncomment this to allow email authorization
	$sql->bindValue(':authorized', 'true'); //comment this to allow email authorization
	$sql->bindValue(':hash', $hash);
	$sql->bindValue(':salt', $salt);
	$sql->execute();
	//sendAuthorizationEmail($email, $salt); //uncomment this to alloe email authorization
}

/*
	Sends an e-mail to the given e-mail with a link that will authorize the account.
	Uses the given salt to generate a key unique to the e-mail.
	
	Authored by: Dylan
*/
function sendAuthorizationEmail($email, $salt)
{

    $subject = 'Webclicker Authorization Link';
    $link = 'http://webclicker.tk/authorize.php?email='.$email.'&key='.sha1($email . $salt);
    $message = '
    <html>
    <head>
      <title>Webclkicker Authorization Link</title>
    </head>
    <body>
      <a href="'.$link.'">Click here to fully validate your account!</a>
    </body>
    </html>
    ';

    // To send HTML mail, the Content-type header must be set
    $headers  = 'MIME-Version: 1.0' . "\r\n";
    $headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
    // Additional headers
    $headers .= 'To: <'.$email.'>' . "\r\n";
    $headers .= 'From: Webclicker Support <support@webclicker.tk>' . "\r\n";

    // Mail it
    mail($email, $subject, $message, $headers);
}

/*
	Signs the user out by clearing the SESSION and any cookies that were set.
	Authored by: Dylan
*/
function signOut(){
    // Delete all the values (don't try to unset $_SESSION)
    $_SESSION = array();

    // Delete the session cookie if found
    if (isset($_COOKIE[session_name()])) 
    {
        setcookie(session_name(), '', time()-42000, '/');
    }

    // And get destroy the session
    session_destroy();
}

/*
	Tries to sign the user in with the supplied credentials.
	If credentials are valid then the SESSION is set otherwise throws an exception.
	
	Authored by: Dylan
*/
function signIn($db, $email, $password){
	$email = strtolower($email); //allows the user to input his email case insensitive
	$sql = $db->prepare("SELECT * FROM users WHERE user_email=:email LIMIT 1;");
	$sql->bindValue(':email', $email);
	$sql->execute();
	
	if($sql->rowCount() == 1){
		$user = $sql->fetch();
		if(!(bool)$user['user_authorized']){
			throw new Authorization('Account is not yet authorized.');
		}
		if(sha1($password . $user['user_salt']) === $user['user_hash']){
			$_SESSION['email'] = $user['user_email'];
			$_SESSION['alias'] = $user['user_alias'];
			return; //success
		}else{
			throw new Credentials('Incorrect password.');
		}
	}else{
		throw new Credentials('Incorrect e-mail.');
	}
}

/*
	Preliminary check for validity of an access code.
	Authored by: Dylan
*/
function validAccessCode($access)
{
	if(strlen($access) != 5){
		throw new MalformedAccessCode('Access code is malformed');
	}
}

/*
	Returns a poll object if found in the database with the supplied access code.
	Authored by: Max
*/
function searchPoll($db, $access){
	$sql = $db->prepare("SELECT * FROM polls WHERE poll_id=:access;");
	$sql->bindValue(':access', $access);
	$sql->execute();
	if($sql->rowCount() == 1){
		//there is a poll with that access code
		return Poll::createFromDB($sql->fetch(), $db);
	}
	else {
		throw new PollNotFound('Poll Doesn\'t Exist');
	}
}

/*
	Determines if the current user has taken a poll. 
	Will return false if not currently logged in.
	Authored by: Dylan
*/
function userTakenPoll($db, $poll){
	if($_SESSION['email'] == 'anonymous@anonymous.com'){
			return false;
	}else{
		$sql = $db->prepare("SELECT * FROM responses WHERE response_user_email=:email AND response_poll_id=:poll;");
		$sql->bindValue(':email', $_SESSION['email']);
		$sql->bindValue(':poll', $poll);
		$sql->execute();
		return($sql->rowCount() > 0);
	}
}

/*
	Displays the givens rows of polls in a list
	Authored by: Dylan
*/
function displayPollsList($polls){
	foreach($polls as $poll){
		echo 	'<li style="padding:1px;">
					<div data-mini="true" data-role="collapsible" data-collapsed="true">
							<h1><span class="code">['.$poll['poll_id'].']</span> '.$poll['poll_name'].'</h1>
							<div class="ui-grid-b">
								<div class="ui-block-a">
									<a href="poll_take.php?accessCode='.$poll['poll_id'].'" data-role="button" data-mini="true" data-ajax="false">Take</a>
								</div>
								<div class="ui-block-b">
									<a href="poll_results.php?accessCode='.$poll['poll_id'].'" data-role="button" data-mini="true" data-ajax="false">Results</a>
								</div>
								<div class="ui-block-c">
									<a href="poll_details.php?accessCode='.$poll['poll_id'].'" data-role="button" data-mini="true" data-ajax="false">Details</a>
								</div>
						</div>
					</div>
				</li>';
	}
}
/*
	Grabs the 10 most recent polls from the database to display on the homepage
	Authored by: Dylan
*/
function displayRecentPolls($db){
	$sql = $db->prepare("SELECT * FROM polls WHERE poll_active='true' AND poll_group_name='Public' ORDER BY poll_date_created DESC LIMIT 5;");
	$sql->execute();
	displayPollsList($sql->fetchAll());
}

/*
	Grabs all polls from the database to display in the searchable list on the homepage
	Authored by: Dylan
*/
function displaySearchablePolls($db){
	$sql = $db->prepare("SELECT * FROM polls WHERE poll_active='true' ORDER BY poll_date_created DESC;");
	$sql->execute();
	displayPollsList($sql->fetchAll());
}

/*
	Generates the proper data array for jqPlot to make a bar/pie graph out of from a single question.
	Authored by: Dylan/Jason
*/
function questionTojQplot($question){
	$responses = array();
	foreach($question->PAnswers as $panswer){
		$responses[$panswer->PAnswer] = 0;
	}
	
	foreach($question->Responses as $response){
		$responses[$response->Response]++;
		//$responses[] = $response->Response; //gather responses
	}
	$data = array();
	//$responses = array_count_values($responses); //count how many of each
	while (list($key, $val) = each($responses) ){
		$data[] = array($key, $val); //turn into jQplot aray
	}
	return json_encode($data); //turn into javascript array
}

/*
	Returns the tick interval based on the maximum responses in the question and the specified amount of ticks.
	Authored by: Dylan
*/
function tickInterval($question, $ticks = 5){
	if(sizeof($question->Responses) < 1){
		return 1;
	}
	$responses = array();
	foreach($question->Responses as $response){
		$responses[] = $response->Response; //gather responses
	}
	//return integer of max value of the counts of responses divided by ticks
	$interval = max(array_count_values($responses)) / $ticks;
	if($interval < 1){
		return 1;
	}else{
		return intval($interval);
	}
}

/*
	Generates a random poll name for users who are too lazy to make up their own.
	Authored by: Dylan
	Source List of words: http://www.supereasystorytelling.com/awesome_adjectives_list.html
*/
function randomPollName(){
	$words = array(
					'Fast', 'Quick', 'Speedy', 'Swift', 'Hasty', 'Zippy', 'Rapid', 'Slow', 'Sluggish', 'Creeping', 
					'Dawdling', 'Meandering', 'Crawling', 'Beautiful ', 'Striking', 'Stunning', 'Gorgeous', 'Picturesque', 
					'Lovely', 'Charming', 'Enchanting', 'Exquisite', 'Delicate', 'Ugly', 'Hideous', 'Horrid', 'Dreadful ', 
					'Obnoxious', 'Nasty', 'Ghastly ', 'Cruel ', 'Revolting', 'Intimidating', 'Menacing ', 'Miserable', 
					'Dangerous', 'Rude', 'Spoiled', 'Wild', 'Lazy', 'Selfish', 'Delinquent', 'Greedy', 'Vile', 'Ridiculous', 
					'Kind', 'Gentle ', 'Quiet', 'Caring', 'Fair', 'Compassionate', 'Benevolent', 'Polite', 'Amusing', 
					'Generous', 'Entertaining', 'Hopeful', 'Lively', 'Creative', 'Brave', 'Good', 'Fantastic', 'Marvellous', 
					'Fabulous', 'Splendid', 'Brilliant', 'Superb', 'Dynamite', 'Bad', 'Dreadful', 'Terrible', 'Ghastly', 
					'Filthy', 'Repulsive', 'Awful', 'Happy', 'Joyful', 'Ecstatic', 'Cheerful', 'Delighted', 'Blithe', 
					'Carefree', 'Bored', 'Hardworking', 'Mysterious', 'Verbose', 'Laconic', 'Curious', 'Bucolic', 'Silly',
					'Contrary', 'Shocking', 'Wild', 'Rambunctious', 'Courageous', 'Cowardly', 'Ornery', 'Gullible', 'Thrifty', 
					'Famous', 'Infamous', 'Brazen', 'Cold', 'Hard ', 'Subtle', 'Gullible', 'Hungry', 'Anxious', 'Nervous', 
					'Antsy', 'Impatient', 'Shining', 'Crispy', 'Soaring', 'Endless', 'Sparkling', 'Fluttering', 'Spiky', 
					'Scrumptious', 'Eternal', 'Slimy', 'Slick', 'Gilded', 'Ancient', 'Smelly', 'Glowing', 'Rotten', 'Decrepit', 
					'Lousy', 'Grimy', 'Rusty', 'Sloppy', 'Muffled', 'Foul', 'Rancid', 'Fetid', 'Small', 'Itty-bitty', 'Tiny', 
					'Puny', 'Minuscule', 'Minute', 'Diminutive', 'Petite', 'Slight', 'Big', 'Huge', 'Gigantic', 'Monstrous',
					'Immense', 'Great', 'Tremendous', 'Enormous', 'Massive ', 'Whopping', 'Vast', 'Brawny', 'Hulking', 'Bulky', 
					'Towering', 'Hot', 'Steaming', 'Sweltering', 'Scorching', 'Blistering', 'Sizzling', 'Muggy', 'Stifling', 
					'Sultry', 'Oppressive', 'Cold', 'Chilly', 'Freezing', 'Icy', 'Frosty', 'Bitter', 'Arctic', 'Difficult', 
					'Demanding', 'Trying', 'Challenging', 'Easy', 'Simple', 'Effortless', 'Relaxed', 'Calm', 'Tranquil', 
					'Heavy', 'Serious', 'Grave', 'Profound', 'Intense', 'Severe'
					); 
	randomize();
	$key = array_rand($words, 1);
	
	return $words[$key]." Poll #".rand(10,99);
}

/*
	Activates the poll so it can be taken by users, only the creator can do this.
	Authored By: Dylan
*/
function activatePoll($db, $creator, $accessCode){
	if($_SESSION['email'] != $creator){
		throw new Activation('Only the creator of a poll can activate it.');
	}else{
		setPollActivation($db, $accessCode, 'true');
	}
}

/*
	Deactivates the poll so it can't be taken by users, only the creator can do this.
	Authored By: Dylan
*/
function deactivatePoll($db, $creator, $accessCode){
	if($_SESSION['email'] != $creator){
		throw new Activation('Only the creator of a poll can deactivate it.');
	}else{
		setPollActivation($db, $accessCode, 'false');
	}
}

/*
	Sets the given poll's active status to true or false, whatever is passed
	Authored By: Dylan
*/
function setPollActivation($db, $accessCode, $active){
	$sql = $db->prepare("UPDATE polls SET poll_active=:active WHERE poll_id=:access;");
	$sql->bindValue(':access', $accessCode);
	$sql->bindValue(':active', $active);
	$sql->execute();
}
/*
	Redirects the user to the correct page even with URL rewriting enabled.
	$url should be relative and not an absolute path
	Authored by: Dylan
	Source taken from: http://php.net/manual/en/function.header.php
*/
function redirectTo($extra){
	$host  = $_SERVER['HTTP_HOST'];
	$uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
	header("Location: http://$host$uri/$extra");
}

/* 
	Returns the specified group if it exists
	Authored by: Dylan
*/
function searchGroup($db, $name, $creator){
	$sql = $db->prepare("SELECT * FROM groups WHERE group_user_email=:creator AND group_name=:name;");
	$sql->bindValue(':creator', $creator);
	$sql->bindValue(':name', $name);
	$sql->execute();
	if($sql->rowCount() == 1){
		return new Group($sql->fetch());
	}else{
		throw new GroupNotFound('Group Doesn\'t exist');
	}
}

/*
	Returns a list of groups owned for the individual logged in
	Authored by: Dylan
*/
function groupsOwnedByUser($db){
	$groups = array();
	$sql = $db->prepare("SELECT * FROM groups WHERE group_user_email=:user OR group_user_email='anonymous@anonymous.com' ORDER BY group_date_created DESC;");
	$sql->bindValue(':user', $_SESSION['email']);
	$sql->execute();
	$rows = $sql->fetchAll();
	foreach($rows as $group){
		$groups[] = new Group($group);
	}
	return $groups;
}

/*
	Returns a list of groups joined for the individual 
	Authored by: Dylan
*/
function groupsJoinedByUser($db){
	$groups = array();
	if($_SESSION['email'] != 'anonymous@anonymous.com'){
		$sql = $db->prepare("SELECT * FROM groups WHERE :user IN (SELECT groupuser_user_email_user FROM groupusers WHERE group_user_email=groupuser_user_email_group AND group_name=groupuser_group_name ORDER BY groupuser_date_joined DESC);");
		$sql->bindValue(':user', $_SESSION['email']);
		$sql->execute();
		$rows = $sql->fetchAll();
		foreach($rows as $group){
			$groups[] = new Group($group);
		}
	}
	return $groups;
}

/*
	Creates the group for the currently logged in user
	Authored by: Dylan
*/
function createGroup($db, $name, $key){
	$sql = $db->prepare("INSERT INTO groups (group_name, group_user_email, group_key) VALUES (:group, :user, :key);");
	$sql->bindValue(':group', $name);
	$sql->bindValue(':user', $_SESSION['email']);
	$sql->bindValue(':key', $key);
	$sql->execute();
}

/*
	Unsubscribes the currently logged in user from a group
	Authored by: Dylan
*/
function unsubscribe($db, $group, $creator){
	if($_SESSION['email'] === 'anonymous@anonymous.com'){
		throw new Subscription('anonymous users are not allowed to subscribe to groups!');
	}
	$sql = $db->prepare("DELETE FROM groupusers WHERE groupuser_group_name=:group AND groupuser_user_email_group=:creator AND groupuser_user_email_user=:user");
	$sql->bindValue(':group', $group);
	$sql->bindValue(':creator', $creator);
	$sql->bindValue(':user', $_SESSION['email']);
	$sql->execute();
}

/*
	Subscribes the currently logged in user to a group
	Authored by: Dylan
*/
function subscribe($db, $group, $creator, $key){
	if($_SESSION['email'] === 'anonymous@anonymous.com'){
		throw new Subscription('anonymous users are not allowed to subscribe to groups!');
	}
	$sql = $db->prepare("SELECT * FROM groups WHERE group_name=:group AND group_user_email=:creator");
	$sql->bindValue(':group', $group);
	$sql->bindValue(':creator', $creator);
	$sql->execute();
	
	if($sql->rowCount() != 1){
		throw new Subscription('Group not found');
	}
	$row = $sql->fetch();
	if($key != $row['group_key']){
		throw new Subscription('Key is incorrect');
	}
	
	$sql = $db->prepare("SELECT * FROM groupusers WHERE groupuser_group_name=:group AND groupuser_user_email_user=:user AND groupuser_user_email_group=:creator;");
	$sql->bindValue(':group', $group);
	$sql->bindValue(':user', $_SESSION['email']);
	$sql->bindValue(':creator', $creator);
	$sql->execute();
	if($sql->rowCount() == 1){
		throw new Subscription('Already subscribed to that group!');
	}
	$sql = $db->prepare("INSERT INTO groupusers (groupuser_group_name, groupuser_user_email_user, groupuser_verified, groupuser_user_email_group) VALUES (:group, :user, :verified, :creator);");
	$sql->bindValue(':group', $group);
	$sql->bindValue(':user', $_SESSION['email']);
	$sql->bindValue(':creator', $creator);
	$sql->bindValue(':verified', 'true');
	$sql->execute();
}

/*
	Displays all possible groups you can subscribe to
	Authored by: Dylan
*/
function displayPossibleSubscriptions($db){
	$sql = $db->prepare("SELECT * FROM groups WHERE NOT :user IN (SELECT groupuser_user_email_user FROM groupusers WHERE group_name=groupuser_group_name AND group_user_email=groupuser_user_email_group);");
	$sql->bindValue(':user', $_SESSION['email']);
	$sql->execute();
	$groups = $sql->fetchAll();
	if($sql->rowCount() == 0){
		echo '<li><h4>No Groups to subscribe to!</h4></li>';
	}
	foreach($groups as $group){
		echo '<li><form action="control/group_subscribe.php" method="POST" data-ajax="false">'.$group['group_name'].'
				<input type="hidden" name="groupcreator" value="'.$group['group_user_email'].'">
				<input type="hidden" name="groupname" value="'.$group['group_name'].'">
				<input type="text" name="groupkey" placeholder="Group Password" required>
				<input type="submit" name="submit" value="Subscribe">
			</form></li>';
	}
}

/*
	Returns the current error to display the current error message.
	Authored by: Dylan
*/
function currentError(){
	if(!empty($_SESSION['error'])){
		echo $_SESSION['error'];
		$_SESSION['error'] = '';
	}
}

/*
	Outputs a consitent header on all our pages.
	Authored by: Jason
*/
function boilerPlate(){
	echo '
		<title>WebClicker</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<title>
			WebClicker
		</title>
		<link rel="stylesheet" href="themes/WebClicker_main.css" />
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile.structure-1.3.2.min.css" />
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>

		<!-- Import fonts and apply them -->
		<link href="http://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet" type="text/css">
		<link href="http://fonts.googleapis.com/css?family=Droid+Sans+Mono" rel="stylesheet" type="text/css">
		<style>
			*{font-family: "Open Sans", sans-serif; font-size: 1em;}
			.code{font-family: "Droid Sans Mono", monospace; font-size: 1em; margin: auto;}
		</style>
		';
}

/*
	Outputs the popup account menu,
	Authored by: Dylan
*/
function outputAccountMenu(){
	echo '<div data-role="panel" data-display="overlay" data-position="right" id="popupAccount"">
			<ul data-role="listview" data-mini="true">
				<li>'.loggedInUser().'</li>';
	if(userLoggedIn()){
		echo '<li><a href="group_manage.php" data-ajax="false">Manage</a></li>';
		echo '<li><a href="group_feed.php" data-ajax="false">Feed</a></li>';
		echo '<li><a href="control/user_signout.php" data-ajax="false">Sign Out</a></li>';
	}else{
		echo '<li><a href="user_signin.php" data-ajax="false">Sign In</a></li>';
		echo '<li><a href="user_signup.php" data-ajax="false">Sign Up</a></li>';
	}
	
	echo 	'</ul>
		</div>';
}

/*
	Outputs the search panel on all our pages.
	Authored by: Brady
*/
function outputSearchPanel(){
	$db = db_getpdo(); //no db creation should be allowed from functions, only control modules.. this is not safe
	echo '
		 <div data-role="panel" data-display="overlay" data-position="left" id="searchPanel" data-theme="b">	
			    <div class="panel-content">
			     	<h2>Search by Name</h2>
				<ul data-role="listview" data-filter="true" data-filter-reveal="true" data-filter-placeholder="Search Poll by Name...">';
				displaySearchablePolls($db); //this is not safe
	echo '
				</ul>
			    </div><!-- /content wrapper for padding -->
			  </div><!-- /defaultpanel -->
	';
}

/*
	Outputs a consitent footer on all our pages.
	Authored by: Brady
*/
function drawHeader(){
	$gravURL = getGravatarURL(42);
		echo '
			<div data-role="header" data-id="persistentheader" data-position="fixed" data-tap-toggle="false">
				<a href="#searchPanel" data-icon="search" class="ui-btn-left">Search</a>
				<a href ="#popupAccount" data-role="none" class="ui-btn-right"><img border="0" src="'.$gravURL.'" alt="gravatar" /></a>
				<h1>Web Clicker</h1>
			</div><!-- /header -->';
}


/*
	Outputs a consitent footer on all our pages.
	Authored by: Brady
*/
function outputFooter(){
	echo '
		<div data-role="footer" data-id="persistentfooter" data-position="fixed" data-tap-toggle="false">	
			<div data-role="navbar" data-iconpos="top">
				<ul>
					<li><a href="index.php" data-icon="home" data-ajax="false">Home</a></li>
					<li><a href="poll_create.php" data-icon="plus" data-ajax="false">New Poll</a></li>
					<li><a href="#popupPoll" data-rel="popup" data-icon="gear">To Poll</a></li>
					<li><a href="about.php" data-icon="info" data-ajax="false">About</a></li>
				</ul>
			</div><!-- /navbar -->
			<div data-role="popup" id="popupPoll" class="ui-content">
				<p>Enter Access Code:</p>
				<input id="accessCode" type="text" name="accessCode" placeholder="eg: twx29">
				<input data-mini="true" data-role="button" type="submit" name="submit" value="Go" onclick="goToPoll()">
				<script>
					function goToPoll() {
						var code = $(\'#accessCode\').val();
						window.location = \'/poll_take.php?accessCode=\' + code;
					}
				</script>
			</div>
		</div><!-- /footer -->
	';
	outputAccountMenu();
	outputSearchPanel();
}

/*
	Returns whether the user is logged in or not
	Authored by: Dylan
*/
function userLoggedIn(){
	return ($_SESSION['email'] != 'anonymous@anonymous.com');
}
?>

