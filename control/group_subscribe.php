<?php
	require_once('../include/functions.php');
	include_once('../include/db.php');

	if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['groupname']) && isset($_POST['groupcreator'])&& isset($_POST['groupkey'])){
		try{
			$db = db_getpdo();
			$db->beginTransaction();
			subscribe($db, $_POST['groupname'], $_POST['groupcreator'], $_POST['groupkey']);
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