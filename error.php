<!-- 	WebClicker.tk/error.php
	Developers: Dylan Fafard, Brady Smith, Jason Prokop, Bo Don, Max Gooding
	This page contains error information when an error occurs.
--> 

<?php
	require_once('include/functions.php');
	
	if (!isset($_SESSION['error']))
	{
	  header("location:index.php");
	}
?>

<!doctype html>
<html>
	<head>
		<title>WebClicker</title>
		<?php boilerPlate(); ?>
	</head>
	<body>
		<section id="homepage" data-role="page" data-theme='a'>
			<?php drawHeader(); ?> <!-- Error page - displays errors when they occur -->
			<div>
				<article data-role="content">
					<h3>
						<?php currentError(); ?> <!-- retrieven the error that occured -->
					</h3>
				</article>
			</div>
			<?php outputFooter(); ?>
		</section><!-- /Page End -->
	</body>
</html>
