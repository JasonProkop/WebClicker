<?php
require_once('functions.php');

if(isset($_GET['accessCode'])){
	try{
		validAccessCode($_GET['accessCode']);
		if(userTakenPoll($_GET['accessCode'])){
			redirectTo('results.php?accessCode='.$_GET['accessCode']);
		}else{
			$poll = search($_GET['accessCode']);
			if(!$poll->Active){
				redirectTo('results.php?accessCode='.$_GET['accessCode']);
			}
		}
	}catch (PollNotFound $e) {
		//echo "Poll Not Found";
		$_SESSION['error'] = $e->getMessage();
		redirectTo('error.php');
	}catch(PDOException $e){
		//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
		$_SESSION['error'] = $e->getMessage();
		redirectTo('error.php');
	}catch(MalformedAccessCode $e){
		//echo "Caught MalformedAccessCode ('{$e->getMessage()}')\n{$e}\n";
		$_SESSION['error'] = $e->getMessage();
		redirectTo('error.php');
	}
}else{
	header("location:index.php");
}

function displayRadio($question){
	echo '<fieldset data-role="controlgroup">';
	foreach($question->PAnswers as $panswer){
		echo '<input type="radio" name="questions['.$panswer->Question.']" id="'.$panswer->ID.'" value="'.$panswer->PAnswer.'">
					<label for="'.$panswer->ID.'">'.$panswer->PAnswer.'</label>';
	}
					
	echo '</fieldset>';
}

function displayCheckbox($question){
	echo '<fieldset data-role="controlgroup">';
	foreach($question->PAnswers as $panswer){
		echo '<input type="checkbox" name="questions['.$panswer->Question.']['.$panswer->ID.']" id="'.$panswer->ID.'" value="'.$panswer->PAnswer.'">
			 <label for="'.$panswer->ID.'">'.$panswer->PAnswer.'</label>';
	}
	echo '</fieldset>';
}

function displayText($question){
	echo '<label for="'.$question->ID.'"></label>
    			<input type="text" name="questions['.$question->ID.']" id="'.$question->ID.'">';
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
		<script>
		$(document).on('click', '#goforward', function () {
			if ($.mobile.activePage.next('.ui-page').length !== 0) {
				var next = $.mobile.activePage.next('.ui-page');
				$.mobile.changePage(next, {
					transition: 'flip'
				});
			} else {
				alert('There\'s no next page');
			}
		});

		$(document).on('click', '#goback', function () {
			if ($.mobile.activePage.prev('.ui-page').length !== 0) {
				var prev = $.mobile.activePage.prev('.ui-page');
				$.mobile.changePage(prev, {
					transition: 'flip',
					reverse: true
				});
			} else {
				alert('There\'s no previous page');
			}
		});
		
		$(document).on('swipeleft', function () {
		    if ($.mobile.activePage.next('[data-role="page"]').length !== 0) {
		        var next = $.mobile.activePage.next('[data-role="page"]');
		        $.mobile.changePage(next, {
		            transition: 'flip'
		        });
		    }
		});

		$(document).on('swiperight', function () {
		    if ($.mobile.activePage.prev('[data-role="page"]').length !== 0) {
		        var prev = $.mobile.activePage.prev('[data-role="page"]');
		        $.mobile.changePage(prev, {
		            transition: 'flip',
		            reverse: true
		        });
		    }
		});
		</script>
	</head>
	<body>
		<form action="parseresults.php" method="POST" data-ajax="false">
<?php
	echo '<input type=hidden name="poll_id" value="'.$poll->AccessCode.'" style="visiblity: hidden;">';
	$q=1;
	$qn = sizeof($poll->Questions);
	for($q = 1; $q <= $qn; $q++){
		echo '<div id="q'.$q.'" class="ui-page" data-role="page" data-title="Webclicker - '.$poll->Name.' - Create" data-theme="a">
			<div data-role="header" data-id="question" data-tap-toggle="false">
				<h1>'.$poll->Name.'</h1>
				<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home" data-ajax="false">Home</a>
				<a href=""  class="ui-btn-right" data-inline="true" data-theme="b" data-position-to="origin">'.substr(loggedInUser(), 0, 10).'</a>
				<div data-role="navbar">
					<ul>';
		for ($i = 1; $i <= $qn; $i++) {
			if ($i == $q) {
				echo '<li><a href="#q'.$i.'" class="ui-btn-active ui-state-persist" >'.$i.'</a></li>';
			}else {
				echo '<li><a href="#q'.$i.'" >'.$i.'</a></li>';
			}
			
		}
		echo		'</ul>
				</div><!-- /navbar -->
			</div><!-- /header -->
			<div data-role="content" >';
		displayQuestion($poll->Questions[$q]);
		echo '</div><!-- /content -->';
		echo '<div id="footer" data-role="footer" data-theme="c"  data-tap-toggle="false">';
		if($qn == 1){
			echo '<div class="ui-btn-right"><input type="submit" data-theme="b" id="submit" value="Submit Poll" data-icon="check" class="submit"/></div>';
		}else if($q == $qn){
			echo '<div class="ui-btn-left"><a href="#" id="goback" data-role="button">Previous</a></div>
					<div class="ui-btn-right"><input type="submit" data-theme="b" id="submit" value="Submit Poll" data-icon="check" class="submit"/></div>';
		}else if($q == 1){
			echo '<div class="ui-btn-right"><a href="#" id="goforward" data-role="button">Next</a></div>';
		}else{
			echo '<div class="ui-btn-left"><a href="#" id="goback" data-role="button">Previous</a></div>
					<div class="ui-btn-right"><a href="#" id="goforward" data-role="button">Next</a></div>';
		}
		echo '</div><!-- /footer -->
		</div><!-- /page -->';
	}
?>
		</form>
	</body>
</html>
