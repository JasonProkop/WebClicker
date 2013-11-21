<?php
	require_once('../include/functions.php');

	if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['groupname']) && isset($_POST['groupcreator'])&& isset($_POST['groupkey'])){
		try{
			subscribe($_POST['groupname'], $_POST['groupcreator'], $_POST['groupkey']);
			header("location:../group_feed.php");
		}catch(Subscription $e){
			$_SESSION['error'] = $e->getMessage();
			header("location:../error.php");
		}catch(PDOException $e){
			$_SESSION['error'] = $e->getMessage();
			header("location:../error.php");
		}
	}else{
		header("location:../index.php");
	}
?>