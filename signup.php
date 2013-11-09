<?php
require_once('functions.php');

if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['email']) && isset($_POST['password']) && isset($_POST['alias'])){
	try{
		signUp($_POST['email'], $_POST['password'], $_POST['alias']);
		//$message = 'We have sent you an authorization e-mail. Please check your junk/spam folders and follow the link provided in the e-mail to login to your account.';
		header("location:index.php#signInPage");
	}catch(Account $e){
		//echo "Caught Account ('{$e->getMessage()}')\n{$e}\n";
		$_SESSION['error'] = $e->getMessage();
		header("location:index.php#signUpPage");
	}catch(PDOException $e){
		//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
		$_SESSION['error'] = $e->getMessage();
		header("location:error.php");
	}
}else{
	header("location:index.php");
}
?>