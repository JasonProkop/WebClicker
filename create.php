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
		<style>

		</style>
		<script>
			$(document).on('load', $('#addNewQuestion').click()); //add a single question right off the start.
		</script>
	</head>
	<body>
		<div data-role="page">
			<form id="createPoll" action="createpoll.php" method="POST" data-ajax="false" questions=0>
				<div data-role="header" data-theme="c" >
					<h1><input type="text" name="pollname" id="pollName" placeholder="Name (optional)"></h1>
					<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home" data-ajax="false">Home</a>
				</div>
				<div id="footer" data-role="footer" data-theme="c"  data-tap-toggle="false">
					<div class="ui-grid-a">
						<div class="ui-block-a"><input type="button" value="Add New Question" id="addNewQuestion" data-ajax="false" data-icon ="plus" data-mini="true" ></div>
						<div class="ui-block-b"><input type="button" value="Delete Question" id="deleteQuestion" data-ajax="false" data-icon ="minus" data-mini="true" ></div>
					</div>
					<div class="ui-grid-solo">
						<input type="submit" id="submit" value="All Done!"  data-icon="check" data-iconpos="left" />
					</div>	
				</div>
			</form>
		</div>
	<body>
</html>