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
	<?php boilerPlate(); ?>
</head>
<body>
	<section id="homepage" data-role="page" data-theme='a'>
		<?php drawHeader(); ?>
		<div>
			<article data-role="content">
				<h3>
					<?php currentError(); ?>
				</h3>
			</article>
		</div>
		<?php outputFooter(); ?>
	</section><!-- /page -->
	
</div>
</body>
</html>
