<?php
require_once('functions.php');

if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['groupname']) && isset($_POST['groupcreator'])&& isset($_POST['groupkey'])){
	try{
		subscribe($_POST['groupname'], $_POST['groupcreator'], $_POST['groupkey']);
		header("location:groupfeed.php");
	}catch(Subscription $e){
		//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
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