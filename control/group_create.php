<?php
	require_once('../include/functions.php');
	include_once('../include/db.php');
	
	if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['groupname']) && isset($_POST['groupkey'])){
		try{
			$db = db_getpdo();
			$db->beginTransaction();
			createGroup($db, $_POST['groupname'], $_POST['groupkey']);
			subscribe($db, $_POST['groupname'], $_SESSION['email'], $_POST['groupkey']);
			$db->commit();
			header("location:../group_manage.php");
		}catch(Subscription $e){
			$db->rollBack();
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