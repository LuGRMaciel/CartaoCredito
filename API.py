"""
Projeto A3 - Sistemas Distribuídos e Mobile (Unicuritiba & Bradesco)

Repositório destinado ao projeto A3 da unidade curricular de Sistemas Distribuídos e Mobile da Unicuritiba em parceria com o Bradesco, que visa a construção de um sistema para verificação de fraudes em contestações de transações de cartão de crédito.
Ferramentas utilizadas: FastAPI, XAMPP e MariaDB.
Linguagens usadas: Python, PHP, CSS, HTML, SQL e JavaScript.
"""

# Importação das bibliotecas necessárias
from fastapi import FastAPI, HTTPException  # FastAPI para criar a API, HTTPException para erros HTTP
from pydantic import BaseModel              # BaseModel para validação de dados de entrada
from sqlalchemy.orm import sessionmaker     # sessionmaker para criar sessões do banco de dados
from db_models import Transacoes, engine, HistoricoContestacao  # Modelos e engine do banco
from sklearn.ensemble import IsolationForest # IsolationForest para detecção de anomalias (fraudes)
from datetime import date                   # Para manipular datas
import numpy as np                          # Biblioteca para operações numéricas (usada pelo IsolationForest)
from fastapi.middleware.cors import CORSMiddleware # Middleware para permitir requisições de outros domínios (CORS)

# Instancia a aplicação FastAPI
app = FastAPI()

# Configuração do CORS para permitir requisições de qualquer origem
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Permite qualquer domínio
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Cria uma fábrica de sessões do banco de dados
Session = sessionmaker(bind=engine)

# Modelo de entrada para a análise de fraude (espera um id_transacao)
class TransacaoInput(BaseModel):
    id_transacao: int

# Endpoint GET para testar se a API está funcionando
@app.get("/")
def home():
    return {"mensagem": "API está funcionando!"}

# Endpoint POST para analisar fraude em uma transação
@app.post("/analisa-fraude")
def analisa_fraude(dados: TransacaoInput):
    session = Session()  # Abre uma sessão do banco
    # Busca a transação pelo id informado
    transacao = session.query(Transacoes).filter(Transacoes.id_transacao == dados.id_transacao).first()
    if not transacao:
        session.close()
        raise HTTPException(status_code=404, detail="Transação não encontrada.")

    # Busca o histórico de transações do mesmo usuário, exceto a transação atual
    historico = session.query(Transacoes).filter(
        Transacoes.id_usuario == transacao.id_usuario,
        Transacoes.id_transacao != transacao.id_transacao
    ).all()

    # Monta os dados numéricos (valor e parcelas) para o modelo de detecção de anomalias
    X = [[float(t.valor), t.parcelas] for t in historico]
    X.append([float(transacao.valor), transacao.parcelas])  # Adiciona a transação atual para análise

    resultado = "Não fraude"
    motivo = "Sem suspeita"

    # Só executa o Isolation Forest se houver histórico suficiente (>10 transações)
    if len(X) > 10:
        modelo = IsolationForest(contamination=0.1, random_state=42)  # Cria o modelo
        preds = modelo.fit_predict(X)  # Treina e prediz anomalias
        if preds[-1] == -1:  # Se a última transação (a analisada) for anômala
            resultado = "Fraude"
            motivo = "Transação fora do padrão do usuário (Isolation Forest)"
    else:
        # Se não houver histórico suficiente, usa uma regra simples de valor alto
        if float(transacao.valor) > 1000:
            resultado = "Fraude"
            motivo = "Valor muito alto"

    session.close()  # Fecha a sessão do banco
    # Retorna o resultado da análise
    return {
        "id_transacao": transacao.id_transacao,
        "resultado": resultado,
        "motivo": motivo
    }

# Endpoint POST para registrar uma contestação de transação
@app.post("/registrar-contestacao")
def registrar_contestacao(dados: TransacaoInput):
    session = Session()
    # Verifica se já existe contestação para essa transação
    existe = session.query(HistoricoContestacao).filter(
        HistoricoContestacao.id_transacao == dados.id_transacao
    ).first()
    if existe:
        session.close()
        return {"mensagem": "Contestação já registrada para esta transação."}
    # Cria um novo registro de contestação
    contestacao = HistoricoContestacao(
        id_transacao=dados.id_transacao,
        data_contestacao=date.today(),
        fraudulenta=None,
        comentario=None
    )
    session.add(contestacao)  # Adiciona ao banco
    session.commit()          # Salva as alterações
    session.close()           # Fecha a sessão
    return {"mensagem": "Contestação registrada com sucesso."}