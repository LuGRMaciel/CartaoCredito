<?php
include('header.php');

// Recupera o ID do usuário da sessão
$id_usuario = isset($_SESSION['id_usuario']) ? $_SESSION['id_usuario'] : null;
?>
<div class="container">
    <h1 class="titulo-principal">Portal Bradesco Cartões</h1>

    <!-- <?php
    if ($id_usuario) {
        echo "<div class='usuario-logado' style='text-align:center;margin-bottom:20px;'>";
        echo "<strong>Bem-vindo, " . htmlspecialchars($_SESSION["nome_usuario"]) . "!</strong>";
        echo "<br><a href='logout.php' style='color:#6D2E2A;text-decoration:none;'>Sair</a>";
        echo "</div>";
    } else {
        echo "<div class='usuario-nao-logado' style='text-align:center;margin-bottom:20px;'>";
        echo "<strong>Você não está logado.</strong>";
        echo "<br><a href='login.php' style='color:#6D2E2A;text-decoration:none;'>Faça login</a> ou <a href='cadastrar.php' style='color:#6D2E2A;text-decoration:none;'>cadastre-se</a>.";
        echo "</div>";
    }
    ?> -->

    <form method="get" style="max-width:400px;margin:0 auto 30px auto;display:flex;gap:10px;">
        <input type="text" name="busca" placeholder="Pesquisar por estabelecimento, data ou valor" style="flex:1;padding:10px;border:1px solid #ccc;border-radius:6px;">
        <button type="submit" style="padding:10px 20px;background:#6D2E2A;color:#fff;border:none;border-radius:6px;cursor:pointer;">Pesquisar</button>
    </form>

    <div class="anuncios">
        <?php
        include('config.php');

        $filtro = "";
        if (isset($_GET['busca']) && $_GET['busca'] != "") {
            $busca = mysqli_real_escape_string($con, $_GET['busca']);
            $filtro = "AND (estabelecimento LIKE '%$busca%' OR valor LIKE '%$busca%' OR DATE_FORMAT(data, '%d/%m/%Y') LIKE '%$busca%')";
        }

        // Use id_usuario no filtro
        $query = "SELECT * FROM transacoes WHERE id_usuario = '$id_usuario' $filtro ORDER BY data DESC";
        $result = mysqli_query($con, $query);

        $num_rows = mysqli_num_rows($result);
        if ($num_rows == 0) {
            if ($id_usuario) {
                echo "<div style='text-align:center;width:100%;'>Não há nenhuma transação postada na sua fatura.</div>";
            }
        } else {
            while ($anuncio = mysqli_fetch_assoc($result)) {
                echo "<div class='anuncio'>";
                echo "<h2>" . htmlspecialchars($anuncio['data']) . "</h2>";
                echo "<p>" . htmlspecialchars($anuncio['estabelecimento']) . "</p>";
                echo "<div class='valor'>R$ " . htmlspecialchars($anuncio['valor']) . "</div>";
                // Botão contestar com atributos data
                echo "<button class='btn-contestar' data-id='" . htmlspecialchars($anuncio['id_transacao']) . "'>Contestar</button>";
                echo "</div>";
            }
        }
        ?>
    </div>
</div>

<script>
document.querySelectorAll('.btn-contestar').forEach(function(btn) {
    btn.addEventListener('click', function() {
        const id = this.dataset.id;

        fetch('http://127.0.0.1:8000/analisa-fraude', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ id_transacao: id })
        })
        .then(response => response.json())
        .then(data => {
            let msg = "";
            if (data.resultado === "Fraude") {
                msg = `<div style="color:#fff;background:#c0392b;padding:15px;border-radius:8px;margin:10px 0;">
                        <strong>Fraude detectada! Vamos fazer o estorno da sua compra :)</strong><br>${data.motivo}
                       </div>`;
            } else {
                msg = `<div style="color:#fff;background:#27ae60;padding:15px;border-radius:8px;margin:10px 0;">
                        <strong>Transação normal, se ainda precisa de ajuda, entre em contato com a Bia :)</strong><br>${data.motivo}
                       </div>`;
            }
            // Mostra mensagem estilizada logo após o botão
            const div = document.createElement('div');
            div.innerHTML = msg;
            btn.parentNode.insertBefore(div, btn.nextSibling);
            setTimeout(() => div.remove(), 4000);

            // Registra contestação no banco
            fetch('http://127.0.0.1:8000/registrar-contestacao', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ id_transacao: id })
            });
        })
        .catch(() => {
            alert('Erro ao analisar a transação. Tente novamente.');
        });
    });
});
</script>

<?php include('footer.php'); ?>