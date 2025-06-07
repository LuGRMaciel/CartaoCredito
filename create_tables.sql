/*
Projeto A3 - Sistemas Distribuídos e Mobile (Unicuritiba & Bradesco)

Repositório destinado ao projeto A3 da unidade curricular de Sistemas Distribuídos e Mobile da Unicuritiba em parceria com o Bradesco, que visa a construção de um sistema para verificação de fraudes em contestações de transações de cartão de crédito.
Ferramentas utilizadas: FastAPI, XAMPP e MariaDB.
Linguagens usadas: Python, PHP, CSS, HTML, SQL e JavaScript.
*/


-- Script para criação das tabelas do banco de dados do projeto A3
-- Criando o banco de dados e as tabelas necessárias

create database cartao_credito;
use cartao_credito;

CREATE TABLE autenticacao (
    id_usuario int(20) auto_increment PRIMARY KEY,
    login VARCHAR(50) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    nivel VARCHAR(20) NOT NULL
);

INSERT INTO autenticacao (login, senha, cpf, nivel) VALUES
('admin', '123.', '11111111111', 'admin'),
('augustolima', '123', '22222222222', 'cliente'),
('ketlynrayzel', '123', '33333333333', 'cliente'),
('luanagonzaga', '123', '44444444444', 'cliente');

CREATE TABLE base_cadastral (
    id_cadastro int(20) auto_increment PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    data_nascimento DATE NOT NULL,
    cidade_cadastral VARCHAR(100) NOT NULL
);

CREATE TABLE transacoes (
    id_transacao int(20) auto_increment PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    data DATE NOT NULL,
    hora TIME NOT NULL,
    estabelecimento VARCHAR(100) NOT NULL,
    valor decimal(22,2) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    forma_pagamento VARCHAR(20) NOT NULL,
    parcelas INTEGER NOT NULL DEFAULT 1,
    tipo_cartao VARCHAR(20) NOT NULL,
    vencimento_fatura DATE NOT NULL
);

INSERT INTO transacoes (
    id_usuario, data, hora, estabelecimento, valor, cidade, forma_pagamento, parcelas, tipo_cartao, vencimento_fatura
) VALUES
(2, '2025-04-01', '10:15:00', 'Supermercado Y', 120.50, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-02', '12:30:00', 'Farmácia A', 35.90, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-03', '14:45:00', 'Café Central', 22.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-04', '16:00:00', 'Loja_online_2', 320.38, 'Curitiba', 'parcelado', 2, 'virtual', '2025-05-01'),
(2, '2025-04-05', '18:10:00', 'Pet Shop', 188.21, 'Curitiba', 'parcelado', 2, 'físico', '2025-05-01'),
(3, '2025-04-01', '09:20:00', 'Supermercado Y', 110.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-02', '11:35:00', 'Farmácia A', 40.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-03', '13:50:00', 'Café Central', 25.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-04', '15:05:00', 'Loja_online_2', 210.00, 'Curitiba', 'parcelado', 2, 'virtual', '2025-05-01'),
(3, '2025-04-05', '17:15:00', 'Pet Shop', 150.00, 'Curitiba', 'parcelado', 2, 'físico', '2025-05-01'),
(4, '2025-04-01', '08:25:00', 'Supermercado Y', 130.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-02', '10:40:00', 'Farmácia A', 38.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-03', '12:55:00', 'Café Central', 28.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-04', '14:10:00', 'Loja_online_2', 180.00, 'Curitiba', 'parcelado', 2, 'virtual', '2025-05-01'),
(4, '2025-04-05', '16:20:00', 'Pet Shop', 170.00, 'Curitiba', 'parcelado', 2, 'físico', '2025-05-01'),
(2, '2025-04-06', '00:00:00', 'Estab_1', 75.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-07', '01:00:00', 'Estab_2', 80.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-08', '02:00:00', 'Estab_3', 85.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-09', '03:00:00', 'Estab_4', 90.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-10', '04:00:00', 'Estab_5', 95.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-11', '05:00:00', 'Estab_6', 100.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-12', '06:00:00', 'Estab_7', 105.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-13', '07:00:00', 'Estab_8', 110.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-14', '08:00:00', 'Estab_9', 115.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-15', '09:00:00', 'Estab_10', 120.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-16', '10:00:00', 'Estab_11', 125.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-17', '11:00:00', 'Estab_12', 130.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-18', '12:00:00', 'Estab_13', 135.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-19', '13:00:00', 'Estab_14', 140.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-20', '14:00:00', 'Estab_15', 145.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-21', '15:00:00', 'Estab_16', 150.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-22', '16:00:00', 'Estab_17', 155.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-23', '17:00:00', 'Estab_18', 160.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-24', '18:00:00', 'Estab_19', 165.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-25', '19:00:00', 'Estab_20', 170.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-26', '20:00:00', 'Estab_21', 175.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-27', '21:00:00', 'Estab_22', 180.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-28', '22:00:00', 'Estab_23', 185.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(2, '2025-04-29', '23:00:00', 'Estab_24', 190.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-06', '00:00:00', 'Estab_1', 75.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-07', '01:00:00', 'Estab_2', 80.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-08', '02:00:00', 'Estab_3', 85.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-09', '03:00:00', 'Estab_4', 90.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-10', '04:00:00', 'Estab_5', 95.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-11', '05:00:00', 'Estab_6', 100.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-12', '06:00:00', 'Estab_7', 105.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-13', '07:00:00', 'Estab_8', 110.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-14', '08:00:00', 'Estab_9', 115.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-15', '09:00:00', 'Estab_10', 120.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-16', '10:00:00', 'Estab_11', 125.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-17', '11:00:00', 'Estab_12', 130.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-18', '12:00:00', 'Estab_13', 135.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-19', '13:00:00', 'Estab_14', 140.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-20', '14:00:00', 'Estab_15', 145.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-21', '15:00:00', 'Estab_16', 150.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-22', '16:00:00', 'Estab_17', 155.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-23', '17:00:00', 'Estab_18', 160.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-24', '18:00:00', 'Estab_19', 165.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-25', '19:00:00', 'Estab_20', 170.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-26', '20:00:00', 'Estab_21', 175.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-27', '21:00:00', 'Estab_22', 180.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-28', '22:00:00', 'Estab_23', 185.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(3, '2025-04-29', '23:00:00', 'Estab_24', 190.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-06', '00:00:00', 'Estab_1', 75.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-07', '01:00:00', 'Estab_2', 80.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-08', '02:00:00', 'Estab_3', 85.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-09', '03:00:00', 'Estab_4', 90.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-10', '04:00:00', 'Estab_5', 95.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-11', '05:00:00', 'Estab_6', 100.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-12', '06:00:00', 'Estab_7', 105.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-13', '07:00:00', 'Estab_8', 110.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-14', '08:00:00', 'Estab_9', 115.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-15', '09:00:00', 'Estab_10', 120.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-16', '10:00:00', 'Estab_11', 125.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-17', '11:00:00', 'Estab_12', 130.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-18', '12:00:00', 'Estab_13', 135.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-19', '13:00:00', 'Estab_14', 140.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-20', '14:00:00', 'Estab_15', 145.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-21', '15:00:00', 'Estab_16', 150.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-22', '16:00:00', 'Estab_17', 155.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-23', '17:00:00', 'Estab_18', 160.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-24', '18:00:00', 'Estab_19', 165.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-25', '19:00:00', 'Estab_20', 170.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-26', '20:00:00', 'Estab_21', 175.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-27', '21:00:00', 'Estab_22', 180.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-28', '22:00:00', 'Estab_23', 185.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(4, '2025-04-29', '23:00:00', 'Estab_24', 190.00, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01');

 CREATE TABLE historico_contestacao (
    id_contestacao int(20) auto_increment PRIMARY KEY,
    id_transacao INTEGER NOT NULL,
    data_contestacao DATE NOT NULL,
    fraudulenta VARCHAR(10),
    comentario varchar(255)
);
