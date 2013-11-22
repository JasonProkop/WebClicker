<?php
	require_once('include/functions.php');
	include_once('include/db.php');
	
	if(isset($_GET['name'])){
		try{
			$name = urldecode($_GET['name']);
			
			$db = db_getpdo();
			$group = searchGroup($db, $name, $_SESSION['email']);
			
			$sql = $db->prepare("SELECT * FROM polls where poll_group_name=:name ANd poll_group_user_email=:creator;");
			$sql->bindValue(':name', $name);
			$sql->bindValue(':creator', $_SESSION['email']);
			$sql->execute();
			$polls = $sql->rowCount();
			
			$sql = $db->prepare("SELECT * FROM groupusers where groupuser_group_name=:name AND groupuser_user_email_group=:creator;");
			$sql->bindValue(':name', $name);
			$sql->bindValue(':creator', $_SESSION['email']);
			$sql->execute();
			$users = $sql->rowCount();
			$db = null;
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
		<title>WebClicker - Group Details</title>
		<?php outputHeader(); ?>
	</head>
	<body>
		<div id="homepage" data-role="page" data-title="WebClicker - <?php echo $group->Name; ?> - Group Details" data-theme='a'>
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
