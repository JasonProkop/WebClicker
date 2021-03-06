<?php
	require_once('../include/functions.php');
	include_once('../include/db.php');
	
	if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['groupname']) && isset($_POST['groupcreator'])){
		try{
			$db = db_getpdo();
			$db->beginTransaction();
			unsubscribe($db, $_POST['groupname'], $_POST['groupcreator']);
			$db->commit();
			header("location:../group_manage.php");
		}catch(Subscription $e){
			setError($e->getMessage());
			header("location:../error.php");
		}catch(PDOException $e){
			$db->rollBack();
			setError($e->getMessage());
			header("location:../error.php");
		}
	}else{
		header("location:../index.php");
	}
?>