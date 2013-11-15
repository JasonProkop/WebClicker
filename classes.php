<?php
include_once('exception.php');

class PollCreationError extends CustomException {} //'No questions in the poll'
class QuestionCreationError extends CustomException {} //'No panswers in the question

/*
	Defines the behaviour we need for database interaction between our objects.
*/
interface iDatabase{
	public function insert($db, $id);
	public function update($db, $id);
	public function delete($db, $id);
	public function createFromDB($row, $db);
}

/*
	Defines the behaviour we need for POST creation for our objects.
*/
interface iPost{
	public function createFromPOST($POST);
}
/**
	Contains Poll name, Access Code, All questions, answers, possible answers, and responses.
**/
class Poll implements iDatabase, iPost{
	function __construct(){}
	
	function createFromPOST($POST){
		$obj = new Poll();
		$obj->Name = $POST['pollname'];
		$obj->Creator = $_SESSION['email'];
		if($POST['groupname'] === 'Public'){
			$obj->Group = array( 'name' => 'Public', 'owner' => 'anonymous@anonymous.com' );
		}else{
			$obj->Group = array( 'name' => $POST['groupname'], 'owner' => $_SESSION['email'] );
		}
		//$obj->DateClosing = $POST['enddate'];
		if($_SESSION['email'] === 'anonymous@anonymous.com'){
			$obj->Active = 'true';
		}else{
			$obj->Active = $POST['pollactive'];
		}
		for($i = 0; $i < sizeof($POST['questions']); $i++){
			$POST['questions'][$i]['order'] = $i + 1;
			$obj->Questions[] = Question::createFromPOST($POST['questions'][$i]);
		}
		if(sizeof($obj->Questions) < 1){
			throw new PollCreationError('No questions specified');
		}
		return $obj;
	}
	
	/**
		Creates all Question objects that are identified to this poll.
	**/
	function createQuestionsFromDB($db, $obj){
		$sql = $db->prepare("SELECT * FROM questions WHERE question_poll_id=:access ORDER BY question_order ASC;");
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
		$obj->DateCreated = $row['poll_date_created'];
		$obj->DateClosing = $row['poll_date_end'];
		$obj->Creator = $row['poll_user_email'];
		$obj->Group = array( 'name' => $row['poll_group_name'], 'owner' => $row['poll_group_user_email'] );
		$obj->Active = (bool)$row['poll_active'];
		$db->beginTransaction();
		
		$obj->Questions = array();
		$obj->createQuestionsFromDB($db, $obj);
		
		$db->commit();
		return $obj;
	}
	
	function insert($db, $id){
		$this->AccessCode = $id;
		$db->beginTransaction();
		$sql = $db->prepare("INSERT INTO polls (poll_id, poll_name, poll_user_email, poll_group_name, poll_group_user_email, poll_active) VALUES (:id, :name, :creator, :group, :groupowner, :active);");
		$sql->bindValue(':name', $this->Name);
		$sql->bindValue(':id', $this->AccessCode);
		$sql->bindValue(':creator', $this->Creator);
		$sql->bindValue(':group', $this->Group['name']);
		$sql->bindValue(':groupowner', $this->Group['owner']);
		$sql->bindValue(':active', $this->Active);
		$sql->execute();
		foreach($this->Questions as $question){
			$question->insert($db, $id);
		}
		$db->commit();
	}

	function update($db, $id){
	}

	function delete($db, $id){
	}
}

/*
	Contains the Question, Type, Answers, and Possible Answers.
*/
class Question implements iDatabase, iPost{
	function __construct(){}
	
	function createFromPOST($POST){
		$obj = new Question();
		//$obj->Poll = $POST['poll'];
		$obj->Question = $POST['question'];
		$obj->Type = $POST['type'];
		$obj->Order = $POST['order'];
		if($obj->Type != "Textbox"){
			for($i = 0; $i < sizeof($POST['answers']); $i++){
				if(!empty($POST['answers'][$i])){
					$obj->Answers[] = Answer::createFromPOST($POST['answers'][$i]);
				}
			}
			for($i = 0; $i < sizeof($POST['panswers']); $i++){
				if(!empty($POST['panswers'][$i])){
					$obj->PAnswers[] = PAnswer::createFromPOST($POST['panswers'][$i]);
				}
			}
		}
		if(empty($obj->Question) || ($obj->Type != 'Textbox' && sizeof($obj->PAnswers) < 1)){
			throw new QuestionCreationError('No answers specified');
		}
		return $obj;
	}
	
	function createAnswersFromDB($db, $obj){
		$sql = $db->prepare("SELECT * FROM answers WHERE answer_question_id=:question;");
		$sql->bindValue(':question', $obj->ID);
		$sql->execute();
		$answers = $sql->fetchAll();
		foreach($answers as $row){
			$obj->Answers[] = Answer::createFromDB($row, $db);
		}
	}
	
	function createPAnswersFromDB($db, $obj){
		$sql = $db->prepare("SELECT * FROM possibleanswers WHERE panswer_question_id=:question;");
		$sql->bindValue(':question', $obj->ID);
		$sql->execute();
		$questions = $sql->fetchAll();
		foreach($questions as $row){
			$obj->PAnswers[] = PAnswer::createFromDB($row, $db);
		}
	}

	function createResponsesFromDB($db, $obj){
		$sql = $db->prepare("SELECT * FROM responses WHERE response_question_id=:question;");
		$sql->bindValue(':question', $obj->ID);
		$sql->execute();
		$responses = $sql->fetchAll();
		foreach($responses as $row){
			$obj->Responses[] = Response::createFromDB($row, $db);
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
		$obj->Responses = array();
		
		$obj->createAnswersFromDB($db, $obj);
		$obj->createPAnswersFromDB($db, $obj);
		$obj->createResponsesFromDB($db, $obj);
		
		return $obj;
	}
	
	function insert($db, $id){
		$sql = $db->prepare("INSERT INTO questions (question_question, question_type, question_poll_id, question_order) VALUES (:question, :type, :poll, :order);");
		$sql->bindValue(':question', $this->Question);
		$sql->bindValue(':type', $this->Type);
		$sql->bindValue(':poll', $id);
		$sql->bindValue(':order', $this->Order);
		$sql->execute();
		$sql = $db->prepare("SELECT * FROM questions ORDER BY question_id DESC;");
		$sql->execute();
		$row = $sql->fetch();
		$q = $row['question_id'];
		foreach($this->Answers as $answer){
			$answer->insert($db, $q);
		}
		foreach($this->PAnswers as $panswer){
			$panswer->insert($db, $q);
		}
	}
	
	function update($db, $id){
	}
	
	function delete($db, $id){
	}
}

/*
	Contains a single possible answer.
*/
class PAnswer implements iDatabase, iPost{
	function __construct(){}
	
	function createFromPOST($POST){
		$obj = new PAnswer();
		$obj->PAnswer = $POST;
		return $obj;
	}
	
	function createFromDB($row, $db){
		$obj = new PAnswer();
		$obj->Question = $row['panswer_question_id']; //useful for update/delete
		$obj->PAnswer = $row['panswer_panswer'];
		$obj->ID = $row['panswer_id'];
		return $obj;
	}
	
	function insert($db, $id){
		$sql = $db->prepare("INSERT INTO possibleanswers (panswer_panswer, panswer_question_id) VALUES (:panswer, :question);");
		$sql->bindValue(':question', $id);
		$sql->bindValue(':panswer', $this->PAnswer);
		$sql->execute();
	}

	function update($db, $id){
	}

	function delete($db, $id){
	}
}

class Response implements iDatabase{
	function __construct(){}
	
	function createFromDB($row, $db){
		$obj = new Response();
		$obj->Response = $row['response_response'];
		$obj->Email = $row['response_user_email'];
		$obj->Poll = $row['response_poll_id'];
		$obj->Question = $row['response_question_id'];
		return $obj;
	}
	
	function insert($db, $id){
		$sql = $db->prepare("INSERT INTO response (response_response, response_question_id, response_poll_id, response_Email) VALUES (:response, :question, :poll, :email);");
		$sql->bindValue(':question', $id);
		$sql->bindValue(':response', $this->Response);
		$sql->bindValue(':poll', $this->Poll);
		$sql->bindValue(':email', $this->Email);
		$sql->execute();
	}

	function update($db, $id){
	}

	function delete($db, $id){
	}
}

/*
	Contains a single answer.
*/
class Answer implements iDatabase, iPost{
	function __construct(){}
	
	function createFromPOST($POST){
		$obj = new Answer();
		$obj->Answer = $POST;
		return $obj;
	}
	
	function createFromDB($row, $db){
		$obj = new Answer();
		$obj->Question = $row['answer_question_id']; //useful for update/delete
		$obj->Answer = $row['answer_answer'];
		$obj->ID = $row['answer_id'];
		return $obj;
	}
	
	function insert($db, $id){
		$sql = $db->prepare("INSERT INTO answers (answer_answer, answer_question_id) VALUES (:answer, :question);");
		$sql->bindValue(':question', $id);
		$sql->bindValue(':answer', $this->Answer);
		$sql->execute();
	}

	function update($db, $id){
	}

	function delete($db, $id){
	}
}

class Group{
	function __construct($row){
		$this->Name = $row['group_name'];
		$this->Creator = $row['group_user_email'];
		$this->Key = $row['group_key'];
		$this->DateCreated = $row['group_date_created'];
		return $this;
	}
}

class SiteStats{
	function __construct($db){
		$db->beginTransaction();
		$sql = $db->prepare("SELECT * FROM polls;");
		$sql->execute();
		$this->Polls = $sql->rowCount();
		
		$sql = $db->prepare("SELECT * FROM users;");
		$sql->execute();
		$this->Users = $sql->rowCount();
		
		$sql = $db->prepare("SELECT * FROM questions;");
		$sql->execute();
		$this->Questions = $sql->rowCount();
		
		$sql = $db->prepare("SELECT * FROM responses;");
		$sql->execute();
		$this->Responses = $sql->rowCount();
		
		$sql = $db->prepare("SELECT * FROM groups;");
		$sql->execute();
		$this->Groups = $sql->rowCount();
		
		$db->commit();
		return $this;
	}
}
?>