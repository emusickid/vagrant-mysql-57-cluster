<?php
# Fill our vars and run on cli
# $ php -f db-connect-test.php

$dbname = 'sbtest';
$dbuser = 'benchmark';
$dbpass = 'password';
$dbhost = '192.168.205.10';

for ($i=0; $i<10000; $i++){
	$connect = new mysqli($dbhost, $dbuser, $dbpass, $dbname) or die("Unable to Connect to '$dbhost'");

	$test_query = "SHOW TABLES FROM $dbname";
	$result = $connect->query($test_query);

	$tblCnt = 0;
	while($tbl = mysqli_fetch_array($result)) {
	  $tblCnt++;
	  #echo $tbl[0]."<br />\n";
	}
    if($i % 100 ==0){
    	if (!$tblCnt) {
		  echo "There are no tables<br />\n";
		} else {
		  echo "There are $tblCnt tables<br />\n";
		}
    } 
}