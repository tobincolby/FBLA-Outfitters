<?php

include "db.php";

$post_id = $_GET['post_id'];

$sql = "SELECT * FROM likes WHERE post_id = '$post_id'";
$result = mysql_query($sql);

if($result && mysql_num_rows($result)>0){
$r = array();
	while($row = mysql_fetch_array($result)){
	$r[] = $row;
	}
	echo json_encode($r);
}else{
echo "0";
}

?>