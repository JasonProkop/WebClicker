<?php
	require_once('../include/functions.php');
	include_once('../include/db.php');
	
	if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['email']) && isset($_POST['password']) && isset($_POST['alias'])){
		try{
			$db = db_getpdo();
			$db->beginTransaction();
			signUp($db, $_POST['email'], $_POST['password'], $_POST['alias']);
			signIn($db, $_POST['email'], $_POST['password']);  //sign them in automatically since we disable authorization
			subscribe($db, 'Public', 'anonymous@anonymous.com', 100); //subscribe them to the public polls group
			$db->commit();
			header("location:../index.php");
		}catch(Account $e){
			setError($e->getMessage());
			header("location:../user_signup.php");
		}catch(PDOException $e){
			$db->rollBack();
			setError($e->getMessage());
			header("location:../error.php");
		}
	}else{
		header("location:../index.php");
	}
?>