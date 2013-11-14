<?php
require_once('functions.php');

try{
	$db = db_getpdo();
	$db->beginTransaction();
	$groups = groupsOwnedByUser();
}catch(PDOException $e){
	//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
	$_SESSION['error'] = $e->getMessage();
	header("location:error.php");
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
			<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home" data-ajax="false">Home</a>
		</header><!-- /header -->
		<form data-role="content" action="creategroup.php" method="POST">
			<div data-role="ui-grid-b">
					<div data-role="ui-block-a"><input type="text" placeholder="Group Name" required></div>
					<div data-role="ui-block-b"><input type="Submit" name="Submit" value="Create a Group"></div>
			<div>
		</form>
		<br />
		<hr>
		<br />
		<?php
			foreach($groups as $group){
				echo '<div data-role="collapsible" data-collapsed="true">';
				if($group === 'Public'){
					echo "<h1>$group</h1>";
				}else{
					echo '<div data-role="ui-grid-b">';
					echo 	'<h1><div data-role="ui-block-a">'.$group.'</div><div data-role="ui-block-b"><a href="groupdetails.php?name='.$group.'&creator='.$_SESSION['email'].'" data-role=button data-icon="gear">Details</a></div></h1>';
					echo '</div><!-- /grid -->';
				}
				echo 	'<ul data-role="listview" data-filter="true" data-inset="true">';
				$sql = $db->prepare("SELECT * FROM polls WHERE poll_group_name=:group AND poll_user_email=:user;");
				$sql->bindParam(':group', $group);
				$sql->bindParam(':user', $_SESSION['email']);
				$sql->execute();
				displayPollsList($sql->fetchAll());
				echo 	'</ul><!-- /list -->';
				echo '</div><!-- /collapsible -->';
			}
			$db->commit();
		?>
	</section><!-- /page -->
</div>
</body>
</html>
