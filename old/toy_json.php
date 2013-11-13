<?php
	include_once('db.php');
	$db = db_getpdo();
	$query = "SELECT * FROM \"Toy\" WHERE q1='on'";
	$statement = $db->prepare($query);
	$db->beginTransaction();
	$statement->execute();

	$data = array();
	$data['yes'] = $statement->rowCount();
	//echo "var s1 = [".$statement->rowCount()."];";
	$query = "SELECT * FROM \"Toy\" WHERE q1='off'";
	$statement = $db->prepare($query);
	$statement->execute();
	$data['no'] = $statement->rowCount();
	//echo "var s2 = [".$statement->rowCount()."];";
	//echo json_encode($data);
    $y = array();

    $index = 0 ;
    for($x = 0 ; $x< 13 ; $x += 0.5) {
        $y[$index] =  sin($x);
        $index++ ;
    }

    $series = array();
    $series[0] = $y ;
    $data = json_encode($series);
  //  echo $data;
	echo " [
    ['Heavy Industry', 12],['Retail', 9], ['Light Industry', 14], 
    ['Out of home', 16],['Commuting', 7], ['Orientation', 9]]";

?>
