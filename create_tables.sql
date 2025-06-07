C:\xampp\mysql\bin\mysql -u root -p

create database cartao_credito;
use cartao_credito;

drop table if exists autenticacao;
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
    id_transacao, id_usuario, data, hora, estabelecimento, valor, cidade, forma_pagamento, parcelas, tipo_cartao, vencimento_fatura
) VALUES
(31, 2, '2025-04-07', '13:41:00', 'Supermercado Y', 311.54, 'Curitiba', 'parcelado', 2, 'físico', '2025-05-01'),
(34, 2, '2025-04-07', '20:36:00', 'Farmácia A', 31.04, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(6, 2, '2025-04-08', '13:05:00', 'Café Central', 52.28, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(100, 2, '2025-04-08', '14:35:00', 'Loja_online_2', 320.38, 'Curitiba', 'parcelado', 2, 'virtual', '2025-05-01'),
(59, 2, '2025-04-08', '14:55:00', 'Pet Shop', 188.21, 'Curitiba', 'parcelado', 2, 'físico', '2025-05-01'),
(22, 2, '2025-04-08', '19:31:00', 'Posto B', 256.67, 'Curitiba', 'parcelado', 4, 'físico', '2025-05-01'),
(33, 2, '2025-04-09', '19:28:00', 'Café Central', 11.67, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(88, 2, '2025-04-10', '12:48:00', 'Academia Fit', 242.8, 'Curitiba', 'parcelado', 3, 'físico', '2025-05-01'),
(70, 2, '2025-04-10', '13:43:00', 'Café Central', 43.18, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(48, 2, '2025-04-10', '16:31:00', 'Restaurante Z', 101.97, 'Florianópolis', 'parcelado', 2, 'físico', '2025-05-01'),
(5, 2, '2025-04-10', '21:03:00', 'Cinema', 69.29, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(79, 2, '2025-04-11', '14:12:00', 'Cinema', 43.57, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(61, 2, '2025-04-12', '13:11:00', 'Academia Fit', 146.18, 'Curitiba', 'parcelado', 4, 'físico', '2025-05-01'),
(8, 2, '2025-04-12', '19:20:00', 'Restaurante Z', 245.77, 'Curitiba', 'parcelado', 10, 'físico', '2025-05-01'),
(21, 2, '2025-04-12', '09:32:00', 'Loja_online_1', 782.84, 'Curitiba', 'parcelado', 4, 'virtual', '2025-05-01'),
(28, 2, '2025-04-13', '10:20:00', 'Loja X', 353.7, 'Curitiba', 'parcelado', 3, 'físico', '2025-05-01'),
(54, 2, '2025-04-13', '21:09:00', 'Posto B', 350.75, 'Curitiba', 'parcelado', 4, 'físico', '2025-05-01'),
(9, 2, '2025-04-15', '16:16:00', 'Restaurante Z', 86.96, 'Curitiba', 'à vista', 1, 'físico', '2025-05-01'),
(37, 2, '2025-04-16', '12:19:00', 'Loja_online_1', 256.84, 'Curitiba', 'parcelado', 3, 'virtual', '2025-05-01'),
(56, 2, '2025-04-16', '20:27:00', 'Posto B', 382.61, 'Curitiba', 'parcelado', 2, 'físico', '2025-05-01');


 CREATE TABLE historico_contestacao (
    id_contestacao int(20) auto_increment PRIMARY KEY,
    id_transacao INTEGER NOT NULL,
    data_contestacao DATE NOT NULL,
    fraudulenta VARCHAR(10),
    comentario varchar(255)
);
------------------------------------------------------------------------------------------------
create database sistema;

create table anuncios (
    id_anuncio int(5) auto_increment, 
    titulo varchar(50), 
    valor decimal(22,2), 
    descricao varchar(250), 
    id_usuario int(3), 
    data date, 
    nome_imagem varchar(500), 
    indicador_aprovacao boolean, 

primary key(id_anuncio));

create table usuario (
    id int(3) auto_increment, 
    login varchar(15), 
    senha varchar(70), 
    nivel varchar(10), 

primary key (id) );


insert into usuario (login, senha, nivel) values ('LuGRMaciel', sha256(), 'ADM');