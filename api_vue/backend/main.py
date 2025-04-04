from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware
import pandas as pd

app = FastAPI()

# Libera acesso do frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Tenta carregar o CSV
try:
    df = pd.read_csv("operadoras.csv", sep=";", dtype=str).fillna("")
except Exception as e:
    print(f"Erro ao carregar CSV: {e}")
    df = pd.DataFrame()

print("Colunas do CSV:", df.columns.tolist())


@app.get("/buscar")
def buscar_operadoras(q: str = Query(..., min_length=1)):
    if df.empty:
        return []

    resultados = df[df.apply(lambda row: q.lower() in row.astype(str).str.lower().str.cat(sep=" "), axis=1)]
    return resultados.head(10).to_dict(orient="records")
