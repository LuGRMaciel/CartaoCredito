from sqlalchemy import create_engine, Column, Integer, String, Date, Time, DECIMAL
from sqlalchemy.ext.declarative import declarative_base

DATABASE_URL = "mysql+mysqlconnector://root:@localhost:3306/cartao_credito"
engine = create_engine(DATABASE_URL)
Base = declarative_base()

# Modelo da tabela de autenticação de usuários
class Autenticacao(Base):
    __tablename__ = "autenticacao"
    
    id_usuario = Column(Integer, primary_key=True, autoincrement=True)  # Identificador único do usuário
    login = Column(String(50), unique=True, nullable=False)  # Nome do usuário
    senha = Column(String(255), nullable=False)  # Senha protegida via hash
    cpf = Column(String(11), unique=True, nullable=False)  # CPF único do usuário
    nivel = Column(String(20), nullable=False)  # Nível de acesso (admin ou cliente)

# Modelo da tabela de dados cadastrais dos usuários
class BaseCadastral(Base):
    __tablename__ = "base_cadastral"
    
    id_cadastro = Column(Integer, primary_key=True, autoincrement=True)  # Identificador único do cadastro
    nome = Column(String(100), nullable=False)  # Nome completo do usuário
    endereco = Column(String(255), nullable=False)  # Endereço do usuário
    cpf = Column(String(11), unique=True, nullable=False)  # CPF único do usuário
    data_nascimento = Column(Date, nullable=False)  # Data de nascimento
    cidade_cadastral = Column(String(100), nullable=False)  # Cidade onde foi feito o cadastro

# Modelo da tabela que armazena as transações financeiras
class Transacoes(Base):
    __tablename__ = "transacoes"
    
    id_transacao = Column(Integer, primary_key=True, autoincrement=True)  # Identificador único da transação
    id_usuario = Column(Integer, nullable=False)  # ID do usuário que realizou a transação
    data = Column(Date, nullable=False)  # Data da transação
    hora = Column(Time, nullable=False)  # Hora da transação
    estabelecimento = Column(String(100), nullable=False)  # Nome do estabelecimento onde a compra foi realizada
    valor = Column(DECIMAL(22,2), nullable=False)  # Valor da transação
    cidade = Column(String(100), nullable=False)  # Cidade onde ocorreu a transação
    forma_pagamento = Column(String(20), nullable=False)  # Método de pagamento utilizado (cartão, dinheiro etc.)
    parcelas = Column(Integer, nullable=False, default=1)  # Número de parcelas do pagamento
    tipo_cartao = Column(String(20), nullable=False)  # Tipo de cartão utilizado na transação (crédito ou débito)
    vencimento_fatura = Column(Date, nullable=False)  # Data de vencimento da fatura do cartão

# Modelo da tabela para contestação de transações
class HistoricoContestacao(Base):
    __tablename__ = "historico_contestacao"
    
    id_contestacao = Column(Integer, primary_key=True, autoincrement=True)  # Identificador único da contestação
    id_transacao = Column(Integer, nullable=False)  # ID da transação contestada
    data_contestacao = Column(Date, nullable=False)  # Data em que a contestação foi registrada
    fraudulenta = Column(String(10))  # Indica se a contestação foi identificada como fraude
    comentario = Column(String(255))  # Comentário adicional do usuário sobre a contestação

# Se quiser criar as tabelas automaticamente (opcional):
Base.metadata.create_all(bind=engine)