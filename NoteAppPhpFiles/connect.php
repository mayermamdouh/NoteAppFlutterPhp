<?php

$dns = "mysql:host=localhost;dbname=noteapp";
$user = 'root';
$pass = '';
$option = array(
    PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES UTF8" // for language arabic

);

try{
    $con = new PDO($dns , $user , $pass , $option );
    $con->setAttribute(PDO::ATTR_ERRMODE , PDO::ERRMODE_EXCEPTION) ;
    include 'functions.php';


     // to allow back end php to access http requst without any problem
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
    header("Access-Control-Allow-Methods: POST, OPTIONS , GET");

    checkAuthenticate();

}catch(PDOException $e){
echo $e->getMessage();
}


?>