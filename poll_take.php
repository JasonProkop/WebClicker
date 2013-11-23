<?php
	require_once('include/functions.php');
	include_once('include/db.php'); 
	
	if(isset($_GET['accessCode'])){
		try{
			$db = db_getpdo();
			validAccessCode($_GET['accessCode']);
			if(userTakenPoll($db, $_GET['accessCode'])){
				header('Location:poll_results.php?accessCode='.$_GET['accessCode']);
			}else{
				$poll = searchPoll($db, $_GET['accessCode']);
				if(!$poll->Active){
					header('Location:poll_results.php?accessCode='.$_GET['accessCode']);
				}
			}
		}catch (PollNotFound $e) {
			$_SESSION['error'] = $e->getMessage();
			redirectTo('error.php');
		}catch(PDOException $e){
			$_SESSION['error'] = $e->getMessage();
			redirectTo('error.php');
		}catch(MalformedAccessCode $e){
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
		<title>WebClicker</title>
		<?php boilerPlate(); ?>
		<script>
		$(document).on('click', '#goforward', function () {
			if ($.mobile.activePage.next('.ui-page').length !== 0) {
				var next = $.mobile.activePage.next('.ui-page');
				$.mobile.changePage(next, {
					transition: 'fade'
				});
			} else {
				alert('There\'s no next page');
			}
		});

		$(document).on('click', '#goback', function () {
			if ($.mobile.activePage.prev('.ui-page').length !== 0) {
				var prev = $.mobile.activePage.prev('.ui-page');
				$.mobile.changePage(prev, {
					transition: 'fade',
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
		            transition: 'fade'
		        });
		    }
		});

		$(document).on('swiperight', function () {
		    if ($.mobile.activePage.prev('[data-role="page"]').length !== 0) {
		        var prev = $.mobile.activePage.prev('[data-role="page"]');
		        $.mobile.changePage(prev, {
		            transition: 'fade',
		            reverse: true
		        });
		    }
		});
		</script>
	</head>
	<body>
			
		<form action="control/poll_parseresults.php" method="POST" data-ajax="false">
<?php
	echo '<input type=hidden name="poll_id" value="'.$poll->AccessCode.'" style="visiblity: hidden;">';
	$q=1;
	$qn = sizeof($poll->Questions);
	for($q = 1; $q <= $qn; $q++){
		echo '<div id="q'.$q.'" class="ui-page" data-role="page" data-title="Webclicker - '.$poll->Name.' - Create" data-theme="a">';
			drawHeader();
			echo '<div data-role="content" data-id="question" data-tap-toggle="false">';
			
			echo'
				<h1>'.$poll->Name.'</h1>
				<div data-role="navbar">
					<ul>';
		for ($i = 1; $i <= $qn; $i++) {
			if ($i == $q) {
				echo '<li><a href="#q'.$i.'" data-transition="fade" class="ui-btn-active ui-state-persist" >'.$i.'</a></li>';
			}else {
				echo '<li><a href="#q'.$i.'" data-transition="fade">'.$i.'</a></li>';
			}
			
		}
		echo		'</ul>
				</div><!-- /navbar -->
			</div><!-- /content -->
			<div data-role="content" >';
		displayQuestion($poll->Questions[$q]);
		
		echo '<div class="ui-grid-a">';
		if($qn == 1){
			echo '</div><!-- end grid -->
				  <div class="ui-grid-solo">
					<input type="submit" id="submit" value="Submit Poll" data-icon="check" class="submit"/>
			      </div>';
		}else if($q == $qn){
			echo '		<div class="ui-block-a"><a href="#" id="goback" data-role="button" data-icon="arrow-l">Previous</a></div>
						<div class="ui-block-b"></div>
					</div><!-- end grid -->
					<div class="ui-grid-solo">
						<input type="submit" id="submit" value="Submit Poll" data-icon="check" class="submit"/>
					</div>';
		}else if($q == 1){
			echo '		<div class="ui-block-a"></div>
						<div class="ui-block-b"><a href="#" id="goforward" data-role="button" data-icon="arrow-r" data-iconpos="right">Next</a></div>
					</div><!-- end grid -->';
		}else{
			echo '		<div class="ui-block-a"><a href="#" id="goback" data-role="button" data-icon="arrow-l">Previous</a></div>
						<div class="ui-block-b"><a href="#" id="goforward" data-role="button" data-icon="arrow-r" data-iconpos="right">Next</a></div>
					</div><!-- end grid -->';
		}
		echo '</div><!-- /content -->';

		outputFooter();
		echo '</div><!-- /page -->';
	}
?>
		</form>
	</body>
</html>
