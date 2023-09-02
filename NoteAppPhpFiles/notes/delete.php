<?php

include "../connect.php";

$notesId = filterToSaveFromHacking('notesId');
$imagename = filterToSaveFromHacking('imagename');

$stat = $con->prepare("DELETE FROM `notess` WHERE notesId = ?");

$stat->execute(array($notesId));

$count = $stat->rowCount();
if ($count > 0) {
    DeleteFile("../Upload",$imagename);
    echo json_encode(array("status" => "success"));
} else {
    echo json_encode(array("status" => "fail"));
}
?>
