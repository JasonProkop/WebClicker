<?php
	require_once('functions.php');

	if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['accessCode'])){
		try{
			search($_POST['accessCode']);
			echo "success";
			}
		catch (PollNotFound $e) 
			{
				echo "Poll Not Found";
			}

	} else {
	header("location:index.php");
	}
	
?>