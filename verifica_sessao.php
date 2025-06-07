<?php
/*
Projeto A3 - Sistemas Distribuídos e Mobile (Unicuritiba & Bradesco)

Repositório destinado ao projeto A3 da unidade curricular de Sistemas Distribuídos e Mobile da Unicuritiba em parceria com o Bradesco, que visa a construção de um sistema para verificação de fraudes em contestações de transações de cartão de crédito.
Ferramentas utilizadas: FastAPI, XAMPP e MariaDB.
Linguagens usadas: Python, PHP, CSS, HTML, SQL e JavaScript.
*/
?>

<?php 
session_start(); // Inicia a sessão PHP

// Verifica se o usuário está logado (se as variáveis de sessão existem)
if(!isset($_SESSION["id_usuario"]) || !isset($_SESSION["nome_usuario"]) || !isset($_SESSION["nivel"])) 
{ 
    // Se não estiver logado, redireciona para a página de login
    header("Location: login.php"); 
    exit; 
} 
?>