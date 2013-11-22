<?php
	require_once('include/functions.php');

	if(!isset($_SESSION['error'])){
		header("location:index.php");
	}
?>
<!doctype html>
<html>

<head>
	<title>
		WebClicker
	</title>
	<?php outputHeader(); ?>
</head>
<body>
	<section id="homepage" data-role="page" data-theme='a'>
		<header data-role="header"  data-tap-toggle="false">
			<h1>Web Clicker</h1>
			<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home" data-ajax="false">Home</a>
		</header><!-- /header -->
		<div>
			<article data-role="content">
				<h3>
					<?php currentError(); ?>
				</h3>
			</article>
		</div>
	</section><!-- /page -->
</div>
</body>
</html>
