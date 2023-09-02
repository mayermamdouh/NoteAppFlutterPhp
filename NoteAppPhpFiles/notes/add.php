<?php

include "../connect.php";


$notesTitle = filterToSaveFromHacking('notesTitle');
$notesContent = filterToSaveFromHacking('notesContent');
$notesUser = filterToSaveFromHacking('notesUser');


$imageName = UploadImage('file');
if ($imageName != 'fail') {
    try {
        $stat = $con->prepare("INSERT INTO `notess`(`notesTitle`, `notesContent`, `notesUser`, `ImageName`) 
            VALUES (?, ?, ?, ?)");
       $stat->execute(array($notesTitle, $notesContent, $notesUser, $imageName));
        
 
    
        $count = $stat->rowCount();
        if ($count > 0) {
            echo json_encode(array("status" => "success"));
        } else {
            echo json_encode(array("status" => "fail"));
        }
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
    }    
    
} else {
    echo json_encode(array("status" => "fail"));
}


?>
