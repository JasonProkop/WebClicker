<?php
require_once('functions.php');

if(loggedInUser() == 'Anonymous'){
	header("location:index.php");
}

try{
	$groups = groupsOwnedByUser();
	$db = db_getpdo();
	$db->beginTransaction();
}catch(PDOException $e){
	//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
	$_SESSION['error'] = $e->getMessage();
	header("location:error.php");
}

?>
<!doctype html>
<html>
	<head>
		<title>
			WebClicker - Poll Management
		</title>
		<?php outputHeader(); ?>
	</head>
<body>
	<div id="homepage" data-role="page" >
		<header data-role="header"  data-tap-toggle="false">
			<h1>Poll Management</h1>
			<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home" data-ajax="false">Home</a>
		</header><!-- /header -->
		<div data-role="collapsible">
			<h1>Create Group</h1>
			<form action="creategroup.php" method="POST" data-ajax="false">
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
				if($group->Creator == $_SESSION['email']) { echo '<li><a href="groupdetails.php?name='.urlencode($group->Name).'" data-role="button" data-icon="gear">Details</a></li>'; }
				$sql = $db->prepare("SELECT * FROM polls WHERE poll_group_name=:group AND poll_user_email=:user;");
				$sql->bindValue(':group', $group->Name);
				$sql->bindValue(':user', $_SESSION['email']);
				$sql->execute();
				displayPollsList($sql->fetchAll());
				echo 	'</ul><!-- /list -->';
				echo '</div><!-- /collapsible --></li>';
			}
			$db->commit();
		?>
		</ul>
		</div>
	</div><!-- /page -->
</div>
</body>
</html>
