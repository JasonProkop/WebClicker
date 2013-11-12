<?php
require_once('functions.php');

if(isset($_GET['accessCode'])){
	try{
		validAccessCode($_GET['accessCode']);
		$poll = search($_GET['accessCode']);
		$total_responses = 0;
		foreach($poll->Questions as $question){
			$total_responses += sizeof($question->Responses);
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
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<title>
			WebClicker
		</title>
		<link rel="stylesheet" href="themes/webclicker-usask.css" />
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile.structure-1.3.2.min.css" />
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
	</head>
<body>
	<div id="homepage" data-role="page" data-title="WebClicker - <?php echo $poll->Name; ?> - Poll Details">
		<header data-role="header"  data-tap-toggle="false">
			<h1><?php echo $poll->Name; ?> - Poll Details</h1>
			<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home" data-ajax="false">Home</a>
		</header><!-- /header -->
		<ul data-role="listview">
			<li>Access Code: <?php echo $poll->AccessCode; ?></li>
			<li>Share Link: http://webclicker.tk/poll.php?accessCode=<?php echo $poll->AccessCode; ?></li>
			<li>Questions: <?php echo sizeof($poll->Questions); ?></li>
			<li>Responses: <?php echo $total_responses; ?></li>
			<li>Created On: <?php echo date("F j, Y, g:i a", strtotime($poll->DateCreated)); ?></li>
		</ul>
		<div data-role="content" class="ui-grid-b">
			<div class="ui-block-a">
				<a href="poll.php?accessCode=<?php echo $poll->AccessCode; ?>" data-role="button" data-ajax="false">Take Poll</a>
			</div>
			<div class="ui-block-b">
				<a href="results.php?accessCode=<?php echo $poll->AccessCode; ?>" data-role="button" data-ajax="false">View Results</a>
			</div>
		</div>
	</div>
</body>
</html>
