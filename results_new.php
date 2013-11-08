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
	echo '
		$("q'.$q.'").on('pageinit', function()
			var data = [['Marked Quiz', 1],['Non-marked Quiz', 2],['Questions/Comments', 3];

			var plot = $.jqplot("q'.$q.'", [data], {
			seriesDefaults:{
				renderer:$.jqplot.PieRenderer,
				rendererOptions: {showDataLabels: true}
			},

			legend: {
				show: true,
				location: 'e'
			}
		});
	'
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
		case 'Textbox':
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
		<link rel="stylesheet" href="themes/webclicker-usask.css" />
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile.structure-1.3.2.min.css" />
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
	</head>
	<body>
		<form action="parseresults.php" method="POST" data-ajax="false">
<?php
	$q=1;
	$qn = sizeof($poll->Questions);
	for($q = 1; $q <= $qn; $q++){
		echo '<div id="q'.$q.'" data-role="page" data-theme="a">
			<div data-role="header" data-id="question" data-tap-toggle="false">
				<h1>'.$poll->Name.'</h1>
				<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home">Home</a>
				<div data-role="navbar">
					<ul>';
		for ($i = 1; $i <= $qn; $i++) {
			echo '<li><a href="#q'.$i.'" >'.$i.'</a></li>';
		}
		echo		'</ul>
				</div><!-- /navbar -->
			</div><!-- /header -->
			<div data-role="content" >';
				
		displayQuestion($poll->Questions[$q]);

		echo '</div><!-- /content --> 
		</div><!-- /page -->';
	}
?>
		</form>
	</body>
</html>
