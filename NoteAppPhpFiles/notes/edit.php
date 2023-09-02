<?php

include "../connect.php";

$notesTitle = filterToSaveFromHacking('Title');
$notesContent = filterToSaveFromHacking('Content');
$notesId = filterToSaveFromHacking('notesId');
$imageName = filterToSaveFromHacking('imageName');

// if not != null
if(isset($_FILES['file'])){
    DeleteFile("../Upload" , $imageName);
    $imageName = UploadImage('file');
}
//else
$stat = $con->prepare("UPDATE `notess` SET notesTitle = ?, notesContent = ?, imagename = ? WHERE notesId = ?");

$stat->execute(array($notesTitle, $notesContent, $imageName, $notesId));

$count = $stat->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "success"));
} else {
    echo json_encode(array("status" => "fail"));
}
?>
