<?php
	require_once('../include/functions.php');

	if($_SERVER['REQUEST_METHOD'] == 'POST'){
		try{
			$poll = Poll::createFromPOST($_POST);
			$access = generateAccessCode();
			$poll->insert(db_getpdo(), $access);	
			header("location:../poll_details.php?accessCode=".$access);
		}catch(PollCreationError $e){
			$_SESSION['error'] = $e->getMessage();
			header("location:../poll_create.php");
		}catch(QuestionCreationError $e){
			$_SESSION['error'] = $e->getMessage();
			header("location:../poll_create.php");
		}catch(PDOException $e){
			$_SESSION['error'] = $e->getMessage();
			header("location:../error.php");
		}
	}else{
		header("location:../index.php");
	}
?>