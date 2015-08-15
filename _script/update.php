<?php

//$docroot = $_SERVER["DOCUMENT_ROOT"];
//$output = shell_exec("echo \'asdasd/_build/html\'  | sed s:_build/html::" );
//echo "####" + $output;

$basepath = shell_exec("echo " . $_SERVER["DOCUMENT_ROOT"]  . " | sed 's:_build/html:setup:'");

$shell_cmd = "/bin/bash " . trim($basepath)  . "/devnote.sh build 2>&1";

//exec($shell_cmd, $output);

echo "<pre>";
//echo implode("\n", $output);
echo "</pre>";

$output = shell_exec($shell_cmd);
echo "<pre>$output</pre>";

?>
