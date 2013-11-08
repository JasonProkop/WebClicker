<?php
require_once('functions.php');

if(isset($_GET['email']) && isset($_GET['key'])){
	try{
		authorizeUser($_GET['email'], $_GET['key']);
		header("location:index.php#signInPage");
	}catch(Authorization $e){
		//echo "Caught Authorization ('{$e->getMessage()}')\n{$e}\n";
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