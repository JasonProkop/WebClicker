<?php

/*
	Defines the behaviour we need for database interaction between our objects.
*/
interface iDatabaseFunctions{
	public function insert();
	public function update();
	public function delete();
	public function createFromDB($row, $db);
}

/*
	Defines the behaviour we need for POST creation for our objects.
*/
interface iPostFunctions{
	public function createFromPOST($POST);
}
/**
	Contains Poll name, Access Code, All questions, answers, possible answers, and responses.
**/
class Poll implements iDatabaseFunctions{
	function __construct(){}
	
	/**
		Creates all Question objects that are identified to this poll.
	**/
	function createQuestionsFromDB($db, $obj){
		$sql = $db->prepare("SELECT * FROM \"Questions\" WHERE \"question_poll_id\"=:access ORDER BY \"question_order\" ASC;");
		$sql->bindValue(':access', $obj->AccessCode);
		$sql->execute();
		$questions = $sql->fetchAll();
		foreach($questions as $row){
			$obj->Questions[$row['question_order']] = Question::createFromDB($row, $db);
		}
	}
	
	/**
		Creates a Poll object from a given poll row in the database.
		Includes all Questions, Possible Answers, Right Answers, and Responses.
		
		This is useful for gathering poll informationg for taking/viewing results.
	**/
	function createFromDB($row, $db){
		$obj = new Poll();
		$obj->Name = $row['poll_name'];
		$obj->AccessCode = $row['poll_id'];
		$db->beginTransaction();
		$obj->Questions = array();
		$obj->createQuestionsFromDB($db, $obj);
		$db->commit();
		return $obj;
	}
	
	function insert(){
	}

	function update(){
	}

	function delete(){
	}
}

/*
	Contains the Question, Type, Answers, and Possible Answers.
*/
class Question implements iDatabaseFunctions{
	function __construct(){}
	
	function createAnswersFromDB($db, $obj){
		$sql = $db->prepare("SELECT * FROM \"Answers\" WHERE \"answers_question_id\"=:question;");
		$sql->bindValue(':question', $obj->ID);
		$sql->execute();
		$answers = $sql->fetchAll();
		foreach($answers as $row){
			$obj->Answers[] = Answer::createFromDB($row, $db);
		}
	}
	
	function createPAnswersFromDB($db, $obj){
		$sql = $db->prepare("SELECT * FROM \"PossibleAnswers\" WHERE \"panswers_question_id\"=:question;");
		$sql->bindValue(':question', $obj->ID);
		$sql->execute();
		$questions = $sql->fetchAll();
		foreach($questions as $row){
			$obj->PAnswers[] = PAnswer::createFromDB($row, $db);
		}
	}
	
	function createFromDB($row, $db){
		$obj = new Question();
		$obj->Poll = $row['question_poll_id'];
		$obj->ID = $row['question_id'];
		$obj->Question = $row['question_question'];
		$obj->Type = $row['question_type'];
		$obj->Answers = array();
		$obj->PAnswers = array();
		$obj->createAnswersFromDB($db, $obj);
		$obj->createPAnswersFromDB($db, $obj);
		return $obj;
	}
	
	function insert(){
	}
	
	function update(){
	}
	
	function delete(){
	}
}

/*
	Contains a single possible answer.
*/
class PAnswer implements iDatabaseFunctions{
	function __construct(){}
	
	function createFromDB($row, $db){
		$obj = new PAnswer();
		$obj->Question = $row['panswers_question_id']; //useful for update/delete
		$obj->PAnswer = $row['panswers_panswer'];
		return $obj;
	}
	
	function insert(){
	}

	function update(){
	}

	function delete(){
	}
}

/*
	Contains a single answer.
*/
class Answer implements iDatabaseFunctions{
	function __construct(){}
	
	function createFromDB($row, $db){
		$obj = new Answer();
		$obj->Question = $row['answers_question_id']; //useful for update/delete
		$obj->Answer = $row['answers_answer'];
		return $obj;
	}
	
	function insert(){
	}

	function update(){
	}

	function delete(){
	}
}
?>