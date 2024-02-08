<?php
$koneksi = new mysqli('localhost', 'root', '','sewa_loker');
$query = mysqli_query($koneksi, "SELECT * FROM tbl_pesanan ");
$data = mysqli_fetch_all($query, MYSQLI_ASSOC);

echo json_encode($data);