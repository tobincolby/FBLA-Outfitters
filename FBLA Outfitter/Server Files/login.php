<?php

include "db.php";

$username = $_GET['username'];

$password = $_GET['password'];

$newpass = md5($password);

$sql = "SELECT * FROM users WHERE (username = '$username' OR email = '$username') AND password = '$newpass'";
$result = mysql_query($sql);

if(mysql_num_rows($result) == 1){

	echo "[".json_encode(mysql_fetch_array($result))."]";

}else{
	echo "failure";
}


?>