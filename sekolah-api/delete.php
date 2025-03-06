<?php

include "koneksidb.php";
header('Content-Type: application/json');

//variable yang akan hapus data pada tabel 'siswa'
$id = (int) htmlspecialchars($_POST['id']);

//query untuk hapus data pada tabel 'siswa'
$stmt = $db_connection->prepare("DELETE FROM siswa WHERE id = ?");
$result = $stmt->execute([$id]);

//menampilkan data yang sukses di hapus pada tabel 'siswa'
echo json_encode([
    "message" => "Data successfully deleted",
    "id" => $id,
    "data" => $result
]);