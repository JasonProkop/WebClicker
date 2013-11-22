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
		<div id="homepage" data-role="page" >
			<?php drawHeader(); ?>
			<div data-role="collapsible">
				<h1>Create Group</h1>
				<form action="control/group_create.php" method="POST" data-ajax="false">
					<input type="text" name="groupname" placeholder="Group Name" required>
					<input type="text" name="groupkey" placeholder="Group Password" required>
					<input type="submit" value="Create">
				</form>
			</div>
			<div data-role="content">
			<h2>Owned Polls in Groups</h2>
			<ul data-role="listview" data-inset="true">
			<?php
				foreach($groups as $group){
					echo '<li><div data-role="collapsible" data-collapsed="true">';
					echo "<h1>$group->Name</h1>";
					echo 	'<ul data-role="listview">';
					if($group->Creator == $_SESSION['email']) { echo '<li><a href="group_details.php?name='.urlencode($group->Name).'" data-role="button" data-icon="gear" data-mini="true" data-ajax="false">Details</a></li>'; }
					$sql = $db->prepare("SELECT * FROM polls WHERE poll_group_name=:group AND poll_user_email=:user;");
					$sql->bindValue(':group', $group->Name);
					$sql->bindValue(':user', $_SESSION['email']);
					$sql->execute();
					displayPollsList($sql->fetchAll());
					echo 	'</ul><!-- /list -->';
					echo '</div><!-- /collapsible --></li>';
				}
				$db = null;
			?>
			</ul>
			</div>
			<?php outputFooter(); ?>
		</div><!-- /page -->
	</body>
</html>
