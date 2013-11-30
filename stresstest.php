<!-- 	WebClicker.tk/group_manage.php
	Developers: Dylan Fafard, Brady Smith, Jason Prokop, Bo Don, Max Gooding
	Stress test that signs up 10000 users
--> 

<?php
	include_once('include/functions.php');
	include_once('include/db.php');
	$db = db_getpdo();
	$db->beginTransaction();
	$password = 'password';
	$alias = '';
	for($i = 0; $i < 10000; $i++){
		try{
			signUp($db, randemail(), $password, $alias);
		}catch(Exception $e){
			echo $e->getMessage();
		}
	}
	
	$db->rollBack();
	echo 'success';
	function generateRandomString($length = 10) {
		$characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$randomString = '';
		for ($i = 0; $i < $length; $i++) {
			$randomString .= $characters[rand(0, strlen($characters) - 1)];
		}
		return $randomString;
	}
	
	function randemail(){
		return generateRandomString() . '@' . generateRandomString(5) . '.' . generateRandomString(3);
	}
?>