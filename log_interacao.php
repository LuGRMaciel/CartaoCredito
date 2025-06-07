<?php
$data = json_decode(file_get_contents('php://input'), true);
file_put_contents(
    'front_interactions.log',
    date('Y-m-d H:i:s') . " - Ação: {$data['acao']} - Transação: {$data['id_transacao']}\n",
    FILE_APPEND
);
?>