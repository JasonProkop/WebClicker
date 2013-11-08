<?php
if(!isset($_ERROR){
	header("location:index.php");
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
	<section id="homepage" data-role="page" >
		<header data-role="header"  data-tap-toggle="false">
			<h1>Web Clicker</h1>
			<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home">Home</a>
		</header><!-- /header -->
		<div>
			<article data-role="content" >
				So sorry blah blah blah...
				<h3>
					<?php echo $_E; ?>
				</h3>
		<br />
		</div>
	</section><!-- /page -->
</div>
</body>
</html>
