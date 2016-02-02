<?php

$username = "ryantobin";
$password = "colbyrules7"; 
$hostname = "localhost"; 


//connection to the database
$dbhandle = mysql_connect($hostname, $username, $password) 
  or die("Unable to connect to MySQL");
//echo "Connected to MySQL<br>";

//select a database to work with
$selected = mysql_select_db("fbla_outfitter",$dbhandle) 
  or die("Could not select database");

?>