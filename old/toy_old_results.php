<?php
ini_set('display_errors', '1');
error_reporting(E_ALL);

include_once('db.php');

$answers = array('q1', 'q2a1', 'q2a2', 'q2a3', 'q3', 'q4');
$db = db_getpdo();

$query = "INSERT INTO \"Toy\" (q1, q2a1, q2a2, q2a3, q3, q4) VALUES (";
foreach($answers as $answer)
{
	if(empty($_POST[$answer]))
	{
		//echo $answer . ' was nsot passed to me! --||--  ';	
		$query .= "'nr', ";
	}
	else
	{
		$query .= $db->quote($_POST[$answer]).", ";
	}
}
$query = substr_replace($query ,"",-2) . ');';
$statement = $db->prepare($query);
$db->beginTransaction();
$statement->execute();
$db->commit();
header("location:resultspages.php");
?>