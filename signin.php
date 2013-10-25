<?php
include_once('functions.php');

if(!isset($_POST) || empty($_POST['email']) || empty($_POST['password'])){
	header("location:index.php");
}else{
	signIn($_POST['email'], $_POST['password']);
}
?>