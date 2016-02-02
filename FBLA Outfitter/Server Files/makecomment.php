<?php

include "db.php";

$user_id = $_GET['user_id'];
$post_id = $_GET['post_id'];
$comment_text = $_GET['comment_text'];

$sql = "INSERT INTO comments VALUES ('',$user_id,'$comment_text',$post_id)";
$result = mysql_query($sql);

if(!$result){
	echo "failure";
}
else{
	echo "success";
}

?>