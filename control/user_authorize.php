<?php
	require_once('../include/functions.php');
	require_once('../include/db.php');

	if(isset($_GET['email']) && isset($_GET['key'])){
		try{
			$db = db_getpdo();
			$db->beginTransaction();
			authorizeUser($db, $_GET['email'], $_GET['key']);
			$db->commit();
			header("location:../user_signin.php");
		}catch(Authorization $e){
			$_SESSION['error'] = $e->getMessage();
			header("location:../error.php");
		}catch(PDOException $e){
			$db->rollBack();
			$_SESSION['error'] = $e->getMessage();
			header("location:../error.php");
		}
	}else{
		header("location:../index.php");
	}
?>