<?php
include_once('functions.php');

if($_SERVER['REQUEST_METHOD'] == 'POST'){
	try{
		$poll = Poll::createFromPOST($_POST);
		$access = generateAccessCode();
		$poll->insert(db_getpdo(), $access);
		header("location:poll.php?accessCode=".$access);
	}catch(PDOException $e){
		//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
		global $_ERROR = $e->getMessage();
		header("location:error.php");
	}
}else{
	header("location:index.php");
}
?>