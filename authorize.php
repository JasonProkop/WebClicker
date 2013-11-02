<?php
include_once('functions.php');

if(isset($_GET) && !empty($_GET['email']) && !empty($_GET['key'])){
	authorizeUser($_GET['email'], $_GET['key']);
}else{
	header("location:index.php");
}
?>