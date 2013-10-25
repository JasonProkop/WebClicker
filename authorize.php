<?php
include_once('functions.php');

if(isset($_GET) && !empty($_GET['email'])){
	authorize($_GET['email']);
}
header("location:index.php");
?>