<?php

include "db.php";

$username = $_GET['username'];
$password = $_GET['password'];
$first_name = $_GET['first_name'];
$last_name = $_GET['last_name'];
$email = $_GET['email'];
$bio = $_GET['bio'];
$newpass = md5($password);
$check_sql = "SELECT * FROM users WHERE email = '$email' OR username = '$username'";
$check_result = mysql_query($check_sql);
if(mysql_num_rows($check_result)==0){
$sql = "INSERT INTO users VALUES ('','$username','$newpass','$email','$first_name','$last_name','$bio')";
$result = mysql_query($sql);

if(!$result){
	echo "failure";
}else{
	echo "success";
}
}else{
echo "match";
}

?>