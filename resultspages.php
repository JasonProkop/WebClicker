<?php
	ini_set('display_errors', '1');
	error_reporting(E_ALL);

	include_once('db.php');

	$db = db_getpdo();
	$db->beginTransaction();
	
	$data = array();
	
	$query = "SELECT * FROM \"Toy\" WHERE q1='on'";
	$statement = $db->prepare($query);
	$statement->execute();
	$data['q1'][0] = $statement->rowCount();
	
	$query = "SELECT * FROM \"Toy\" WHERE q1='off'";
	$statement = $db->prepare($query);
	$statement->execute();
	$data['q1'][1] = $statement->rowCount();
	
	for($i = 1; $i <= 3; $i++)
	{
		$query = "SELECT * FROM \"Toy\" WHERE q2a$i='on'";
		$statement = $db->prepare($query);
		$statement->execute();
		$data['q2'][$i - 1] = $statement->rowCount();
	}
	
	for($i = 0; $i <= 10; $i++)
	{
		$query = "SELECT * FROM \"Toy\" WHERE q3='$i'";
		$statement = $db->prepare($query);
		$statement->execute();
		$data['q3'][$i] = $statement->rowCount();
	}
	$db->commit();
	//echo json_encode($data);
?>
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
		<script type="text/javascript" src="static/js/excanvas.min.js"></script>
		<script type="text/javascript" src="static/js/jquery.jqplot.min.js"></script>
		<script type="text/javascript" src="static/js/plugins/jqplot.barRenderer.min.js"></script>
		<script type="text/javascript" src="static/js/plugins/jqplot.pieRenderer.min.js"></script>
		<script type="text/javascript" src="static/js/plugins/jqplot.categoryAxisRenderer.min.js"></script>
		<script type="text/javascript" src="static/js/plugins/jqplot.pointLabels.min.js"></script>
		<link rel="stylesheet" type="text/css" href="static/jquery.jqplot.min.css" />
		<style>
			.chart{
				display: inline-block;
			}
		</style>
		<!-- Looks like its deprecated, actually

			touchOverflow: Improved page transitions and true fixed toolbars
			 http://jquerymobile.com/demos/1.2.1/docs/pages/touchoverflow.html 
			<script>
				$(document).bind("mobileinit", function(){
		 		$.mobile.touchOverflowEnabled = true;
			});
			</script>
		-->
	</head>
	<body>
		<div id="q1" data-role="page" data-theme="a">
			<div data-role="header" data-id="question" data-position="fixed" >
				<h1>Results for Poll #0002</h1>
			</div><!-- /header -->
			
			<div data-role="content">
				<ul style="list-style-type: none;">
				
					<li><h3>Have you ever used a clicker or responseware before?</h3><div id="chart1" class="chart"></div></li>
					<li><h3>What did you use that tool for?</h3><div id="chart2" class="chart"></div></li>
					<li><h3>How much value was added by using the tool?</h3><div id="chart3" class="chart"></div></li>
				</ul>
			</div><!-- /content -->
		</div><!-- /page -->
		<script>
			$(document).ready(function() {
				var data = [[<?php echo $data['q1'][0]; ?>],[<?php echo $data['q1'][1]; ?>]];
				var plot1 = $.jqplot('chart1', data, {
						seriesDefaults:{
							renderer:$.jqplot.BarRenderer,
							rendererOptions: {fillToZero: true}
						},
						series:[
							{label:'Yes'},
							{label:'No'}
						],
						legend: {
							show: true,
							placement: 'insideGrid'
						},
						axes: {
							xaxis: {
								renderer : $.jqplot.CategoryAxisRenderer
							},
							yaxis: {
								pad: 1.05
							}
						}
				});

				var data = [['Marked Quiz', <?php echo $data['q2'][0]; ?>],['Non-marked Quiz', <?php echo $data['q2'][1]; ?>],['Questions/Comments', <?php echo $data['q2'][2]; ?>]];
				var plot2 = $.jqplot('chart2', [data], {
						seriesDefaults:{
							renderer:$.jqplot.PieRenderer,
							rendererOptions: {showDataLabels: true}
						},
	
						legend: {
							show: true,
							location: 'e'
						}
				});
				
				var data = [[<?php echo $data['q3'][0] ?>],[<?php echo $data['q3'][1] ?>],[<?php echo $data['q3'][2] ?>],[<?php echo $data['q3'][3] ?>],[<?php echo $data['q3'][4] ?>],[<?php echo $data['q3'][5] ?>],[<?php echo $data['q3'][6] ?>],[<?php echo $data['q3'][7] ?>],[<?php echo $data['q3'][8] ?>],[<?php echo $data['q3'][9] ?>],[<?php echo $data['q3'][10] ?>]];
				var plot3 = $.jqplot('chart3', data, {
						seriesDefaults:{
							renderer:$.jqplot.BarRenderer,
							rendererOptions: {fillToZero: true}
						},
						series:[
							{label:'0'},
							{label:'1'},
							{label:'2'},
							{label:'3'},
							{label:'4'},
							{label:'5'},
							{label:'6'},
							{label:'7'},
							{label:'8'},
							{label:'9'},
							{label:'10'}
						],
						legend: {
							show: true,
							placement: 'outsideGrid'
						},
						axes: {
							xaxis: {
								renderer : $.jqplot.CategoryAxisRenderer
							},
							yaxis: {
								pad: 1.05
							}
						}
				});
			});
		</script>
	</body>
</html>
