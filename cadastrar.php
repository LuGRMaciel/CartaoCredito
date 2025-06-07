<?php
/*
Projeto A3 - Sistemas Distribuídos e Mobile (Unicuritiba & Bradesco)

Repositório destinado ao projeto A3 da unidade curricular de Sistemas Distribuídos e Mobile da Unicuritiba em parceria com o Bradesco, que visa a construção de um sistema para verificação de fraudes em contestações de transações de cartão de crédito.
Ferramentas utilizadas: FastAPI, XAMPP e MariaDB.
Linguagens usadas: Python, PHP, CSS, HTML, SQL e JavaScript.
*/
?>

<?php
include('header.php'); // Inclui o cabeçalho da página
include('config.php'); // Inclui as configurações de conexão com o banco

// Verifica se o formulário foi enviado
if (isset($_POST['botao'])){
    $login  = $_POST['login'];   // Recebe o login do formulário
    $senha  = $_POST['senha'];   // Recebe a senha do formulário
    $nivel  = $_POST['nivel'];   // Recebe o nível do formulário
    $cpf    = $_POST['cpf'];     // Recebe o CPF do formulário (não está sendo usado no insert)

    // Insere o novo usuário na tabela (ajuste o nome da tabela para 'autenticacao' se necessário)
    $query = "INSERT INTO usuario (login, senha, nivel) VALUES ('$login', '$senha', '$nivel')";
    $result = mysqli_query($con, $query);

    // Verifica se o cadastro foi realizado com sucesso
    if($result){
        echo "<script>alert('Usuário cadastrado com sucesso!');window.location='login.php';</script>";
        exit;
    } else {
        echo "<script>alert('Erro ao cadastrar usuário!');</script>";
    }
}
?>

<div class="container">
    <h2 style="text-align:center; color:#333;">Cadastro de Usuário</h2>
    <form action="#" method="post" class="form-cadastro" style="max-width:400px;margin:30px auto;background:#fff;padding:30px;border-radius:10px;box-shadow:0 2px 8px rgba(0,0,0,0.07);">
        <label for="login" style="display:block;margin-bottom:8px;color:#555;">Login:</label>
        <input type="text" name="login" id="login" required style="width:100%;padding:10px;margin-bottom:18px;border:1px solid #ccc;border-radius:6px;">

        <label for="senha" style="display:block;margin-bottom:8px;color:#555;">Senha:</label>
        <input type="password" name="senha" id="senha" required style="width:100%;padding:10px;margin-bottom:18px;border:1px solid #ccc;border-radius:6px;">

        <label for="nivel" style="display:block;margin-bottom:8px;color:#555;">Nível:</label>
        <select name="nivel" id="nivel" required style="width:100%;padding:10px;margin-bottom:18px;border:1px solid #ccc;border-radius:6px;">
            <option value="">Selecione...</option>
            <option value="USER">Usuário</option>
            <option value="ADM">Administrador</option>
        </select>

        <input type="submit" name="botao" value="Cadastrar" style="width:100%;padding:12px;background:#4CAF50;color:#fff;border:none;border-radius:6px;font-size:1.1em;cursor:pointer;">
    </form>
</div>
