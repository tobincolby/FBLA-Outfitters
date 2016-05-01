<?php

include "db.php";

$sql = "SELECT * FROM posts ORDER BY post_id DESC";

$result = mysql_query($sql);

if(mysql_num_rows($result) > 0){
$r = array();
while($row = mysql_fetch_array($result)){
	$r[] = $row;
}
echo json_encode($r);

}else{
echo "0";
}

?>