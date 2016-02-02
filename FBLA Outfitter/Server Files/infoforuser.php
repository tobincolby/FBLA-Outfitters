<?php

include "db.php";

$user_id = $_GET['user_id'];

$sql = "SELECT * FROM users WHERE user_id = '$user_id' LIMIT 1";
$result = mysql_query($sql);

if($result && mysql_num_rows($result)>0){
$row = mysql_fetch_array($result);
echo "[".json_encode($row)."]";
}else{
echo "failure";
}


?>