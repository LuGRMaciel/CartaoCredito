<?php
// filepath: c:\xampp\htdocs\ProjetoA3Filipack\logout.php
session_start();
session_destroy();
header("Location: login.php");
exit;
?>