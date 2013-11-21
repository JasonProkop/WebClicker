<?php
	require_once('../include/functions.php');

	if(isset($_GET['accessCode'])){
		try{
			validAccessCode($_GET['accessCode']);
			$poll = searchPoll($_GET['accessCode']);
			if($_SESSION['email'] == $poll->Creator){
				$db = db_getpdo();
				$db->beginTransaction();
				
				$sql = $db->prepare("UPDATE polls SET poll_active='false' WHERE poll_id=:access;");
				$sql->bindValue(':access', $poll->AccessCode);
				$sql->execute();
				
				$db->commit();
				header('Location:../poll_details.php?accessCode='.$poll->AccessCode);
			}
		}catch (PollNotFound $e) {
			$_SESSION['error'] = $e->getMessage();
			header("location:../error.php");
		}catch(PDOException $e){
			$_SESSION['error'] = $e->getMessage();
			header("location:../error.php");
		}catch(MalformedAccessCode $e){
			$_SESSION['error'] = $e->getMessage();
			header("location:../error.php");
		}
	}else{
		header("location:../index.php");
	}
?>