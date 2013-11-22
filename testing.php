<?php
/* 
	Contains all sample data to perform the unit tests in this file.
*/
class UTSampleData{
	public static $email = 'unit@testing.com';
	public static $invalidEmail = 'nope@never.wrong';
	public static $password = 'password';
	public static $invalidPassword = 'wrong';
	public static $alias = 'Unit Tester';
	public static $pollaccess = '#####';
	public static $pollname = 'Unit Test Poll';
	public static $groupname = 'Unit Test Group';
	public static $groupkey = 'groupkey';
	public static $validAccess = 'abc12';
	public static $invalidAccess = 'abc123';
	
	//sample poll to use
	function insertPoll($db){
		$sql = $db->prepare('INSERT INTO polls (poll_id, poll_name, poll_user_email, poll_group_name, poll_group_user_email) VALUES (:access, :name, :user, :groupname, :groupuser);');
		$sql->bindValue(':access', UTSampleData::$pollaccess);
		$sql->bindValue(':name', UTSampleData::$pollname);
		$sql->bindValue(':user', UTSampleData::$email);
		$sql->bindValue(':groupname', UTSampleData::$groupname);
		$sql->bindValue(':groupuser', UTSampleData::$email);
		$sql->execute();
	}
	
	//sets user as anonymous
	function setUserAnonymous(){
		$_SESSION['email'] = 'anonymous@anonymous.com';
		$_SESSION['alias'] = 'Anonymous';
	}
	
	//sets user as sample
	function setUserSample(){
		$_SESSION['email'] = UTSampleData::$email;
		$_SESSION['alias'] = UTSampleData::$alias;
	}
}

include_once('include/functions.php');
include_once('include/db.php');

$db = db_getpdo();
$db->beginTransaction(); //start transaction so we can rollback at the end of this.

	//**** BEGIN 	SIGN UP TESTS **** function signUp($db, $email, $password, $alias)
	
		//try and sign up with empty fields
		try{
			signUp($db, '', '', ''); //this should throw an account exception 
			assert(false); //exception should be thrown!
		}catch(Exception $e){
			assert(get_class($e) == 'Account'); //right exception is thrown
			assert($e->getMessage() == 'Empty e-mail or password fields!'); //right exception is thrown
		}
		
		//sign up with username/password/alias
		try{
			signUp($db, UTSampleData::$email, UTSampleData::$password, UTSampleData::$alias);
			//check database to see if has been successfully added and authorized
			$sql = $db->prepare("SELECT * FROM users WHERE user_email=:email AND user_alias=:alias"); //get user info
			$sql->bindValue(':email', UTSampleData::$email);
			$sql->bindValue(':alias', UTSampleData::$alias);
			$sql->execute();
			assert($sql->rowCount() == 1); //make sure only 1 user is found
			$row = $sql->fetch();
			assert($row['user_hash'] == sha1(UTSampleData::$password . $row['user_salt'])); //make sure the hashes match
		}catch(Exception $e){
			assert(false); //if any exception is thrown then we fail.
		}
		
		//sign up with duplicate email
		try{
			signUp($db, UTSampleData::$email, UTSampleData::$password, UTSampleData::$alias);
			assert(false); //exception should be thrown!
		}catch(Exception $e){
			assert(get_class($e) == 'Account'); //right exception is thrown
			assert($e->getMessage() == 'Duplicate e-mail.'); //right exception is thrown
		}
	//**** END 		SIGN UP TESTS ****
		
	//**** BEGIN 	SIGN IN TESTS **** function signIn($db, $email, $password)
		//try and sign in with incorrect password
		try{
			signIn($db, UTSampleData::$email, UTSampleData::$invalidPassword);
			assert(false); //exception should be thrown!
		}catch(Exception $e){
			assert(get_class($e) == 'Credentials'); //make sure right exception is thrown
			assert($e->getMessage() == 'Incorrect password.'); //make sure right exception is thrown
		}
		
		//try and sign in with incorrect email
		try{
			signIn($db, UTSampleData::$invalidEmail, UTSampleData::$password);
			assert(false); //exception should be thrown!
		}catch(Exception $e){
			assert(get_class($e) == 'Credentials'); //make sure right exception is thrown
			assert($e->getMessage() == 'Incorrect e-mail.'); //make sure right exception is thrown
		}
		
		//try and sign in with sample test data
		try{
			signIn($db, UTSampleData::$email, UTSampleData::$password);
			//check session variables to confirm
			assert($_SESSION['email'] == UTSampleData::$email); //correct email stored
			assert($_SESSION['alias'] == UTSampleData::$alias); //correct alias stored
		}catch(Exception $e){
			assert(false); //if exception is thrown then we fail.
		}
			
	//**** END		SIGN IN TESTS ****

	//**** BEGIN	VALID ACCESS CODE TESTS **** function validAccessCode($access)
		//try with valid access code
		try{
			validAccessCode(UTSampleData::$validAccess);
		}catch(Exception $e){
			assert(false); //if an exception was thrown we fail
		}
		
		//try with invalid access code
		try{
			validAccessCode(UTSampleData::$invalidAccess);
			assert(false); //exception should be thrown!
		}catch(Exception $e){
			assert(get_class($e) == 'MalformedAccessCode'); //make sure right exception is thrown
			assert($e->getMessage() == 'Access code is malformed'); //make sure right exception is thrown
		}
	//**** END		VALID ACCESS CODE TESTS ****
	
	//**** BEGIN	CREATE GROUP TESTS **** function createGroup($db, $name, $key)
		//create a group
		createGroup($db, UTSampleData::$groupname, UTSampleData::$groupkey);
		
		//check database
		$sql = $db->prepare('SELECT * FROM groups WHERE group_name=:name AND group_key=:key AND group_user_email=:email');
		$sql->bindValue(':name', UTSampleData::$groupname);
		$sql->bindValue(':key', UTSampleData::$groupkey);
		$sql->bindValue(':email', UTSampleData::$email);
		$sql->execute();
		assert($sql->rowCount() == 1); //make sure we find the group we just created
		$row = $sql->fetch();
		assert($row['group_name'] == UTSampleData::$groupname); //correct group name
		assert($row['group_key'] == UTSampleData::$groupkey); //correct group key
		assert($row['group_user_email'] == UTSampleData::$email); //correct owner
		
	//**** END		CREATE GROUP TESTS **** function createGroup($db, $name, $key)
	
	UTSampleData::insertPoll($db); //insert a poll manually into the database to use for testing the rest of the functions
	
	//**** BEGIN	SEARCH POLL TESTS **** function searchPoll($db, $access)
		//try with known poll
		try{
			$poll = searchPoll($db, UTSampleData::$pollaccess);
			assert($poll->Name == UTSampleData::$pollname);
		}catch(Exception $e){
			assert(false); //no exception should be thrown
		}
		//try with unknown poll
		try{
			$poll = searchPoll($db, UTSampleData::$validAccess);
			assert(false); //exception should be thrown!
		}catch(Exception $e){
			assert(get_class($e) == 'PollNotFound'); //make sure right exception is thrown
			assert($e->getMessage() == "Poll Doesn't Exist"); //make sure right exception is thrown
		}
	//**** END		SEARCH POLL TESTS ****

	
	//**** BEGIN	DEACTIVATE POLL TESTS **** function deactivatePoll($db, $creator, $accessCode)
		//try as non-creator
		UTSampleData::setUserAnonymous(); //sets current user as anonymous
		try{
			deactivatePoll($db, UTSampleData::$email, UTSampleData::$pollaccess);
			assert(false); //exception should be thrown!
		}catch(Exception $e){
			assert(get_class($e) == 'Activation'); //make sure right exception is thrown
			assert($e->getMessage() == 'Only the creator of a poll can deactivate it.'); //make sure right exception is thrown
		}
		
		//try as creator
		UTSampleData::setUserSample(); //sets the current user as the sample one created above
		signIn($db, UTSampleData::$email, UTSampleData::$password);
		try{
			deactivatePoll($db, UTSampleData::$email, UTSampleData::$pollaccess);
			//check database
			$sql = $db->prepare('SELECT * FROM polls WHERE poll_id=:access');
			$sql->bindValue(':access', UTSampleData::$pollaccess);
			$sql->execute();
			assert($sql->rowCount() == 1);
			$row = $sql->fetch();
			assert(!(bool)$row['poll_active']); //make sure we deactivated it
		}catch(Exception $e){
			assert(false); //no exception should be thrown
		}
	//**** END		DEACTIVATE POLL TESTS ****
	
	//**** BEGIN	ACTIVATE POLL TESTS **** function activatePoll($db, $creator, $accessCode){
		//try as non-creator
		UTSampleData::setUserAnonymous(); //sets current user as anonymous
		try{
			deactivatePoll($db, UTSampleData::$email, UTSampleData::$pollaccess);
			assert(false); //exception should be thrown!
		}catch(Exception $e){
			assert(get_class($e) == 'Activation'); //make sure right exception is thrown
			assert($e->getMessage() == 'Only the creator of a poll can deactivate it.'); //make sure right exception is thrown
		}
		
		//try as creator
		UTSampleData::setUserSample(); //sets the current user as the sample one created above
		signIn($db, UTSampleData::$email, UTSampleData::$password);
		try{
			activatePoll($db, UTSampleData::$email, UTSampleData::$pollaccess);
			//check database
			$sql = $db->prepare('SELECT * FROM polls WHERE poll_id=:access');
			$sql->bindValue(':access', UTSampleData::$pollaccess);
			$sql->execute();
			assert($sql->rowCount() == 1);
			$row = $sql->fetch();
			assert((bool)$row['poll_active']); //make sure we activated it
		}catch(Exception $e){
			assert(false); //no exception should be thrown
		}
	//**** END		ACTIVATE POLL TESTS ****

	//**** BEGIN	SUBSCRIBE TESTS **** function subscribe($db, $group, $creator, $key)
		//try as anonymous
		UTSampleData::setUserAnonymous(); //sets current user as anonymous
		try{
			subscribe($db, UTSampleData::$groupname, UTSampleData::$email, UTSampleData::$groupkey);
			assert(false); //exception should be thrown!
		}catch(Exception $e){
			assert(get_class($e) == 'Subscription'); //make sure right exception is thrown
			assert($e->getMessage() == 'anonymous users are not allowed to subscribe to groups!'); //make sure right exception is thrown
		}
		
		UTSampleData::setUserSample(); //sets the current user as the sample one created above
		//try with invalid group
		try{
			subscribe($db, UTSampleData::$groupname, UTSampleData::$invalidEmail, UTSampleData::$groupkey);
			assert(false); //exception should be thrown!
		}catch(Exception $e){
			assert(get_class($e) == 'Subscription'); //make sure right exception is thrown
			assert($e->getMessage() == 'Group not found'); //make sure right exception is thrown
		}
		
		//try with valid group but incorrect key
		try{
			subscribe($db, UTSampleData::$groupname, UTSampleData::$email, UTSampleData::$password);
			assert(false); //exception should be thrown!
		}catch(Exception $e){
			assert(get_class($e) == 'Subscription'); //make sure right exception is thrown
			assert($e->getMessage() == 'Key is incorrect'); //make sure right exception is thrown
		}
		
		//try success
		try{
			subscribe($db, UTSampleData::$groupname, UTSampleData::$email, UTSampleData::$groupkey);
			//check database
			$sql = $db->prepare('SELECT * FROM groupusers WHERE groupuser_group_name=:groupname AND groupuser_user_email_group=:creator AND groupuser_user_email_user=:user;');
			$sql->bindValue(':groupname', UTSampleData::$groupname);
			$sql->bindValue(':creator', UTSampleData::$email);
			$sql->bindValue(':user', UTSampleData::$email);
			$sql->execute();
			assert($sql->rowCount() == 1);
			$row = $sql->fetch();
			assert($row['groupuser_group_name'] == UTSampleData::$groupname); //correct group name
			assert($row['groupuser_user_email_group'] == UTSampleData::$email); //correct group owner
			assert($row['groupuser_user_email_user'] == UTSampleData::$email); //correct group user
		}catch(Exception $e){
			assert(false); //no exception should be thrown
		}
		
		//try when already subscribed
		try{
			subscribe($db, UTSampleData::$groupname, UTSampleData::$email, UTSampleData::$groupkey);
			assert(false); //exception should be thrown!
		}catch(Exception $e){
			assert(get_class($e) == 'Subscription'); //make sure right exception is thrown
			assert($e->getMessage() == 'Already subscribed to that group!'); //make sure right exception is thrown
		}
	//**** END		SUBSCRIBE TESTS ****

	//**** BEGIN	SEARCH GROUP TESTS **** function searchGroup($db, $name, $creator)
		//try with known group
		try{
			searchGroup($db, UTSampleData::$groupname, UTSampleData::$email);
		}catch(Exception $e){
			assert(false); //no exception should be thrown
		}
		
		//try with unkown group
		try{
			searchGroup($db, UTSampleData::$groupname, UTSampleData::$invalidEmail);
			assert(false); //exception should be thrown!
		}catch(Exception $e){
			assert(get_class($e) == 'GroupNotFound'); //make sure right exception is thrown
			assert($e->getMessage() == "Group Doesn't exist"); //make sure right exception is thrown
		}
	//**** END		SEARCH GROUP TESTS ****

	//**** BEGIN	UNSUBSCRIBE TESTS **** function unsubscribe($db, $group, $creator)
		UTSampleData::setUserAnonymous();
		//try as anonymous
		try{
			unsubscribe($db, UTSampleData::$groupname, UTSampleData::$email);
			assert(false); //exception should be thrown
		}catch(Exception $e){
			assert(get_class($e) == 'Subscription'); //make sure right exception is thrown
			assert($e->getMessage() == 'anonymous users are not allowed to subscribe to groups!'); //make sure right exception is thrown
		}
		UTSampleData::setUserSample();
		//try as sample user
		
		try{
			unsubscribe($db, UTSampleData::$groupname, UTSampleData::$email);
			//check database
			$sql = $db->prepare('SELECT * FROM groupusers WHERE groupuser_group_name=:groupname AND groupuser_user_email_group=:creator AND groupuser_user_email_user=:user;');
			$sql->bindValue(':groupname', UTSampleData::$groupname);
			$sql->bindValue(':creator', UTSampleData::$email);
			$sql->bindValue(':user', UTSampleData::$email);
			$sql->execute();
			assert($sql->rowCount() == 0);
		}catch(Exception $e){
			assert(false); //no exception should be thrown
		}
	//**** END		UNSUBSCRIBE TESTS ****
	
	//**** BEGIN	SIGN OUT TESTS **** function signOut()
		//sign out and make sure session variable are correct
		signOut();
		assert(!isset($_SESSION['email'])); //cleared email
		assert(!isset($_SESSION['alias'])); //cleared alias
	//**** END		SIGN OUT TESTS ****
	
$db->rollBack(); //remove any changes to the database this test file made	
echo 'Tests Successful';
?>