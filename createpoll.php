<?php
require_once('functions.php');

if($_SERVER['REQUEST_METHOD'] == 'POST'){
	try{
		//var_dump($_POST);
		$poll = Poll::createFromPOST($_POST);
		$access = generateAccessCode();
		$poll->insert(db_getpdo(), $access);	
		header("location:polldetails.php?accessCode=".$access);
	}catch(PollCreationError $e){
		$_SESSION['error'] = $e->getMessage();
		header("location:create.php");
	}catch(QuestionCreationError $e){
		$_SESSION['error'] = $e->getMessage();
		header("location:create.php");
	}catch(PDOException $e){
		$_SESSION['error'] = $e->getMessage();
		header("location:error.php");
	}
}else{
	header("location:index.php");
}
?>