<?php

include "db.php";

$post_id = $_GET['post_id'];

$sql = "SELECT * FROM posts WHERE post_id = $post_id";

$result = mysql_query($sql);

if(mysql_num_rows($result) > 0 ){
$row = mysql_fetch_array($result);
echo json_encode($row);
}else{
	echo "0";
}

?>