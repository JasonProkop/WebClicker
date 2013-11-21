<?php
	require_once('../include/functions.php');

	if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['groupname']) && isset($_POST['groupkey'])){
		try{
			$db = db_getpdo();
			$db->beginTransaction();
			$sql = $db->prepare("INSERT INTO groups (group_name, group_user_email, group_key) VALUES (:group, :user, :key);");
			$sql->bindValue(':group', $_POST['groupname']);
			$sql->bindValue(':user', $_SESSION['email']);
			$sql->bindValue(':key', $_POST['groupkey']);
			$sql->execute();
			
			$sql = $db->prepare("INSERT INTO groupusers (groupuser_group_name, groupuser_user_email_user, groupuser_verified, groupuser_user_email_group) VALUES (:group, :user, :verified, :user);");
			$sql->bindValue(':group', $_POST['groupname']);
			$sql->bindValue(':user', $_SESSION['email']);
			$sql->bindValue(':verified', 'true');
			$sql->execute();
			$db->commit();
			
			header("location:../group_manage.php");
		}catch(PDOException $e){
			//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
			$_SESSION['error'] = $e->getMessage();
			header("location:../error.php");
		}
	}else{
		header("location:../index.php");
	}
?>