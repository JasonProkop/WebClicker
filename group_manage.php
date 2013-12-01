<!-- 	WebClicker.tk/group_manage.php
	Developers: Dylan Fafard, Brady Smith, Jason Prokop, Bo Don, Max Gooding
	This page contains options for managing groups for a user. They can create new groups,
	subscribe to groups, unsubscribe to groups, and view groups that they own
--> 

<?php
	require_once('include/functions.php');
	include_once('include/db.php');
	
	try {
	  if (!userLoggedIn()) {
	    header("location:index.php");
	  }
	  $db     = db_getpdo();
	  $joined = groupsJoinedByUser($db);
	  $owned  = groupsOwnedByUser($db);
	}
	catch (PDOException $e) {
	  setError($e->getMessage());
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
			<?php drawHeader(); ?> <!-- Page Group Manage - options concerning groups -->
			<div data-role="collapsible">
				<h1>Create Group</h1> <!-- Create Group - Makes a group-->
				<form action="control/group_create.php" method="POST" data-ajax="false">
					<input type="text" name="groupname" placeholder="Group Name" required>
					<input type="text" name="groupkey" placeholder="Group Password" required>
					<input type="submit" value="Create">
				</form>
			</div> <!-- /Create Group End-->
			<div data-role="collapsible">
				<h1>Subscribe to a Group</h1> <!-- Subscribe to a Group - Allows you to browse a list of groups and subscribe with a password to any of them-->
				<ul data-role="listview" data-filter="true" data-inset="true">
					<?php displayPossibleSubscriptions($db); ?>
				</ul>
			</div> <!-- /Subscribe to aGroup End-->
			<div data-role="collapsible">
				<h1>Unsubscribe from a Group</h1> <!-- Unsubscribe from a Group - Allows you to browse a list of groups that you are subscribed to, and you can chose to unsubscribe to any of them-->
				<ul data-role="listview" data-filter="true" data-inset="true">
					<?php displayPossibleUnSubscriptions($db, $joined); ?>
				</ul>
			</div> <!-- /Unsubscribe from a Group End-->
			<div data-role="collapsible">
				<h1>Owned Groups</h1> <!-- Owneded Groups - A list of groups which you have created-->
				<ul data-role="listview" data-filter="true" data-inset="true">
					<?php displayOwnedGroups($db, $owned); ?>
				</ul>
			</div> <!-- /Owned Groups End-->
			<?php outputFooter(); ?>
		</div><!-- /Page End-->
	</body>
</html>