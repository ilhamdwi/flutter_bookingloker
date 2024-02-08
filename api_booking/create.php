<?php
$koneksi = new mysqli('localhost', 'root', '', 'sewa_loker');
$kode_loker = $_POST['kode_loker'];
$nama_pemesan = $_POST['nama_pemesan'];
$nomer_telpon = $_POST['nomer_telpon'];
$tanggal_booking = $_POST['tanggal_booking'];
$data = $koneksi->query("INSERT INTO tbl_pesanan SET kode_loker='$kode_loker', nama_pemesan='$nama_pemesan', nomer_telpon='$nomer_telpon', tanggal_booking='$tanggal_booking'");
if ($koneksi->error) {
    echo json_encode([
        'pesan' => 'gagal: ' . $koneksi->error
    ]);
} else {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
}
?>
