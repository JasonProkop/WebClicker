<?php
require_once('functions.php');

if(isset($_GET['accessCode'])){
	try{
		validAccessCode($_GET['accessCode']);
		$poll = searchPoll($_GET['accessCode']);
		if($_SESSION['email'] == $poll->Creator){
			$db = db_getpdo();
			$db->beginTransaction();
			
			$sql = $db->prepare("UPDATE polls SET poll_active='true' WHERE poll_id=:access;");
			$sql->bindValue(':access', $poll->AccessCode);
			$sql->execute();
			
			$db->commit();
			header('Location:polldetails.php?accessCode='.$poll->AccessCode);
		}
	}catch (PollNotFound $e) {
		//echo "Poll Not Found";
		$_SESSION['error'] = $e->getMessage();
		header("location:error.php");
	}catch(PDOException $e){
		//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
		$_SESSION['error'] = $e->getMessage();
		header("location:error.php");
	}catch(MalformedAccessCode $e){
		//echo "Caught MalformedAccessCode ('{$e->getMessage()}')\n{$e}\n";
		$_SESSION['error'] = $e->getMessage();
		header("location:error.php");
	}
}else{
	header("location:index.php");
}
?>