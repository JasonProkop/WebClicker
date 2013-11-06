<?php
require_once('functions.php');

if(isset($_GET['accessCode'])){
	try{
		$poll = search($_GET['accessCode']); 
		//success
		//header("location:poll.php?poll=".$_POST['accessCode']);
		//var_dump($poll);
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

function displayRadio($question){
	echo '<fieldset data-role="controlgroup" data-type="horizontal">
					<legend></legend>';
	foreach($question->PAnswers as $panswer){
		echo '<input type="radio" name="'.$panswer->Question.'" id="'.$panswer->ID.'" value="'.$panswer->PAnswer.'" />
					<label for="'.$panswer->ID.'">'.$panswer->PAnswer.'</label>';
	}
					
	echo '</fieldset>';
}

function displayCheckbox($question){
	echo '<fieldset data-role="controlgroup">
			        <legend></legend>';
	foreach($question->PAnswers as $panswer){
		echo '<input type="checkbox" name="'.$panswer->ID.'" id="'.$panswer->ID.'">
			 <label for="'.$panswer->ID.'">'.$panswer->PAnswer.'</label>';
	}
	echo '</fieldset>';
}

function displayText($question){
	echo '<label for="'.$question->ID.'"></label>
    			<textarea cols="40" rows="8" name="'.$question->ID.'" id="'.$question->ID.'"></textarea>';
}

function displaySlider($question){
}

function displayQuestion($question){
	echo '<h3>'.$question->Question.'</h3>';
	switch($question->Type){
		case 'Radio':
			displayRadio($question);
			return;
		case 'Checkbox':
			displayCheckbox($question);
			return;
		case 'Text':
			displayText($question);
			return;
		case 'Slider':
			displaySlider($question);
			return;
		default:
			return;
	}
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
		<link rel="stylesheet" href="themes/webclicker-usask.min.css" />
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile.structure-1.3.2.min.css" />
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
	</head>
	<body>
		<form action="parseresults.php" method="POST" data-ajax="false">
<?php
	$q=1;
	$qn = sizeof($poll->Questions);
	for($q = 1; $q <= $qn + 1; $q++){
		echo '<div id="q'.$q.'" data-role="page" data-theme="a">
			<div data-role="header" data-id="question" data-position="fixed">
				<h1>'.$poll->Name.'</h1>
				<div data-role="navbar">
					<ul>';
		for ($i = 1; $i <= $qn + 1; $i++) {
			echo '<li><a href="#q'.$i.'" >'.$i.'</a></li>';
		}
		echo		'</ul>
				</div><!-- /navbar -->
			</div><!-- /header -->
			<div data-role="content" >';
				
		if($q == $qn + 1){
			echo '<h3>Are you sure you are ready to submit?</h3>';
			echo '<input type="submit" value="Submit" data-theme="a">';
		}else{
			displayQuestion($poll->Questions[$q]);
		}
		echo '</div><!-- /content --> 
		</div><!-- /page -->';
	}
?>
		</form>
	</body>
</html>
