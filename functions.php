<?php
include_once('db.php');
include_once('exception.php');
include_once('classes.php');

//set up the exceptions
class Account extends CustomException {} //'User with that e-mail already exists.'
class Credentials extends CustomException {} //'Incorrect user credentials.'
class Authorization extends CustomException {} //'Account is not authorized.'
class PollNotFound extends CustomException {} //'Poll is not in database.'
class MalformedAccessCode extends CustomException {} //'Access code is malformed.'

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

/*
    Generates a random access code for accessing polls. 
    A random string of characters in the charset with a given length (default 5)
	
	Authored by: Dylan
*/
function generateAccessCode($length=5){
    $charset = array("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
    $code = "";
    randomize();
	do{
		$rand_keys = array_rand($charset, $length);
		$accessCode = '';
		for($i = 0; $i < $length; $i++)
		{
			$accessCode .= $charset[$rand_keys[$i]];
		}
		$db = db_getpdo();
		$db->beginTransaction();
		$sql = $db->prepare("SELECT * FROM \"Polls\" WHERE \"poll_id\"=:access;");
		$sql->bindValue(':access', $accessCode);
		$sql->execute();
	}while($sql->rowCount() > 0);
	$db->commit();
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
function authorizeUser($email, $key){
	$db = db_getpdo();
	$db->beginTransaction();
	$sql = $db->prepare("SELECT \"Authorized\", \"Email\", \"Salt\" FROM \"Users\" WHERE \"Email\"=:email LIMIT 1;");
	$sql->bindValue(':email', $email);
	$sql->execute();
	if($sql->rowCount() == 1){
		//there is a user with that email
		$user = $sql->fetch();
		if($key === sha1($user['Email'] . $user['Salt'])){
			//correct authorization link. authorize the e-mail
			$sql = $db->prepare("UPDATE \"Users\" SET \"Authorized\"='true' WHERE \"Email\"=:email;");
			$sql->bindValue(':email', $email);
			$sql->execute();
			$db->commit();
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
	
	Authored by: Dylan
*/

function signUp($email, $password, $alias){
    randomize();
	$salt = rand(0, 100000);
	$hash = sha1($password . $salt);
	$db = db_getpdo();
	$db->beginTransaction();
	$sql = $db->prepare("SELECT \"Authorized\" FROM \"Users\" WHERE \"Email\"=:email;");
	$sql->bindValue(':email', $email);
	$sql->execute();
	if($sql->rowCount() > 0){
		//there is a user with that email already
		$user = $sql->fetch();
		if($user['Authorized'] == 'true'){
			throw new Account('Duplicate e-mail.');
		}else{
			$sql = $db->prepare("UPDATE \"Users\" SET \"Hash\"=:hash, \"Salt\"=:salt, \"Alias\"=:alias, \"Authorized\"=:authorized WHERE \"Email\"=:email;");
		}
	}else{
		//no user with that email exists so lets make a new one
		$sql = $db->prepare("INSERT INTO \"Users\" (\"Email\", \"Hash\", \"Salt\", \"Alias\", \"Authorized\") VALUES (:email, :hash, :salt, :alias, :authorized);");
	}
	$sql->bindValue(':email', $email);
	$sql->bindValue(':alias', $alias);
	//$sql->bindValue(':authorized', 'false');
	$sql->bindValue(':authorized', 'true'); //this is being used for testing. change to above line in production
	$sql->bindValue(':hash', $hash);
	$sql->bindValue(':salt', $salt);
	$sql->execute();
	$db->commit();
	
	sendAuthorizationEmail($email, $salt);
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
function signIn($email, $password){
	$db = db_getpdo();
	$sql = $db->prepare("SELECT * FROM \"Users\" WHERE \"Email\"=:email LIMIT 1;");
	$sql->bindValue(':email', $email);
	$db->beginTransaction();
	$sql->execute();
	$db->commit();
	
	if($sql->rowCount() == 1){
		$user = $sql->fetch();
		if(!(bool)$user['Authorized']){
			throw new Authorization('Account is not yet authorized.');
		}
		if(sha1($password . $user['Salt']) === $user['Hash']){
			$_SESSION['email'] = $user['Email'];
			$_SESSION['alias'] = $user['Alias'];
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
function search($access){
	$db = db_getpdo();
	$sql = $db->prepare("SELECT * FROM \"Polls\" WHERE \"poll_id\"=:access;");
	$sql->bindValue(':access', $access);
	$db->beginTransaction();
	$sql->execute();
	$db->commit();
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
function userTakenPoll($poll){
	if($_SESSION['email'] == 'anonymous@anonymous.com'){
			return false;
	}else{
		$db = db_getpdo();
		$sql = $db->prepare("SELECT * FROM \"Responses\" WHERE \"response_Email\"=:email AND \"response_poll_id\"=:poll;");
		$sql->bindValue(':email', $_SESSION['email']);
		$sql->bindValue(':poll', $poll);
		$db->beginTransaction();
		$sql->execute();
		$db->commit();
		return($sql->rowCount() > 0);
	}
}

/*
	Grabs the 10 most recent polls from the database to display on the homepage
	Authored by: Dylan
*/
function displayRecentPolls(){
	try{
	
		$db = db_getpdo();
		$sql = $db->prepare("SELECT * FROM \"Polls\" ORDER BY poll_date_created DESC LIMIT 10;");
		$db->beginTransaction();
		$sql->execute();
		$db->commit();
		$polls = $sql->fetchAll();
		foreach($polls as $poll){
			echo '<li><a href="poll.php?accessCode='.$poll['poll_id'].'" data-ajax="false">'.$poll['poll_name'].' - '.$poll['poll_id'].'</a></li>';
		}
	}catch(PDOException $e){
		echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
	}
}

/*
	Generates the proper data array for jqPlot to make a bar/pie graph out of from a single question.
	Authored by: Dylan/Jason
*/
function questionTojQplot($question){
	$responses = array();
	foreach($question->Responses as $response){
		$responses[] = $response->Response;
	}
	$data = array();
	$responses = array_count_values($responses);
	while (list($key, $val) = each($responses) ){
		$data[] = array($key, $val);
	}
	return json_encode($data);
}

?>