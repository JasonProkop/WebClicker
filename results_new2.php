<?php
require_once('functions.php');

if(isset($_GET['accessCode'])){
	try{
		validAccessCode($_GET['accessCode']);
		if(userTakenPoll($_GET['accessCode'])){
			header("location:results.php?accessCode=".$_GET['accessCode']);
		}else{
			$poll = search($_GET['accessCode']);
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

function displayRadio($question){
	echo "<script>$(document).ready(function() {var plot = $.jqplot('chart".$question->Order."', [".questionBarData($question)."], {
								seriesDefaults:{
									renderer:$.jqplot.PieRenderer,
									rendererOptions: {showDataLabels: true}
								},
								legend: {
									show: true,
									location: 'e'
								}
							});});</script>";
}

function displayCheckbox($question){
	echo "<script>$(document).ready(function() {
								var plot = $.jqplot('chart".$question->Order."', [".questionBarData($question)."], {
								title: '".$question->Question."',
								series:[{renderer:$.jqplot.BarRenderer}],
								axesDefaults: {
									tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
									tickOptions: {
									  angle: -30,
									  fontSize: '10pt'
									}
								},
								axes: {
								  xaxis: {
									renderer: $.jqplot.CategoryAxisRenderer
								  }
								}
								});
								});
		</script>";
}

function displayText($question){
	/*echo "<ul>";
	foreach($question->Responses as $response){
		echo '<li>'.$response->Response.'</li>';
	}
	echo "</ul>";*/
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
		<script src="static/js/magic.js"></script>
		<script type="text/javascript" src="static/js/excanvas.min.js"></script>
		<script type="text/javascript" src="static/js/jquery.jqplot.min.js"></script>
		<script type="text/javascript" src="static/js/plugins/jqplot.barRenderer.min.js"></script>
		<script type="text/javascript" src="static/js/plugins/jqplot.pieRenderer.min.js"></script>
		<script type="text/javascript" src="static/js/plugins/jqplot.categoryAxisRenderer.min.js"></script>
		<script type="text/javascript" src="static/js/plugins/jqplot.pointLabels.min.js"></script>
		<script type="text/javascript" src="../src/plugins/jqplot.dateAxisRenderer.min.js"></script>
		<script type="text/javascript" src="../src/plugins/jqplot.canvasTextRenderer.min.js"></script>
		<script type="text/javascript" src="../src/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
		<link rel="stylesheet" type="text/css" href="static/jquery.jqplot.min.css" />
		<style>
			.chart{
				display: inline-block;
				min-height: 300px;
				min-width: 200px;
			}
		</style>
	</head>
	<body>
		<div data-role="page" data-theme="a">
				<div data-role="header" data-id="question" data-tap-toggle="false">
					<h1></h1>
					<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home">Home - '.loggedInUser().'</a>
				</div><!-- /header -->
				<div data-role="content">
<?php	
					$q=1;
					$qn = sizeof($poll->Questions);
					echo '<ul style="list-style-type: none;">';
					for($q = 1; $q <= $qn; $q++){
					//<div id="chart3" style="height: 300px; width: 500px; position: relative;" class="jqplot-target"
						echo "<li><div style=\"height: 300px; width: 500px; position: relative;\" class=\"jqplot-target\" data-role='none' id='chart$q'>";
							//echo '<h3>'.$poll->Questions[$q]->Question.'</h3>';
						echo '</div></li>';
					}
					echo '</ul>';
?>
				</div>
				
					
<?php
					$q=1;
					$qn = sizeof($poll->Questions);
					for($q = 1; $q <= $qn; $q++){
						displayQuestion($poll->Questions[$q]);
					}
?>
		</div>
	<body>
</html>

