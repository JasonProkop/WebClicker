<?php
require_once('functions.php');

if(isset($_GET['accessCode'])){
	try{
		validAccessCode($_GET['accessCode']);
		$poll = search($_GET['accessCode']);
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
					title: ".json_encode($question->Question).",
					seriesDefaults: {
			        	renderer: jQuery.jqplot.PieRenderer, 
			        	rendererOptions: { showDataLabels: true }
			        },
			        legend: { show:true, placement: 'outsideGrid'}
			    }
			);
  		});
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
					title: ".json_encode($question->Question).",
					seriesDefaults: {
						renderer: $.jqplot.BarRenderer,
						rendererOptions: 
						{
							varyBarColor: true,
						}
					},
					axesDefaults: {
						tickRenderer: $.jqplot.CanvasAxisTickRenderer,
						tickOptions: {
							angle: -30,
							labelPosition: 'middle'

						}
					},
					axes: {
						xaxis: {
							renderer: $.jqplot.CategoryAxisRenderer,
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
			var title = $('<h3/>', {'html' : ".json_encode($question->Question)."});
			var list = $('<ul>', {'data-role' : 'listview', 'data-filter' : 'true', 'data-inset' : 'true'});
			$('#chart".$question->Order."').append(title);
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
			var title = $('<h3/>', {'html' : ".json_encode($question->Question)."});
			var none = $('<h4/>', {'html' : 'No Responses to this Question.'});
			$('#chart".$question->Order."').append(title);
			$('#chart".$question->Order."').append(none);
			$('#chart".$question->Order."').trigger('create');
		});
    	</script>
    ";
}

function displayQuestion($question){

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

<!DOCTYPE html> 
<html>
	<head>
		<title>
			WebClicker
		</title>
		<?php outputHeader(); ?>
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
			<div data-role="header" data-tap-toggle="false">
				<h1><?php echo $poll->Name ?></h1>
				<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home" data-ajax="false">Home</a>
				<a href=""  class="ui-btn-right" data-inline="true" data-position-to="origin"><?php echo substr(loggedInUser(), 0, 9); ?></a>
			</div>
			<a href="https://twitter.com/share" class="twitter-share-button" data-url="http://webclicker.tk/<?php echo $poll->AccessCode;?>" data-text="WebClicker - <?php echo $poll->Name;?> -Take this poll at" data-via="Webclickertk" data-size="large">Tweet</a>
			<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
			<!-- /header -->

<?php	
				// Construct the divs to hold the plots
				$q=1;
				$qn = sizeof($poll->Questions);
				for($q = 1; $q <= $qn; $q++){
					echo "<div data-role=\"content\" class=\"jqplot-target bordered\" id='chart$q'>";
					echo '</div>';
				}
?>
			</div>
			
<?php
			// Create the plots	
			$q=1;
			$qn = sizeof($poll->Questions);
			for($q = 1; $q <= $qn; $q++){
				displayQuestion($poll->Questions[$q]);
			}
?>
			<div data-role="footer" data-tap-toggle="false">
			</div>
	<body>
</html>

