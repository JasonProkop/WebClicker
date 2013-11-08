<?php
require_once('functions.php');
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
		<link rel="stylesheet" href="themes/webclicker-usask.min.css" />
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
		<link rel="stylesheet" type="text/css" href="static/jquery.jqplot.min.css" />
		<style>
			.chart{
				display: inline-block;
			}
		</style>

		<style type='text/css'>
			/* Style sheet to restrict the page on large browsers */

			/* this line detects browsers which have a minimum width of 600
			 * pixels and only applies the changes to them */
			@media only screen and (min-width: 600px){
				.ui-page {
				width: 600px !important;
				margin: 0 auto !important;
				position: relative !important;
				border-right: 5px #666 outset !important;
				border-left: 5px #666 outset !important;
				}
			}
			
			.question{
				padding: 10px;
				border:2px solid;
				border-radius:25px;
				box-shadow: 2px 2px 5px #888888;
				margin: 10px;
			}
		</style>
	</head>
	<body>
		<div data-role="page" data-theme="a">
				<div data-role="header" data-id="question" data-tap-toggle="false">
					<h1>'.$poll->Name.'</h1>
					<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home">Home - '.loggedInUser().'</a>
				</div><!-- /header -->
				<div data-role="content">
					<div id='chart1'>
					</div>
				</div>
				<script>
						$(document).ready(function() {
							var data = <?php questionBarData($question) ?>;
							var plot1 = $.jqplot('chart1', data, {
								seriesDefaults:{
									renderer:$.jqplot.BarRenderer,
									rendererOptions: {fillToZero: true}
								},
								series: <?php questionBarSeries($question) ?>,
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
						});
				</script>

				<script>
					$(document).ready(function() {
						var data = <?php questionPieData($question) ?>;
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
					});
				</script>
		</div>
	<body>
</html>

