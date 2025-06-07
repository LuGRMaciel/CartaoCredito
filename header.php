<?php
session_start();// filepath: c:\xampp\htdocs\ProjetoA3Filipack\header.php
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Web de Milhões</title>
    <style>
        /* Cole aqui o mesmo CSS usado na sua página inicial */
        body {
            background: #d9c2a3;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .titulo-principal {
            text-align: left;
            font-size: 2.8em;
            color:rgb(100, 31, 26);
            font-weight: bold;
            letter-spacing: 1px;
            margin-bottom: 32px;
            margin-top: 0;
            font-family: 'Segoe UI', 'Arial', sans-serif;
        }
        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 20px;
        }
        .lista {
            display: block;
            width: 100%;
            padding: 0;
            margin: 0;
        }
        .actions {
            text-align: right;
            margin-bottom: 40px;
            padding-right: 20px; /* opcional, só para afastar um pouco da borda */
        }
        .actions a {
            display: inline-block;
            background: #6D2E2A; /* Marrom escuro */
            color: #fff;
            text-decoration: none;
            padding: 14px 32px;
            border-radius: 8px;
            margin: 0 10px;
            font-size: 1.1em;
            transition: background 0.2s;
        }
        .actions a:hover {
            background: #E2725B; /* Terracota */
        }
        .anuncio {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            width: 100%;
            max-width: 800px;
            padding: 12px 18px;
            margin: 14px auto;
            display: flex;
            align-items: center;
            gap: 24px;
            min-height: 60px;
            box-sizing: border-box;
            position: relative;
        }
        .anuncio img {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 0;           /* Remove espaço extra */
        }
        .anuncio h2, .anuncio p {
            margin: 0 12px 0 0;
            display: inline-block;
            vertical-align: middle;
        }
        .anuncio .valor {
            font-weight: bold;
            color: #6D2E2A;
            font-size: 1.1em;
            margin-left: auto;   /* empurra o valor para a direita */
            margin-right: 12px;  /* espaço entre valor e botão */
        }
        .anuncio .btn-contestar {
            /* já está alinhado à direita pelo flex */
            padding: 8px 18px;
            background: #6D2E2A;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1em;
            transition: background 0.2s;
        }
        .anuncio .btn-contestar:hover {
            background: #E2725B;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="actions">
        <?php
        if (isset($_SESSION["id_usuario"])) {
            // Usuário logado: mostra Início e Sair
            // echo '<a href="pagina_inicial.php">Início</a>';
            echo '<a href="logout.php">Sair</a>';
        } else {
            // Não logado: mostra Cadastrar e Login
            echo '<a href="cadastrar.php">Cadastrar</a>';
            echo '<a href="login.php">Login</a>';
        }
        ?>
    </div>