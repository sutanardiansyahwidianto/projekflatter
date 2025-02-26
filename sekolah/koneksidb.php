<?php

header('Access-Control-Allow-Origin:*');

$db_name = "sekolah";
$db_host = "localhost";
$db_user = "root";
$db_password = "";

$db_connection = new PDO("mysql:host={$db_host};dbname={$db_name};charset=utf8", $db_user, $db_password);
$db_connection->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db_connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);