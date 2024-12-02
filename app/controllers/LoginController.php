<?php

require_once 'app/models/Login.php';

class LoginController extends Controller
{
    private $login;

    public function __construct()
    {
        $this->login = new Login(Database::getInstance(getDatabaseConfig(), [$this, 'error']));
    }

    public function index()
    {
        $this->view('landing/index', []);
    }
    public function login()
    {
        $this->view('login/index', ['']);
    }
    public function postLogin()
    {
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $username = $_POST['username'];
            $password = $_POST['password'];
            Session::set('username', $username);
            Session::set('password', $password);
            $this->dologin();
        }
    }

    public function dologin()
    {
        $role = $this->login->getRole(Session::get('username'), Session::get('password'));
        Session::set('role', $role);


        $user = $this->login->getUser(Session::get('username'), Session::get('password'), $role);
        if (!$role) {
            $username = Session::get('username');
            $password = Session::get('password');
            Session::destroy();
            Session::start();
            $this->view('login/index', ['not_found' => true, 'username' => $username, 'password' => $password]);

            return;
        }
        switch ($role['role']) {
            case 'admin':
                require_once 'app/controllers/AdminController.php';
                header("Location: admin/index");
                break;
            case 'dosen':
                $this->view('dosen/index', ['user' => $user]);
                break;
            case 'mahasiswa':
                $this->view('mahasiswa/index', ['user' => $user]);
                break;
            default:
                echo "Username atau Password Salah";

                // $username = Session::get('username');
                // $password = Session::get('password');
                // $level = Session::get('level');
                // Session::destroy();
                // Session::start();
                // $this->view('login/index', ['not_found' => true, 'username' => $username, 'password' => $password, 'level' => $level]);
                break;
        }
    }
}
