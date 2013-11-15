<?php
require_once('functions.php');

if(isset($_GET['name'])){
	try{
		$name = urldecode($_GET['name']);
		$group = searchGroup($name, $_SESSION['email']);
		$db = db_getpdo();
		$db->beginTransaction();
		
		$sql = $db->prepare("SELECT * FROM polls where poll_group_name=:name ANd poll_group_user_email=:creator;");
		$sql->bindValue(':name', $name);
		$sql->bindValue(':creator', $_SESSION['email']);
		$sql->execute();
		$polls = $sql->rowCount();
		
		$sql = $db->prepare("SELECT * FROM groupusers where groupuser_group_name=:name ANd groupuser_user_email_group=:creator;");
		$sql->bindValue(':name', $name);
		$sql->bindValue(':creator', $_SESSION['email']);
		$sql->execute();
		$users = $sql->rowCount();
	}catch (GroupNotFound $e) {
		$_SESSION['error'] = $e->getMessage();
		header("location:error.php");
	}catch(PDOException $e){
		//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
		$_SESSION['error'] = $e->getMessage();
		header("location:error.php");
	}
}else{
	header("location:index.php");
}
?>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<title>
			WebClicker - Group Details
		</title>
		<link rel="stylesheet" href="themes/webclicker-usask.css" />
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile.structure-1.3.2.min.css" />
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
	</head>
<body>
	<div id="homepage" data-role="page" data-title="WebClicker - <?php echo $group->Name; ?> - Group Details">
		<header data-role="header"  data-tap-toggle="false">
			<h1><?php echo $group->Name; ?> - Group Details</h1>
			<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home" data-ajax="false">Home</a>
		</header><!-- /header -->
		<ul data-role="listview">
			<li>Key: <?php echo $group->Key; ?></li>
			<li>Polls: <?php echo $polls; ?></li>
			<li>Users: <?php echo $users; ?></li>
			<li>Created On: <?php echo date("F j, Y, g:i a", strtotime($group->DateCreated)); ?></li>
		</ul>
	</div>
</body>
</html>
