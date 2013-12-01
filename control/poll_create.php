<?php
	require_once('../include/functions.php');
	include_once('../include/db.php');
	
	if($_SERVER['REQUEST_METHOD'] == 'POST'){
		try{
			$poll = Poll::createFromPOST($_POST);
			
			$db = db_getpdo();
			$access = generateAccessCode($db);
			$db->beginTransaction();
			$poll->insert($db, $access);
			$db->commit();
			$db = null;
			header("location:../poll_details.php?accessCode=".$access);
		}catch(PollCreationError $e){
			setError($e->getMessage());
			header("location:../poll_create.php");
		}catch(QuestionCreationError $e){
			setError($e->getMessage());
			header("location:../poll_create.php");
		}catch(PDOException $e){
			$db->rollBack();
			setError($e->getMessage());
			header("location:../error.php");
		}
	}else{
		header("location:../index.php");
	}
?>