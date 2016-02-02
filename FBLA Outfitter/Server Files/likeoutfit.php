<?php

include "db.php";

$user_id = $_GET['user_id'];
if(isset($_GET['post_id'])){
	
	$post_id = $_GET['post_id'];
	$sql = "SELECT * FROM posts WHERE post_id = $post_id";
	
	$result = mysql_query($sql);
	if(!$result){
	die("failure");
	}
	$row = mysql_fetch_array($result);
	$num = $row['num_likes'] + 1;
	
	$updatesql = "UPDATE posts SET num_likes = '$num' WHERE post_id = $post_id";
	$updateresult = mysql_query($updatesql);
	$insertsql = "INSERT INTO likes VALUES ('','$user_id','','$post_id')";
	$insertresult = mysql_query($insertsql);
	if(!$updateresult || !$insertresult){
	echo "failure";
	}else{
	echo "success";
	}
	
}



?>