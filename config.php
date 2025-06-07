<?php
/*
Projeto A3 - Sistemas Distribuídos e Mobile (Unicuritiba & Bradesco)

Repositório destinado ao projeto A3 da unidade curricular de Sistemas Distribuídos e Mobile da Unicuritiba em parceria com o Bradesco, que visa a construção de um sistema para verificação de fraudes em contestações de transações de cartão de crédito.
Ferramentas utilizadas: FastAPI, XAMPP e MariaDB.
Linguagens usadas: Python, PHP, CSS, HTML, SQL e JavaScript.
*/
?>
<?php
$con = mysqli_connect('localhost','root','');
$db = mysqli_select_db($con, 'cartao_credito');
	
if(!$con || !$db)
{
	echo "<pre>";
	echo mysqli_error($con);
	echo "</pre>";
}
?>