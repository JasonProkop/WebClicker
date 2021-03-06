<!-- 	WebClicker.tk/group_details.php
	Developers: Dylan Fafard, Brady Smith, Jason Prokop, Bo Don, Max Gooding
	This page contains group details.
--> 

<?php
	require_once('include/functions.php');
	include_once('include/db.php');

	if (isset($_GET['name'])){
		try {
			$name = urldecode($_GET['name']);

			$db = db_getpdo();
			$group = searchGroup($db, $name, $_SESSION['email']);

			$sql = $db->prepare("SELECT * FROM polls where poll_group_name=:name ANd poll_group_user_email= :creator;");
			$sql->bindValue(':name', $name);
			$sql->bindValue(':creator', $_SESSION['email']);
			$sql->execute();
			$polls = $sql->rowCount();

			$sql = $db->prepare("SELECT * FROM groupusers where groupuser_group_name=:name AND  groupuser_user_email_group=:creator;");
			$sql->bindValue(':name', $name);
			$sql->bindValue(':creator', $_SESSION['email']);
			$sql->execute();
			$users = $sql->rowCount();
			$db = null;
		}
		catch (GroupNotFound $e) {
			setError($e->getMessage());
			header("location:error.php");
		}
		catch (PDOException $e) {
			setError($e->getMessage());
			header("location:error.php");
		}
	} else {
		header("location:index.php");
	}
?>

<!doctype html>
<html>
	<head>
		<title>WebClicker - Group Details</title>
		<?php boilerPlate(); ?>
	</head>
	<body>
		<div id="homepage" data-role="page" data-title="WebClicker - <?php
      echo $group->Name; ?> - Group Details" data-theme='a'>
			<?php drawHeader(); ?> <!-- Group details Page -->
			<ul data-role="listview">
				<li>Key: <?php echo $group->Key; ?></li> 
				<li>Polls: <?php echo $polls; ?></li>
				<li>Users: <?php echo $users; ?></li>
				<li>Created On: <?php echo date("F j, Y, g:i a", strtotime($group->DateCreated)); ?></li>
			</ul>
			<?php outputFooter(); ?>
		</div> <!-- /Group details Page End -->
	</body>
</html>
