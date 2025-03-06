<?php

include "koneksidb.php";
header('Content-Type: application/json');

//qurey untuk menampilkan data
$stmt = $db_connection->prepare("SELECT id, nis, nama, tplahir, tglahir, kelamin, agama, alamat FROM siswa");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

//untuk menampilakn data yang di ambil
echo json_encode($result);