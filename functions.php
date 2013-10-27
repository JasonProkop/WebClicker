<?php
include_once('db.php');

// This will be used to handle sessions
if(!isset($_SESSION)) {
    session_start();
}
if(empty($_SESSION['alias'])){
    // set as anonymous
    $_SESSION['alias'] = 'anonymous';
    $_SESSION['email'] = '';
}

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

function authorizeUser($email, $key){
    try{
        $db = db_getpdo();
        $db->beginTransaction();
        //should check for existing user here and return proper error code
        $sql = $db->prepare("SELECT \"Authorized\", \"Email\", \"Salt\" FROM \"Users\" WHERE \"Email\"=:email;");
        $sql->bindValue(':email', $email);
        $sql->execute();
        if($sql->rowCount() == 1){
            //there is a user with that email
            $user = $sql->fetch();
            if($key === sha1($user['Email'] . $user['Salt'])){
                //update the credentials
                $sql = $db->prepare("UPDATE \"Users\" SET \"Authorized\"='true' WHERE \"Email\"=:email;");
                $sql->bindValue(':email', $email);
                $sql->execute();
                $db->commit();
                header("location:index.php#signInPage");
            }else{
                header("location:index.php?error=007");
            }
        }else{
            //no user with that email exists so lets make a new one
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
        $sql->bindValue(':email', $email);
        $sql->execute();
        if($sql->rowCount() > 0){
            //there is a user with that email already
            $user = $sql->fetch();
            //check if authorized
            if($user['Authorized'] == 'true'){
                //duplicate email error
                header("location:index.php?error=001");
            }else{
                //update the credentials
                $sql = $db->prepare("UPDATE \"Users\" SET \"Hash\"=:hash, \"Salt\"=:salt, \"Alias\"=:alias, \"Authorized\"=:authorized WHERE \"Email\"=:email;");
            }
        }else{
            //no user with that email exists so lets make a new one
            $sql = $db->prepare("INSERT INTO \"Users\" (\"Email\", \"Hash\", \"Salt\", \"Alias\", \"Authorized\") VALUES (:email, :hash, :salt, :alias, :authorized);");
            sendAuthorizationEmail($email, $salt);
        }
        $sql->bindValue(':email', $email);
        $sql->bindValue(':alias', $alias);
        $sql->bindValue(':authorized', 'false');
        $sql->bindValue(':hash', $hash);
        $sql->bindValue(':salt', $salt);
        $sql->execute();
        $db->commit();
        //succesfully signed up
        header("location:index.php#signUpPage");
    }catch(PDOException $e){
        //print $e->getMessage(); //should print this to an error log.
        header("location:index.php?error=002");
    }
}


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
	if($_SESSION['alias'] === ''){
		return $_SESSION['email'];
	}else{
		return $_SESSION['alias'];
	}
}

/*

*/
function signOut(){
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
function signIn($email, $password){
    try{
        $db = db_getpdo();
        $sql = $db->prepare("SELECT * FROM \"Users\" WHERE \"Email\"=:alias;");
        $sql->bindValue(':alias', $email);
        $db->beginTransaction();
        $sql->execute();
        $db->commit();
		
        if($sql->rowCount() == 1){
            $user = $sql->fetch();
            if(sha1($password . $user['Salt']) === $user['Hash']){
                if($user['Authorized'] == 'true'){
                    $_SESSION['email'] = $user['Email'];
                    $_SESSION['alias'] = $user['Alias'];
                    //succesfully logged in
                    header("location:index.php");
                }else{
					//acount is not authorized yet
                    header("location:index.php?error=006#signInPage");
                }
            }
        }else{
			//wrong credentials
			header("location:index.php?error=003#signInPage");
		}
    }catch(PDOException $e){
        //print $e->getMessage(); //should print this to an error log.
        header("location:index.php?error=002#signInPage");
    }

}
?>