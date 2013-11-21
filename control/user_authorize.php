<?php
	require_once('../include/functions.php');

	if(isset($_GET['email']) && isset($_GET['key'])){
		try{
			authorizeUser($_GET['email'], $_GET['key']);
			header("location:../user_signin.php");
		}catch(Authorization $e){
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