<?php
	require_once('include/functions.php');
	include_once('include/db.php');
	
	try{
		if(!userLoggedIn()){ header("location:index.php"); }
		$db = db_getpdo();
		$joined = groupsJoinedByUser($db);
		$owned = groupsOwnedByUser($db);
	}catch(PDOException $e){
		$_SESSION['error'] = $e->getMessage();
		header("location:error.php");
	}
?>
<!doctype html>
<html>
	<head>
		<title>WebClicker - Group Subscriptions</title>
		<?php boilerPlate(); ?>
	</head>
	<body>
		<div id="homepage" data-role="page" data-theme='a'>
			<?php drawHeader(); ?>
			<div data-role="collapsible">
				<h1>Create Group</h1>
				<form action="control/group_create.php" method="POST" data-ajax="false">
					<input type="text" name="groupname" placeholder="Group Name" required>
					<input type="text" name="groupkey" placeholder="Group Password" required>
					<input type="submit" value="Create">
				</form>
			</div>
			<div data-role="collapsible">
				<h1>Subscribe to a Group</h1>
				<ul data-role="listview" data-filter="true" data-inset="true">
					<?php displayPossibleSubscriptions($db); ?>
				</ul>
			</div>
			<div data-role="collapsible">
				<h1>Unsubscribe from a Group</h1>
				<ul data-role="listview" data-filter="true" data-inset="true">
					<?php displayPossibleUnSubscriptions($db, $joined); ?>
				</ul>
			</div>
			<div data-role="collapsible">
				<h1>Owned Groups</h1>
				<ul data-role="listview" data-filter="true" data-inset="true">
					<?php displayOwnedGroups($db, $owned); ?>
				</ul>
			</div>
			<?php outputFooter(); ?>
		</div><!-- /page -->
	
	</div>
</body>
</html>