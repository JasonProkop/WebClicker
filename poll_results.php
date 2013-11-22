<?php
	require_once('include/functions.php');
	include_once('include/db.php'); 
	
	if(isset($_GET['accessCode'])){
		try{
			$db = db_getpdo();
			validAccessCode($_GET['accessCode']);
			$poll = searchPoll($db, $_GET['accessCode']);
			$colors = array('#ff8c00', '#87cefa', '#adff2f', '#dda0dd', '#ffd700'); //SETUP THE default color scheme for the graphs
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

function displayRadio($question){
	// Make a pie chart
	echo "
		<script>
		$(document).on('pageshow', function(event) {
			var plot = $.jqplot(
				'chart".$question->Order."', // Plot Target
				[".questionTojQplot($question)."],  // Plot Data
				{ // Plot Options
					seriesColors:".json_encode($GLOBALS['colors']).",
					seriesDefaults: {
			        	renderer: jQuery.jqplot.PieRenderer, 
			        	rendererOptions: { showDataLabels: true }
			        }
			    }
			);
			
  		});
		$('#chart".$question->Order."').trigger('create');
    	</script>
    ";
}

function displayCheckbox($question){
	// Make a bar chart
	echo "
		<script>
		$(document).on('pageshow', function(event) {
			var plot = $.jqplot(
				'chart".$question->Order."', // Plot Target
				[".questionTojQplot($question)."],  // Plot Data
				{ // Plot Options
					seriesColors:".json_encode($GLOBALS['colors']).",
					seriesDefaults: {
						renderer: $.jqplot.BarRenderer,
						rendererOptions: 
						{
							varyBarColor: true,
						}
					},
					axes: {
						xaxis: {
							renderer: $.jqplot.CategoryAxisRenderer,
							tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
							tickOptions: {
								show: false
							}
						},
						yaxis: {
							min: 0,  
							tickInterval: ".tickInterval($question)."
						}
					}
				}
			);
		});
		
    	</script>
    ";
}

function displayText($question){
	echo "
		<script>
		$(document).on('pageinit', function(event) {
			var list = $('<ul>', {'data-role' : 'listview', 'data-inset' : 'true'});
			";
		foreach($question->Responses as $response){
			echo "list.append($('<li/>', {'html' : ".json_encode($response->Response)."}));\n";
		}
	echo	"$('#chart".$question->Order."').append(list);
			$('#chart".$question->Order."').trigger('create');
		});
    	</script>
    ";
}

function displayNone($question){
	echo "
		<script>
		$(document).on('pageinit', function(event) {
			var none = $('<h4/>', {'html' : 'No Responses to this Question.'});
			$('#chart".$question->Order."').append(none);
			$('#chart".$question->Order."').trigger('create');
		});
    	</script>
    ";
}

function displayQuestion($question){
		if(sizeof($question->Responses) < 1){
			displayNone($question);
		}else{
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
}
?>

<!DOCTYPE html> 
<html>
	<head>
		<title>
			WebClicker
		</title>
		<?php boilerPlate(); ?>
		<script type="text/javascript" src="static/js/excanvas.min.js"></script>
		<script type="text/javascript" src="static/js/jquery.jqplot.min.js"></script>
		<script type="text/javascript" src="static/js/plugins/jqplot.barRenderer.min.js"></script>
		<script type="text/javascript" src="static/js/plugins/jqplot.pieRenderer.min.js"></script>
		<script type="text/javascript" src="static/js/plugins/jqplot.categoryAxisRenderer.min.js"></script>
		<script type="text/javascript" src="static/js/plugins/jqplot.pointLabels.min.js"></script>
		<script type="text/javascript" src="static/js/plugins/jqplot.dateAxisRenderer.min.js"></script>
		<script type="text/javascript" src="static/js/plugins/jqplot.canvasTextRenderer.min.js"></script>
		<script type="text/javascript" src="static/js/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
		<link rel="stylesheet" type="text/css" href="static/jquery.jqplot.min.css" />
	</head>
	<body>
		<div data-role="page" data-title="Webclicker - <?php echo $poll->Name; ?> - Results" data-theme="a" id="resultsPage">
			<?php drawHeader(); ?>
			<div data-role="content" data-tap-toggle="false">
				<h1><?php echo $poll->Name ?></h1>
			</div><!-- /header -->
			<a href="https://twitter.com/share" class="twitter-share-button" data-url="http://webclicker.tk/<?php echo $poll->AccessCode;?>" data-text="WebClicker - <?php echo $poll->Name;?> -Take this poll at" data-via="Webclickertk" data-size="large">Tweet</a>
			<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
<?php	
				//colors: #FF8C00, #87CEFA, #ADFF2F, #DDA0DD, #FFD700
				// Construct the divs to hold the plots
				foreach($poll->Questions as $question){
					$color=0;
					echo '<div data-role="collapsible" data-collapsed="false" data-mini="true">';
					echo '<h3>Question '.$question->Order.'</h3>';
					echo '<p><span><strong>Question: </strong>'.$question->Question.'</span>';
					foreach($question->Answers as $answer){
						echo '<p><span><strong>Answer: </strong>'.$answer->Answer.'</span>';
					}
					echo '<div data-role="none" class="jqplot-target" id="chart'.$question->Order.'">';
					echo '</div>';
					if(sizeof($question->PAnswers) > 0){
						echo '<strong>Possible Answers: </strong><p>';
						echo '<ul data-role="listview">';
						foreach($question->PAnswers as $panswer){
							echo '<li style="background-color:'.$colors[$color++].'">'.$panswer->PAnswer.'</li>';
						}
						echo '</ul>';
					}
					echo '</div>';
				}
?>
		
<?php
			// Create the plots	
			foreach($poll->Questions as $question){
				displayQuestion($question);
			}
?>
			
				<?php outputFooter(); ?>
			</div>
	</body>
</html>

