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

		<!-- Looks like its deprecated, actually

			touchOverflow: Improved page transitions and true fixed toolbars
			 http://jquerymobile.com/demos/1.2.1/docs/pages/touchoverflow.html 
		<script>
			$(document).bind("mobileinit", function(){
	 		$.mobile.touchOverflowEnabled = true;
		});-->

	</script>
	</head>
	<body>
	<form action="results.php" method="POST" data-ajax="false">
		<div id="q1" data-role="page" data-theme="a">
			<div data-role="header" data-id="question" data-position="fixed" >
				<h1>Poll #0002</h1>
				<div data-role="navbar">
					<ul>
						<li><a href="#q1" class="ui-btn-active ui-state-persist">1</a></li>
						<li><a href="#q2" >2</a></li>
						<li><a href="#q3" >3</a></li>
						<li><a href="#q4" >4</a></li>
						<li><a href="#q5" >*</a></li>
						<!-- place class="ui-btn-active ui-state-persist" on the active anchor -->
						<!-- 5 items is the maximum for a single line navbar -->
					</ul>
				</div><!-- /navbar -->
			</div><!-- /header -->
			<div data-role="content" >
				<h3>Have you ever used a clicker or responseware before?</h3>
	            <fieldset data-role="controlgroup" data-type="horizontal">
					<legend></legend>
					<input type="radio" name="q1" id="q1a1" />
					<label for="q1a1">No</label>
					<input type="radio" name="q1" id="q1a2" />
					<label for="q1a2">Yes</label>
				</fieldset>
			</div><!-- /content -->
		</div><!-- /page -->

		<div id="q2" data-role="page" data-theme="a">
			<div data-role="header" data-id="question" data-position="fixed" > 
				<h1>Poll #0002</h1>
				<div data-role="navbar">
					<ul>
						<li><a href="#q1" >1</a></li>
						<li><a href="#q2" class="ui-btn-active ui-state-persist">2</a></li>
						<li><a href="#q3" >3</a></li>
						<li><a href="#q4" >4</a></li>
						<li><a href="#q5" >*</a></li>
						<!-- place class="ui-btn-active ui-state-persist" on the active anchor -->
						<!-- 5 items is the maximum for a single line navbar -->
					</ul>
				</div><!-- /navbar -->
			</div><!-- /header -->
			<div data-role="content" >
				<h3>What did you use that tool for, if anything?</h3>
				<fieldset data-role="controlgroup">
			        <legend></legend>
			        <input type="checkbox" name="q2a1" id="q2a1">
			        <label for="q2a1">Marked Quizzes</label>
			        <input type="checkbox" name="q2a2" id="q2a2">
			        <label for="q2a2">Non-marked Quizzes</label>
			        <input type="checkbox" name="q2a3" id="q2a3">
			        <label for="q2a3">Question/Comment Polling</label>
		    	</fieldset>
				<!-- Don't know which of this is required yet -->
			</div><!-- /content -->
		</div><!-- /page -->

		<div id="q3" data-role="page" data-theme="a">
			<div data-role="header" data-id="question" data-position="fixed">
				<h1>Poll #0002</h1>
				<div data-role="navbar">
					<ul>
						<li><a href="#q1" >1</a></li>
						<li><a href="#q2" >2</a></li>
						<li><a href="#q3" class="ui-btn-active ui-state-persist">3</a></li>
						<li><a href="#q4" >4</a></li>
						<li><a href="#q5" >*</a></li>
						<!-- 5 items is the maximum for a single line navbar -->
					</ul>
				</div><!-- /navbar -->
			</div><!-- /header -->
			<div data-role="content">
				<h3>Rate how much value was added by using the tool</h3>
				<label for="q3">0 is no value, 10 is the most value</label>
    			<input type="range" name="q3" id="q3" data-track-theme="a" data-theme="a" min="0" max="10" value="">
			</div><!-- /content -->
		</div><!-- /page -->

		<div id="q4"data-role="page" data-theme="a">
			<div data-role="header" data-id="question" data-position="fixed" >
				<h1>Poll #0002</h1>
				<div data-role="navbar">
					<ul>
						<li><a href="#q1" >1</a></li>
						<li><a href="#q2" >2</a></li>
						<li><a href="#q3" >3</a></li>
						<li><a href="#q4" class="ui-btn-active ui-state-persist">4</a></li>
						<li><a href="#q5" >*</a></li>
						<!-- 5 items is the maximum for a single line navbar -->
					</ul>
				</div><!-- /navbar -->
			</div><!-- /header -->
			<div data-role="content" >
				<h3>Please leave us any comments/questions/suggestions. We will read them!</h3>
				<label for="q4"></label>
    			<textarea cols="40" rows="8" name="q4" id="q4"></textarea>		
				</div><!-- /content -->
		</div><!-- /page -->

		<div id="q5" data-role="page" data-theme="a">
			<div data-role="header" data-id="question" data-position="fixed">
				<h1>Poll #0002</h1>
				<div data-role="navbar">
					<ul>
						<li><a href="#q1" >1</a></li>
						<li><a href="#q2" >2</a></li>
						<li><a href="#q3" >3</a></li>
						<li><a href="#q4" >4</a></li>
						<li><a href="#q5" class="ui-btn-active ui-state-persist">*</a></li>
						<!-- 5 items is the maximum for a single line navbar -->
					</ul>
				</div><!-- /navbar -->
			</div><!-- /header -->
			<div data-role="content" >
				<h3>Are you sure you're ready to submit?</h3>
				<input type="submit" value="Submit" data-theme="a">
			</div><!-- /content --> 
		</div><!-- /page -->
	</form>
	</body>
</html>

