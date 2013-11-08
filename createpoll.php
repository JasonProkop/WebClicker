<?php
include_once('functions.php');

if($_SERVER['REQUEST_METHOD'] == 'POST'){
	try{
		//var_dump($_POST);
		$poll = Poll::createFromPOST($_POST);
		//var_dump($poll);
		$test = generateAccessCode();
		$poll->insert(db_getpdo(), $test);
		//var_dump($poll);
		header("location:poll.php?accessCode=".$test);
	}catch(PDOException $e){
		echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
	}
}else{
	//print_r($_POST);
	header("location:index.php");
}
?>