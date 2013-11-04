<?php
include_once('functions.php');

if($_SERVER['REQUEST_METHOD'] == 'POST') && isset($_POST['email']) && isset($_POST['password'])){
	try{
		signIn($_POST['email'], $_POST['password']);
		echo "success";
	}catch(Credentials $e){
		echo "Caught IncorrectCredentials ('{$e->getMessage()}')\n{$e}\n";
	}catch(Authorization $e){
		echo "Caught AccountNotAuthorized ('{$e->getMessage()}')\n{$e}\n";
	}catch(PDOException $e){
		echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
	}
}else{
	header("location:index.php");
}
?>