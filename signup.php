<?php
require_once('functions.php');

if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['email']) && isset($_POST['password']) && isset($_POST['alias'])){
	try{
		signUp($_POST['email'], $_POST['password'], $_POST['alias']);
		//$message = 'We have sent you an authorization e-mail. Please check your junk/spam folders and follow the link provided in the e-mail to login to your account.';
		//header("location:index.php#signInPage");
		signIn($_POST['email'], $_POST['password']);  //sign them in automatically since we disable authorization
		subscribe('Public', 'anonymous@anonymous.com', 100); //subscribe them to the public polls group
		header("location:index.php");
	}catch(Account $e){
		//echo "Caught Account ('{$e->getMessage()}')\n{$e}\n";
		$_SESSION['error'] = $e->getMessage();
		header("location:index.php?error=Email%20already%20exists.#signUpPage");
	}catch(PDOException $e){
		//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
		$_SESSION['error'] = $e->getMessage();
		header("location:error.php");
	}
}else{
	header("location:index.php");
}
?>