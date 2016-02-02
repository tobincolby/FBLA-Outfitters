<?php

include "db.php";


$user_id = $_GET['user_id'];

$sql = "SELECT * FROM posts WHERE user_id = '$user_id' ORDER BY post_id DESC";

$result = mysql_query($sql);


if (mysql_num_rows($result)>0){
$r = array();
while($row = mysql_fetch_array($result)){
	$r[] = $row;
}
echo json_encode($r);
}else{
	echo "failure";
}




?>