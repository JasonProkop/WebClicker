<?php
require_once('functions.php');

if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['email']) && isset($_POST['password'])){
	try{
		signIn($_POST['email'], $_POST['password']); 
		header("location:user.php"); //success
	}catch(Credentials $e){
		//echo "Caught IncorrectCredentials ('{$e->getMessage()}')\n{$e}\n";
		$_SESSION['error'] = $e->getMessage();
		header("location:index.php#signInPage");
	}catch(Authorization $e){
		//"Caught AccountNotAuthorized ('{$e->getMessage()}')\n{$e}\n";
		$_SESSION['error'] = $e->getMessage();
		header("location:error.php");
	}catch(PDOException $e){
		//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
		$_SESSION['error'] = $e->getMessage();
		header("location:error.php");
	}
}else{
	header("location:index.php");
}
?>