<?php

/*
	Defines the behaviour we need for database interaction between our objects.
*/
interface iDatabaseFunctions{
	public function insert($db);
	public function update($db);
	public function delete($db);
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
		
		This is useful for gathering poll information for taking/viewing results.
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
	
	function insert($db){
		$db->beginTransaction();
		$sql = $db->prepare("INSERT INTO \"Polls\" (\"poll_id\", \"poll_name\") VALUES (:id, :name);");
		$sql->bindValue(':id', $this->Name);
		$sql->bindValue(':name', $this->AccessCode);
		$sql->execute();
		foreach($this->Questions as $question){
			$question->insert($db);
		}
		$db->commit();
	}

	function update($db){
	}

	function delete($db){
	}
}

/*
	Contains the Question, Type, Answers, and Possible Answers.
*/
class Question implements iDatabaseFunctions{
	function __construct(){}
	
	function createAnswersFromDB($db, $obj){
		$sql = $db->prepare("SELECT * FROM \"Answers\" WHERE \"answer_question_id\"=:question;");
		$sql->bindValue(':question', $obj->ID);
		$sql->execute();
		$answers = $sql->fetchAll();
		foreach($answers as $row){
			$obj->Answers[] = Answer::createFromDB($row, $db);
		}
	}
	
	function createPAnswersFromDB($db, $obj){
		$sql = $db->prepare("SELECT * FROM \"PossibleAnswers\" WHERE \"panswer_question_id\"=:question;");
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
		$obj->Order = $row['question_order'];
		$obj->Answers = array();
		$obj->PAnswers = array();
		$obj->createAnswersFromDB($db, $obj);
		$obj->createPAnswersFromDB($db, $obj);
		return $obj;
	}
	
	function insert($db){
		$sql = $db->prepare("INSERT INTO \"Questions\" (\"question_question\", \"question_type\", \"question_poll_id\", \"question_order\") VALUES (:question, :type, :poll, :order);");
		$sql->bindValue(':question', $this->Question);
		$sql->bindValue(':type', $this->Type);
		$sql->bindValue(':poll', $this->Poll);
		$sql->bindValue(':order', $this->Order);
		$sql->execute();
		foreach($this->Answers as $answer){
			$answer->insert($db);
		}
		foreach($this->PAnswers as $panswer){
			$panswer->insert($db);
		}
	}
	
	function update($db){
	}
	
	function delete($db){
	}
}

/*
	Contains a single possible answer.
*/
class PAnswer implements iDatabaseFunctions{
	function __construct(){}
	
	function createFromDB($row, $db){
		$obj = new PAnswer();
		$obj->Question = $row['panswer_question_id']; //useful for update/delete
		$obj->PAnswer = $row['panswer_panswer'];
		$obj->ID = $row['panswer_id'];
		return $obj;
	}
	
	function insert($db){
		$sql = $db->prepare("INSERT INTO \"PossibleAnswers\" (\"panswer_panswer\", \"panswer_question_id\") VALUES (:panswer, :question);");
		$sql->bindValue(':question', $this->Question);
		$sql->bindValue(':panswer', $this->PAnswer);
		$sql->execute();
	}

	function update($db){
	}

	function delete($db){
	}
}

/*
	Contains a single answer.
*/
class Answer implements iDatabaseFunctions{
	function __construct(){}
	
	function createFromDB($row, $db){
		$obj = new Answer();
		$obj->Question = $row['answer_question_id']; //useful for update/delete
		$obj->Answer = $row['answer_answer'];
		$obj->ID = $row['answer_id'];
		return $obj;
	}
	
	function insert($db){
		$sql = $db->prepare("INSERT INTO \"PossibleAnswers\" (\"answer_answer\", \"answer_question_id\") VALUES (:answer, :question);");
		$sql->bindValue(':question', $this->Question);
		$sql->bindValue(':answer', $this->Answer);
		$sql->execute();
	}

	function update($db){
	}

	function delete($db){
	}
}
?>