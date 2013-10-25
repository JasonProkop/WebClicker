<?php
include_once('db.php');

/*
	Generates a random access code for accessing polls. 
	A random string of characters in the charset with a length of 5
*/
function generateAccessCode($length=5){
	$charset = array("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
	$code = "";
	randomize();
	$rand_keys = array_rand($charset, $length);
	$accessCode = '';
	for($i = 0; $i < $length; $i++)
	{
		$accessCode .= $charset[$rand_keys[$i]];
	}
	return $accessCode;
}

// seed with microseconds
function randomize()
{
  list($usec, $sec) = explode(' ', microtime());
  srand((float) $sec + ((float) $usec * 100000));
}

function authorizeUser($email){
	try{
		$db = db_getpdo();
		$db->beginTransaction();
		//should check for existing user here and return proper error code
		$sql = $db->prepare("SELECT \"Authorized\" FROM \"Users\" WHERE \"Email\"=:email;");
		$sql->bindValue(':email', $db->quote($email));
		$sql->execute();
		if($sql->rowCount() > 0){
			//there is a user with that email
			$user = $sql->fetch();
			//check if authorized
			//update the credentials
			$sql = $db->prepare("UPDATE \"Users\" SET \"Authorized\"='true' WHERE \"Email\"=:email;");
			$sql->bindValue(':email', $db->quote($email));
			//echo "authorizing";
			$sql->execute();
			$db->commit();
		}else{
			//no user with that email exists so lets make a new one
			//echo "no user with that email to authorize";
			header("location:index.php?error=004");
		}
	}catch(PDOException $e){
		//print $e->getMessage(); //should print this to an error log.
		header("location:index.php?error=002");
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
*/
function signUp($email, $password, $alias){
	randomize();
	$salt = rand(0, 100000);
	$hash = sha1($password . $salt);
	try{
		$db = db_getpdo();
		$db->beginTransaction();
		//should check for existing user here and return proper error code
		$sql = $db->prepare("SELECT \"Authorized\" FROM \"Users\" WHERE \"Email\"=:email;");
		$sql->bindValue(':email', $db->quote($email));
		$sql->execute();
		if($sql->rowCount() > 0){
			//there is a user with that email already
			$user = $sql->fetch();
			//check if authorized
			if($user['Authorized'] == 'true'){
				//duplicate email error
				//echo "duplicate email";
				//exit();
				header("location:index.php?error=001");
			}else{
				//update the credentials
				$sql = $db->prepare("UPDATE \"Users\" SET \"Hash\"=:hash, \"Salt\"=:salt, \"Alias\"=:alias, \"Authorized\"=:authorized WHERE \"Email\"=:email;");
				//echo "updating credents";
			}
		}else{
			//no user with that email exists so lets make a new one
			echo "making new user";
			$sql = $db->prepare("INSERT INTO \"Users\" (\"Email\", \"Hash\", \"Salt\", \"Alias\", \"Authorized\") VALUES (:email, :hash, :salt, :alias, :authorized);");
		}
		$sql->bindValue(':email', $db->quote($email));
		$sql->bindValue(':alias', $db->quote($alias));
		$sql->bindValue(':authorized', 'false');
		$sql->bindValue(':hash', $hash);
		$sql->bindValue(':salt', $salt);
		$sql->execute();
		$db->commit();
		
		header("location:index.php");
	}catch(PDOException $e){
		//print $e->getMessage(); //should print this to an error log.
		header("location:index.php?error=002");
	}
}

function sendAuthorizationEmail($email)
{
	$subject = 'Webclicker Authorization Link';
	$link = 'http://webclicker.tk/authorize.php?email='.$email;
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
	$headers .= 'To: Mary <'.$email.'>' . "\r\n";
	$headers .= 'From: Webclicker Support <support@webclicker.tk>' . "\r\n";

	// Mail it
	mail($email, $subject, $message, $headers);
}
/*
	Displays what user is logged in or anonymous if no user is currently logged in.
*/
function userBar(){
	//check session and such
}

/*

*/
function errorHandler(){
	if(isset($_GET) && !empty($_GET['error'])){
		switch($_GET['error']){
			case 000:
				$error = 'Everything starts at 0.';
				break;
			case 001:
				$error = 'User with that email already exists';
				break;
			case 002:
				$error = 'Database error, try again later';
				break;
			case 003:
				$error = 'Incorrect user credentials';
				break;
			case 004:
				$error = 'Unable to authorize the given account.';
				break;
			default:
				$error = 'unrecognized error code';
		}
		echo "<h2>$error</h2>";
	}
}

function loggedInUser()
{
	return 'anonymous';
	//return 'dylan';
}
/*

*/
function signOut(){
	if(!isset($_SESSION)) {
		session_start();
	}
	// Delete all the values (dont try to unset $_SESSION)
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
*/
function signIn($alias, $password){
	try{
		$db = db_getpdo();
		$sql = $db->prepare("SELECT \"Salt\", \"Hash\" FROM \"Users\" WHERE \"Alias\"=:alias OR \"Email\"=:alias;");
		$sql->bindValue(':alias', $db->quote($alias));
		$db->beginTransaction();
		$sql->execute();
		$db->commit();
		if($sql->rowCount() == 1){
			$user = $sql->fetch();
			if(sha1($password . $user['Salt']) === $user['Hash']){
				if(isset($_SESSION)) {
					 signOut();
				}else{
					session_start();
				}
				$_SESSION['anonymous'] = 'false';
				$_SESSION['alias'] = $alias;
				//echo "logged in!";
				header("location:index.php");
				//exit();
			}
		}
		header("location:index.php?error=003#signInPage");
		//echo 'failed signing in';
	}catch(PDOException $e){
		//print $e->getMessage(); //should print this to an error log.
		header("location:index.php?error=002#signInPage");
	}

}
//sendAuthorizationEmail("fafmaster@hotmail.com");
//testing signup
/*
signUp('dylan@cool.com', '874923749328749', 'i am a new dylan');
signIn('dylan@cool.com', 'sdsad');
signIn('dylan@cool.com', '874923749328749');
authorizeUser('dylan@cool.com');
signUp('dylan@cool.com', '3424234', 'this should not work');
signOut();
*/
?>