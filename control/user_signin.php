<?php
	require_once('../include/functions.php');
	include_once('../include/db.php');
	
if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['email']) && isset($_POST['password'])){
	try{
		signIn(db_getpdo(), $_POST['email'], $_POST['password']); 
		header("location:../index.php"); //success
	}catch(Credentials $e){
		setError($e->getMessage());
		header("location:../user_signin.php");
	}catch(Authorization $e){
		setError($e->getMessage());
		header("location:../error.php");
	}catch(PDOException $e){
		setError($e->getMessage());
		header("location:../error.php");
	}
}else{
	header("location:../index.php");
}
?>