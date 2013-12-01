<!-- 	WebClicker.tk/index.php
	Developers: Dylan Fafard, Brady Smith, Jason Prokop, Bo Don, Max Gooding
	This is the homepage for the site. it needs to stay non cluttered.
	it contains a welcome message and a list of recent polls that the user can access quickly
--> 

<?php
	require_once('include/functions.php');
	include_once('include/db.php');
	
	try {
	  $db     = db_getpdo();
	  $groups = groupsJoinedByUser($db);
	}
	catch (PDOException $e) {
	  setError($e->getMessage());
	  header('Location:error.php');
	}
?>

<!doctype html>
<html>
	<head>
	  <?php boilerPlate(); ?>
	</head>
	<body>
		<div id="homepage" data-role="page" data-title="WebClicker - homepage" data-theme='a'>
			<?php drawHeader($db); ?> <!-- Page Index - Home page -->
			<div data-role="content">
				<div data-role"content" div id="center_box" div style="margin:0 auto;margin-left:auto;margin-right:auto;align:center;text-align:center;width:90%">
					<h2>Welcome to Web Clicker!</h2> <!-- Welcom message -->
					<p>To get started use the buttons at the bottom of the page for the main site actions or check out one of these recently created polls.</p>
				</div>
				<div data-role="collapsible" data-collapsed="false">
				  <h3>Latest Polls</h3> <!-- Gets a list of the lastest poll, for ease of use and wuick poll access -->
					<?php displaySubscribedPolls($db, $groups); ?>
				</div>
			</div>
			  <?php outputFooter(); ?>
		</div><!-- /Page  End-->
	</body>
</html>