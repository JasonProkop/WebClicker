<?php
	require_once('include/functions.php');
	include_once('include/db.php'); 
	
	try{
		if(!userLoggedIn()){
			header("location:index.php");
		}
		$db = db_getpdo();
		$groups = groupsOwnedByUser($db);
	}catch(PDOException $e){
		$_SESSION['error'] = $e->getMessage();
		header("location:error.php");
	}

?>
<!doctype html>
<html>
	<head>
		<title>WebClicker - Poll Management</title>
		<?php boilerPlate(); ?>
	</head>
	<body>
		<div id="homepage" data-role="page" data-theme="a">
			<?php drawHeader(); ?>
			<div data-role="content">
				<h2>Owned Polls sorted by Groups</h2>
				<ul data-role="listview" data-inset="true">
					<?php displayOwnedPolls($db, $groups); ?>
				</ul>
			</div>
			<?php outputFooter(); ?>
		</div><!-- /page -->
	</body>
</html>
