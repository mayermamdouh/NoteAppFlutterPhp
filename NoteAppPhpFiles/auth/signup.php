<?php

include "../connect.php";

$username = filterToSaveFromHacking('username');
$email = filterToSaveFromHacking('email');
$password = filterToSaveFromHacking('password');


$stat = $con->prepare("INSERT INTO `users`( `username`, `email`, `password`) VALUES 
(?,?,?)");

$stat->execute(array($username,$email,$password));


$count = $stat->rowCount();
if($count > 0){
    echo json_encode(array("states"=>"success"));
}else{
    echo json_encode(array("states"=>"fail"));
}


?>