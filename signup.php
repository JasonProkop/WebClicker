<?php
include_once('functions.php');

if(!isset($_POST) || empty($_POST['email']) || empty($_POST['password'])){
	header("location:index.php");
}else{
	if(empty($_POST['alias'])){
		$alias = "";
	}else{
		$alias = $_POST['alias'];
	}
	signUp($_POST['email'], $_POST['password'], $alias);
}
?>