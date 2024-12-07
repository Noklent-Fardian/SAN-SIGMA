<?php

require_once 'app/models/Mahasiswa.php';
require_once 'app/core/Database.php';
require_once 'app/models/Login.php';
require_once 'app/models/Admin.php';
require_once 'app/models/Prodi.php';
require_once 'app/models/Tingkatan.php';
require_once 'app/models/Peringkat.php';
require 'vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

class AdminController extends Controller
{
    private $admin;
    private $prodi;
    private $tingkatan;
    private $peringkat;



    public function __construct()
    {
        $this->admin = new Admin(Database::getInstance(getDatabaseConfig(), [$this, 'error']));
        $this->prodi = new Prodi(Database::getInstance(getDatabaseConfig(), [$this, 'error']));
        $this->tingkatan = new Tingkatan(Database::getInstance(getDatabaseConfig(), [$this, 'error']));
        $this->peringkat = new Peringkat(Database::getInstance(getDatabaseConfig(), [$this, 'error']));
    }

    public function index($screen = "dashboard")
    {
        $title = $screen;
        if (strpos($title, '/') !== false) {
            $title = explode('/', $title);
            $title = array_pop($title);
            $title = str_replace('_', ' ', $title);
            $title = ucwords($title);
        }

        try {
            // Fetch admin data from database by user_id
            $dataAdmin = $this->admin->getAdminByUserId($_SESSION['user_id']);
            $chartTingakatanPrestasi = $this->admin->getCountNameTingkatanPenghargaanByVerifTerverifikasi();
            $chartAngkatanPrestasi = $this->admin->getCountAngkatanMahasiswa();
            $chartTahunVerifikasi = $this->admin->getCountTahunVerif();
            $prodis = $this->prodi->getAll();
            $tingkatans = $this->tingkatan->getAll();
            $peringkats = $this->peringkat->getAll();

            if (!$dataAdmin) {
                throw new Exception("Admin not found");
            }
            $data = [
                "screen" => $screen,
                "title" => $this->processTitle($screen),
                'dataAdmin' => $dataAdmin,
                "admin" => [
                    "name" => $dataAdmin['name'],
                    "id" => $dataAdmin['id'],
                    "photo" => $dataAdmin['photo']
                ],
                "verifikasiPenghargaan" => $this->admin->getAllVerifikasiAndPenghargaan(),
                "verifikasiPenghargaanOv" => $this->admin->getAllVerifikasiAndPenghargaanOv(),
                "countAllPenghargaan" => $this->admin->getCountAllPenghargaan(),
                "countAllVerifiedPenghargaan" => $this->admin->getAllCountVerifiedPenghargaan(),
                "countAllNotVerifiedPenghargaan" => $this->admin->getAllCountNotVerifiedPenghargaan(),


                "chartTingakatan" => [
                    'labels' => $chartTingakatanPrestasi['labels'],
                    'datasets' => [
                        [

                            'data' => $chartTingakatanPrestasi['counts']
                        ]
                    ]
                ],

                "chartAngkatan" => [
                    'labels' => $chartAngkatanPrestasi['labels'],
                    'datasets' => [
                        [
                            'data' => $chartAngkatanPrestasi['counts']
                        ]
                    ]
                ],

                "chartTahunVerification" => [
                    'labels' => $chartTahunVerifikasi['labels'],
                    'datasets' => [
                        [
                            'data' => $chartTahunVerifikasi['counts']
                        ]
                    ]
                ],
                "prodis" => $prodis,
                "tingkatans" => $tingkatans,
                "peringkats" => $peringkats


            ];
            $this->view('admin/index', $data);
        } catch (Exception $e) {
            // Handle error appropriately
            //alert js exception
            echo '<script>alert("Error: ' . $e->getMessage() . '");</script>';
            echo '<script>setTimeout(function(){ window.location.href = "screen?screen=dashboard"; }, 10);</script>';
            exit();
        }
    }

    private function processTitle($screen)
    {
        $title = $screen;
        if (strpos($title, '/') !== false) {
            $title = explode('/', $title);
            $title = array_pop($title);
            $title = str_replace('_', ' ', $title);
            $title = ucwords($title);
        }
        return $title;
    }

    public function screen()
    {
        if (isset($_GET['screen'])) {
            $screen = strtolower($_GET['screen']);
            $this->index($screen);
        }
    }
    public function getVerifikasiDetail()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['id'])) {
            try {
                $verifikasiId = $_POST['id'];
                $detail = $this->admin->getVerifikasiAndPenghargaanByIdVerifikasi($verifikasiId);
                echo json_encode($detail);
            } catch (Exception $e) {
                http_response_code(500);
                echo json_encode(['error' => $e->getMessage()]);
            }
        }
    }
    // tombol dari admin untuk verifikasi prestasi
    public function verifikasi_prestasi()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                $verifikasiId = $_POST['pengId'];
                $status = $_POST['verification_status'] === 'accept' ? 'Terverifikasi' : 'DiTolak';
                $pesan = $_POST['pesan'];
                $id_admin = $_POST['id_admin'];


                // Update verification status
                $result = $this->admin->updateVerification($verifikasiId, $status, $pesan, $id_admin);

                // Show success message using SweetAlert2
                echo '<script>alert("Prestasi berhasil diinputkan");</script>';
                echo '<script>setTimeout(function(){ window.location.href = "screen?screen=verifikasi_prestasi"; }, 10);</script>';
            } catch (Exception $e) {
                // Show error message using SweetAlert2
                echo '<script>alert("Error: ' . $e->getMessage() . '");</script>';
                echo '<script>setTimeout(function(){ window.location.href = "screen?screen=verifikasi_prestasi"; }, 3000);</script>';
            }
        }
    }

    //Prodi
    public function kelola_prodi()
    {
        try {
            $prodis = $this->prodi->getAll();
            $data = [
                "screen" => "kelola_prodi",
                "title" => "Kelola Prodi",
                "prodis" => $prodis
            ];
            $this->view('admin/index', $data);
        } catch (Exception $e) {
            echo '<script>alert("Error: ' . $e->getMessage() . '");</script>';
            echo '<script>setTimeout(function(){ window.location.href = "screen?screen=dashboard"; }, 10);</script>';
        }
    }

    public function createProdi()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                $nama = $_POST['nama'];
                $this->prodi->create($nama);
                echo '<script>alert("Prodi berhasil ditambahkan");</script>';
                echo '<script>setTimeout(function(){ window.location.href = "screen?screen=kelola_prodi"; }, 10);</script>';
            } catch (Exception $e) {
                echo '<script>alert("Error: ' . $e->getMessage() . '");</script>';
                echo '<script>setTimeout(function(){ window.location.href = "screen?screen=kelola_prodi"; }, 10);</script>';
            }
        }
    }

    public function updateProdi()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                $id = $_POST['id'];
                $nama = $_POST['nama'];
                $this->prodi->update($id, $nama);
                echo json_encode(['success' => true, 'message' => 'Prodi berhasil diupdate']);
            } catch (Exception $e) {
                http_response_code(500);
                echo json_encode(['success' => false, 'message' => $e->getMessage()]);
                echo '<script>setTimeout(function(){ window.location.href = "screen?screen=kelola_prodi"; }, 3000);</script>';
            }
        }
    }

    public function deleteProdi()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                $id = $_POST['id'];
                $this->prodi->delete($id);
                echo '<script>alert("Prodi berhasil dihapus");</script>';
                echo '<script>setTimeout(function(){ window.location.href = "screen?screen=kelola_prodi"; }, 10);</script>';
            } catch (Exception $e) {
                echo '<script>alert("Error: ' . $e->getMessage() . '");</script>';
                echo '<script>setTimeout(function(){ window.location.href = "screen?screen=kelola_prodi"; }, 10);</script>';
            }
        }
    }


    //Tingkatan
    public function kelola_tingkatan()
    {
        try {
            $tingkatans = $this->tingkatan->getAll();
            $data = [
                "screen" => "kelola_tingkatan",
                "title" => "Kelola Tingkatan",
                "tingkatans" => $tingkatans
            ];
            $this->view('admin/kelola_tingkatan', $data);
        } catch (Exception $e) {
            echo '<script>alert("Error: ' . $e->getMessage() . '");</script>';
            echo '<script>setTimeout(function(){ window.location.href = "screen?screen=dashboard"; }, 10);</script>';
        }
    }

    public function createTingkatan()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                $nama = $_POST['nama'];
                $point = $_POST['point'];
                $this->tingkatan->create($nama, $point);
                echo json_encode(['success' => true, 'message' => 'Tingkatan berhasil ditambahkan']);
            } catch (Exception $e) {
                http_response_code(500);
                echo json_encode(['success' => false, 'message' => $e->getMessage()]);
            }
        }
    }

    public function updateTingkatan()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                $id = $_POST['id'];
                $nama = $_POST['nama'];
                $point = $_POST['point'];
                $this->tingkatan->update($id, $nama, $point);
                echo json_encode(['success' => true, 'message' => 'Tingkatan berhasil diupdate']);
            } catch (Exception $e) {
                http_response_code(500);
                echo json_encode(['success' => false, 'message' => $e->getMessage()]);
            }
        }
    }

    public function deleteTingkatan()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                $id = $_POST['id'];
                $this->tingkatan->delete($id);
                echo json_encode(['success' => true, 'message' => 'Tingkatan berhasil dihapus']);
            } catch (Exception $e) {
                http_response_code(500);
                echo json_encode(['success' => false, 'message' => $e->getMessage()]);
            }
        }
    }

    // CRUD for Peringkat
    public function kelola_peringkat()
    {
        try {
            $peringkats = $this->peringkat->getAll();
            $data = [
                "screen" => "kelola_peringkat",
                "title" => "Kelola Peringkat",
                "peringkats" => $peringkats
            ];
            $this->view('admin/kelola_peringkat', $data);
        } catch (Exception $e) {
            echo '<script>alert("Error: ' . $e->getMessage() . '");</script>';
            echo '<script>setTimeout(function(){ window.location.href = "screen?screen=dashboard"; }, 10);</script>';
        }
    }

    public function createPeringkat()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                $nama = $_POST['nama'];
                $multiple = $_POST['multiple'];
                $this->peringkat->create($nama, $multiple);
                echo json_encode(['success' => true, 'message' => 'Peringkat berhasil ditambahkan']);
            } catch (Exception $e) {
                http_response_code(500);
                echo json_encode(['success' => false, 'message' => $e->getMessage()]);
            }
        }
    }

    public function updatePeringkat()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                $id = $_POST['id'];
                $nama = $_POST['nama'];
                $multiple = $_POST['multiple'];
                $this->peringkat->update($id, $nama, $multiple);
                echo json_encode(['success' => true, 'message' => 'Peringkat berhasil diupdate']);
            } catch (Exception $e) {
                http_response_code(500);
                echo json_encode(['success' => false, 'message' => $e->getMessage()]);
            }
        }
    }

    public function deletePeringkat()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                $id = $_POST['id'];
                $this->peringkat->delete($id);
                echo json_encode(['success' => true, 'message' => 'Peringkat berhasil dihapus']);
            } catch (Exception $e) {
                http_response_code(500);
                echo json_encode(['success' => false, 'message' => $e->getMessage()]);
            }
        }
    }
    public function exportExcel()
    {
        try {
            $verifikasiPenghargaanOv = $this->admin->getAllVerifikasiAndPenghargaanOv();

            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();

            
            // Set column headers
            $headers = [
                'A' => 'Nama Mahasiswa',
                'B' => 'Tanggal Lomba', 
                'C' => 'Judul Lomba',
                'D' => 'Tingkatan',
                'E' => 'Verifikasi Admin',
                'F' => 'Verifikasi Dosen',
                'G' => 'Nama Prodi',
                'H' => 'Nama Peringkat'
            ];

            // Style the header row
            $headerStyle = [
                'font' => [
                    'bold' => true,
                    'color' => ['rgb' => 'FFFFFF']
                ],
                'fill' => [
                    'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                    'startColor' => ['rgb' => '4472C4']
                ],
                'alignment' => [
                    'horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER
                ]
            ];

            // Apply headers and styling
            foreach ($headers as $col => $text) {
                $sheet->setCellValue($col . '1', $text);
                $sheet->getColumnDimension($col)->setAutoSize(true);
            }
            $sheet->getStyle('A1:H1')->applyFromArray($headerStyle);

            // Add data rows with styling
            $row = 2;
            $dataStyle = [
                'alignment' => [
                    'vertical' => \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER
                ],
                'borders' => [
                    'allBorders' => [
                        'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN
                    ]
                ]
            ];

            foreach ($verifikasiPenghargaanOv as $verifikasi) {
                $data = [
                    $verifikasi['mahasiswa_name'] ?? '-',
                    $verifikasi['tanggal_mulai'] ?? '-', 
                    $verifikasi['judul'] ?? '-',
                    $verifikasi['tingkatan_nama'] ?? '-',
                    $verifikasi['verif_admin'] ?? '-',
                    $verifikasi['verif_pembimbing'] ?? '-',
                    $verifikasi['prodi_nama'] ?? '-',
                    $verifikasi['peringkat_nama'] ?? '-'
                ];
                
                $sheet->fromArray([$data], null, 'A' . $row);
                $row++;
            }

            // Apply styling to data range
            $lastRow = $row - 1;
            $sheet->getStyle('A1:H' . $lastRow)->applyFromArray($dataStyle);

            // Set zoom level
            $sheet->getSheetView()->setZoomScale(85);

            $writer = new Xlsx($spreadsheet);
            $fileName = 'verifikasi_prestasi.xlsx';

            // Redirect output to a client’s web browser (Xlsx)
            header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            header('Content-Disposition: attachment;filename="' . $fileName . '"');
            header('Cache-Control: max-age=0');
            header('Cache-Control: max-age=1');

            $writer->save('php://output');
            exit;
        } catch (Exception $e) {
            echo '<script>alert("Error: ' . $e->getMessage() . '");</script>';
            echo '<script>setTimeout(function(){ window.location.href = "screen?screen=riwayat"; }, 10);</script>';
        }
    }
}
