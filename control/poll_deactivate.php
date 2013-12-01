<?php
	require_once('../include/functions.php');
	include_once('../include/db.php');
	
	if(isset($_GET['accessCode'])){
		try{
			validAccessCode($_GET['accessCode']);
			$db = db_getpdo();
			$poll = searchPoll($db, $_GET['accessCode']);
			$db->beginTransaction();
			deactivatePoll($db, $poll->Creator, $poll->AccessCode);
			$db->commit();
			header('Location:../poll_details.php?accessCode='.$poll->AccessCode);
		}catch (Activation $e) {
			setError($e->getMessage());
			header("location:../error.php");
		}catch (PollNotFound $e) {
			setError($e->getMessage());
			header("location:../error.php");
		}catch(PDOException $e){
			$db->rollBack();
			setError($e->getMessage());
			header("location:../error.php");
		}catch(MalformedAccessCode $e){
			setError($e->getMessage());
			header("location:../error.php");
		}
	}else{
		header("location:../index.php");
	}
?>