<?php
require_once('functions.php');

if($_SERVER['REQUEST_METHOD'] == 'POST'){
	try{
		var_dump($_POST);
		$db = db_getpdo();
		$db->beginTransaction();
		while(list($key, $value) = each($_POST['questions'])){ //for each response
			if(is_array($value)){ //if the question was a checkbox multiple responses
				while(list($ikey, $ivalue) = each($value)){ //for all checkbox responses
					insertResponse($db, $key, $ivalue); 
				}
			}else{
				if(!empty($value)){
					insertResponse($db, $key, $value);
				}
			}
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

/*
	Inserts a single response into the database.
	Authored by: Dylan
*/
function insertResponse($db, $question, $response){
	$sql = $db->prepare("INSERT INTO responses (response_response, response_question_id, response_poll_id, response_user_email) VALUES (:response, :question, :poll, :email);");
			$sql->bindValue(':question', $question);
			$sql->bindValue(':response', $response);
			$sql->bindValue(':poll', $_POST['poll_id']);
			$sql->bindValue(':email', $_SESSION['email']);
			$sql->execute();
}
?>