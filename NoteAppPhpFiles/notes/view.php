<?php

include "../connect.php";


$user_id = filterToSaveFromHacking('userid');


$stat = $con->prepare("SELECT * FROM `notess` WHERE  `notesUser` = ? ");

$stat->execute(array($user_id));

$data = $stat->fetchAll(PDO::FETCH_ASSOC); // i make fetchall beacause i want every notes i have it 

$count = $stat->rowCount();
if ($count > 0) {
    echo json_encode(array("states" => "success" , "data" => $data));
} 
else {
    echo json_encode(array("states" => "fail"));
}


?>