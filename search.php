<?php
	require_once('functions.php');

	if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['accessCode'])){
		try{
			search($_POST['accessCode']);
			echo "success";
		}catch (PollNotFound $e) {
			echo "Poll Not Found";
		}catch(PDOException $e){
			echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
		}catch(MalformedAccessCode $e){
			echo "Caught MalformedAccessCode ('{$e->getMessage()}')\n{$e}\n";
		}
	}else{
		header("location:index.php");
	}
?>