<?php
function db_getpdo($hostname="localhost", $username="ubuntu", $password="ubuntu", $database="postgres")
{
    $pdo = new PDO("pgsql:dbname=$database;host=$hostname", $username, $password);
	$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    return $pdo;
}
?>
