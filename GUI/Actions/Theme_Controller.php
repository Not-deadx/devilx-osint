<!--AUTHOR: Devilx
Copyright © Devilx
License: GNU General Public License v3.0-->
<?php
    $mode_file = "../Theme/Mode.json";
    if (file_exists($mode_file)) {
        $reader = file_get_contents($mode_file);
        $parser = json_decode($reader,true); 
        $color = $parser["Color"]["Background"];
        if ($color == "High-Contrast"){
            echo "<img src = '../Icon/devilx.png'>";
        }
        else {
            echo "<img src = '../Icon/devilx.png'>";
        }
    }
    else {
        echo "<img src = '../Icon/devilx.png'>";
    }   
?>
