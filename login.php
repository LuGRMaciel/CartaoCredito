<?php
/*
Projeto A3 - Sistemas Distribuídos e Mobile (Unicuritiba & Bradesco)

Repositório destinado ao projeto A3 da unidade curricular de Sistemas Distribuídos e Mobile da Unicuritiba em parceria com o Bradesco, que visa a construção de um sistema para verificação de fraudes em contestações de transações de cartão de crédito.
Ferramentas utilizadas: FastAPI, XAMPP e MariaDB.
Linguagens usadas: Python, PHP, CSS, HTML, SQL e JavaScript.
*/
?>
<?php
session_start();
include('header.php');
include ('config.php');

if (@$_REQUEST['botao']=="Entrar") {
    $login = $_POST['login'];
    $senha = $_POST['senha'];

    $query = "SELECT * FROM autenticacao WHERE login = '$login' AND senha = '$senha' ";
    $result = mysqli_query($con, $query);

    if (mysqli_num_rows($result) == 0){ 
        echo "<script>alert('Usuario ou senha incorretos!');window.location='login.php';</script>";
        exit; 
    } else {
        $coluna = mysqli_fetch_assoc($result);
        $_SESSION["id_usuario"] = $coluna["id_usuario"];
        $_SESSION["nome_usuario"] = $coluna["login"];
        $_SESSION["cpf"] = $coluna["cpf"];
        header("Location: lista_transacoes.php");
        exit;
    }
}
?>

<div class="container">
    <h2 style="text-align:center; color:#333;">Login</h2>
    <form action="#" method="post" class="form-login" style="max-width:400px;margin:30px auto;background:#fff;padding:30px;border-radius:10px;box-shadow:0 2px 8px rgba(0,0,0,0.07);">
        <label for="login" style="display:block;margin-bottom:8px;color:#555;">Login:</label>
        <input type="text" name="login" id="login" required style="width:100%;padding:10px;margin-bottom:18px;border:1px solid #ccc;border-radius:6px;">

        <label for="senha" style="display:block;margin-bottom:8px;color:#555;">Senha:</label>
        <input type="password" name="senha" id="senha" required style="width:100%;padding:10px;margin-bottom:18px;border:1px solid #ccc;border-radius:6px;">

        <input type="submit" name="botao" value="Entrar" style="width:100%;padding:12px;background:#4CAF50;color:#fff;border:none;border-radius:6px;font-size:1.1em;cursor:pointer;">
    </form>
</div>
