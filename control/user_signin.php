<?php
	require_once('../include/functions.php');

	if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['email']) && isset($_POST['password'])){
		try{
			signIn($_POST['email'], $_POST['password']); 
			header("location:../index.php"); //success
		}catch(Credentials $e){
			$_SESSION['error'] = $e->getMessage();
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