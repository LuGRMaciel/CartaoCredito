from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm import sessionmaker
from db_models import Transacoes, engine, HistoricoContestacao
from sklearn.ensemble import IsolationForest
from datetime import date
import numpy as np
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# Configuração do CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # ou especifique seu domínio
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

Session = sessionmaker(bind=engine)

class TransacaoInput(BaseModel):
    id_transacao: int

@app.get("/")
def home():
    return {"mensagem": "API está funcionando!"}

@app.post("/analisa-fraude")
def analisa_fraude(dados: TransacaoInput):
    session = Session()
    transacao = session.query(Transacoes).filter(Transacoes.id_transacao == dados.id_transacao).first()
    if not transacao:
        session.close()
        raise HTTPException(status_code=404, detail="Transação não encontrada.")

    # Busca histórico do usuário
    historico = session.query(Transacoes).filter(
        Transacoes.id_usuario == transacao.id_usuario,
        Transacoes.id_transacao != transacao.id_transacao
    ).all()

    # Monta dados para o modelo
    X = [[float(t.valor), t.parcelas] for t in historico]
    X.append([float(transacao.valor), transacao.parcelas])  # inclui a transação atual

    resultado = "Não fraude"
    motivo = "Sem suspeita"

    # Só roda o modelo se houver histórico suficiente
    if len(X) > 10:
        modelo = IsolationForest(contamination=0.1, random_state=42)
        preds = modelo.fit_predict(X)
        if preds[-1] == -1:
            resultado = "Fraude"
            motivo = "Transação fora do padrão do usuário (Isolation Forest)"
    else:
        # fallback simples
        if float(transacao.valor) > 1000:
            resultado = "Fraude"
            motivo = "Valor muito alto"

    session.close()
    return {
        "id_transacao": transacao.id_transacao,
        "resultado": resultado,
        "motivo": motivo
    }

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
    contestacao = HistoricoContestacao(
        id_transacao=dados.id_transacao,
        data_contestacao=date.today(),
        fraudulenta=None,
        comentario=None
    )
    session.add(contestacao)
    session.commit()
    session.close()
    return {"mensagem": "Contestação registrada com sucesso."}