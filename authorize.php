<?php
include_once('functions.php');

if(isset($_GET['email']) && isset($_GET['key'])){
	try{
		authorizeUser($_GET['email'], $_GET['key']);
		echo 'success';
	}catch(Authorization $e){
		echo "Caught Authorization ('{$e->getMessage()}')\n{$e}\n";
	}catch(PDOException $e){
		echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
	}
}else{
	header("location:index.php");
}
?>