<?php
require_once('functions.php');

if($_SERVER['REQUEST_METHOD'] == 'POST'){
	try{
		var_dump($_POST);
		$db = db_getpdo();
		$db->beginTransaction();
		while(list($key, $value) = each($_POST['questions'])){
			$sql = $db->prepare("INSERT INTO \"Responses\" (\"response_response\", \"response_question_id\", \"response_poll_id\", \"response_Email\") VALUES (:response, :question, :poll, :email);");
			$sql->bindValue(':question', $key);
			$sql->bindValue(':response', $value);
			$sql->bindValue(':poll', $_POST['poll_id']);
			$sql->bindValue(':email', $_SESSION['email']);
			$sql->execute();
		}
		$db->commit(); //success
		header("location:results.php?accessCode=".$_POST['poll_id']);
	}catch(PDOException $e){
		//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
		$_SESSION['error'] = $e->getMessage();
		header("location:error.php");
	}
}else{
	header("location:index.php");
}
?>