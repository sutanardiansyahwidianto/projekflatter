<?php

include "koneksidb.php";
header('Content-Type: application/json');

//variable yang akan inputkan pada tabel 'siswa'
$nama = htmlspecialchars($_POST['nama']);
$nisn = htmlspecialchars($_POST['nisn']);
$tplahir = htmlspecialchars($_POST['tplahir']);
$tglahir = htmlspecialchars($_POST['tglahir']);
$kelamin = htmlspecialchars($_POST['kelamin']);
$agama = htmlspecialchars($_POST['agama']);
$alamat = htmlspecialchars($_POST['alamat']);

//query untuk memasukkan data pada tabel 'siswa'
$stmt = $db_connection->prepare("INSERT INTO siswa (nis, nama, tplahir, tglahir, kelamin, agama, alamat)
                                VALUES(?, ?, ?, ?, ?, ?, ?)");
$result = $stmt->execute([$nisn, $nama, $tplahir, $tglahir, $kelamin, $agama, $alamat]);

//menampilkan data yang sukses di inputkan atau di masukkan pada tabel 'siswa'
echo json_encode([
    "message" => "Data is successfully inputted",
    "data" => $result
]);