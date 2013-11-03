<?php
include_once('functions.php');

if(!isset($_POST) || empty($_POST['email']) || empty($_POST['password'])){
	header("location:index.php");
}else{
	try{
		signIn($_POST['email'], $_POST['password']);
		//success
		echo "success";
	}catch(Credentials $e){
		echo "Caught IncorrectCredentials ('{$e->getMessage()}')\n{$e}\n";
	}catch(Authorization $e){
		echo "Caught AccountNotAuthorized ('{$e->getMessage()}')\n{$e}\n";
	}catch(PDOException $e){
		echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
	}
}
?>