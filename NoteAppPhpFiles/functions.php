<?php

define('MB',1048576);

function filterToSaveFromHacking($requestname){
return htmlspecialchars(strip_tags($_POST[$requestname]));
}


function UploadImage($NameImageRequest) {
    global $ErrorMassage;
    $ErrorMassage = array();
    $Imagename = rand(1000, 10000) . $_FILES[$NameImageRequest]['name'];
    $Imagetmp = $_FILES[$NameImageRequest]['tmp_name'];
    $Imagesize = $_FILES[$NameImageRequest]['size'];

    $allowExt = array("jpg", "gif", "png", "jpeg");

    $strtoarray = explode('.', $Imagename);
    $ext = end($strtoarray);
    $ext = strtolower($ext);

    if (!empty($Imagename) && !in_array($ext, $allowExt)) {
        $ErrorMassage[] = 'Invalid extension';
    }
    if ($Imagesize > 3 * 1048576) {
        $ErrorMassage[] = 'File size exceeds limit';
    }

    if (empty($ErrorMassage)) {
        $uploadDir = '../Upload/';
        $destination = $uploadDir . $Imagename;

        if (move_uploaded_file($Imagetmp, $destination)) {
            return $Imagename; // Return the uploaded image name
        } else {
            return 'fail';
        }
    } else {
        echo "<pre>";
        print_r($ErrorMassage);
        echo "</pre>";
    }
}
// i make this beacuse when delete note delete it from database but i want to delete photo from server beacuse storge
function DeleteFile($dir , $Imagename){
    if(file_exists($dir . '/' . $Imagename)){
        unlink($dir . '/' . $Imagename);
    }
}
// to protect api for me 
function checkAuthenticate()
{
    if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {
        if ($_SERVER['PHP_AUTH_USER'] != "mayer" ||  $_SERVER['PHP_AUTH_PW'] != "mayer123"){
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;
        }
    } else {
        exit;
    }
}

?>