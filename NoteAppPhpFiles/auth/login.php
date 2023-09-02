<?php

include "../connect.php";


$email = filterToSaveFromHacking('email');
$password = filterToSaveFromHacking('password');

$stat = $con->prepare("SELECT * FROM users WHERE  `email` = ? AND `password` = ?");

$stat->execute(array($email,$password));

$data = $stat->fetch(PDO::FETCH_ASSOC); // i make only fetch to return one map with my information 

$count = $stat->rowCount();
if ($count > 0) {
    echo json_encode(array("states" => "success" , "data" => $data));
} 
else {
    echo json_encode(array("states" => "fail"));
}


?>