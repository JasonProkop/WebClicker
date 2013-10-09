<?php
function db_getpdo($hostname="localhost", $username="ubuntu", $password="ubuntu", $database="postgres")
{
    $pdo = new PDO("pgsql:dbname=$database;host=$hostname", $username, $password);
    /* check connection */
    //if (pgsqli_connect_errno()) {
    //    printf("Connect failed: %s\n", pgsqli_connect_error());
    //    exit();
    //}
	$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    return $pdo;
}
?>
