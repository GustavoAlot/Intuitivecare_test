# IntuitiveCare - Teste Técnico

Este repositório contém a solução para o teste técnico da IntpriseCare, abordando tarefas de web scraping, transformação de dados, banco de dados, API e frontend.

---

## 📅 Prazo
Entrega realizada em 7 dias corridos, conforme solicitado.

---

## 📁 Estrutura do Projeto

```
intuitivecare_test/
├── banco_dados/                     # Scripts SQL e dados da ANS
│   ├── criar_tabelas.sql
│   ├── importar_dados.sql
│   ├── analiticas.sql
│   └── dados.zip                    # 📦 Arquivos CSV compactados
├── transformacao_dados/            # Extração de dados do PDF do Anexo I
│   ├── extrair_tabela.py
│   ├── substituicoes.csv
│   └── Teste_NomeCandidato.zip
├── api_vue/                        # API Python (FastAPI) + frontend Vue.js
│   ├── backend/
│   │   ├── main.py
│   │   └── operadoras.csv
│   ├── frontend/
│   │   └── (Vue 3 com fetch ao backend)
│   └── intuitivecare_api_postman.json
```

---

## ✅ 1. Web Scraping dos Anexos I e II (PDF)

Scripts em Python realizam o download automático dos anexos do site da ANS, com validação de status HTTP e criação de diretórios seguros.

**Ferramentas usadas**: `requests`, `pathlib`, `os`

---

## ✅ 2. Teste de Transformação de Dados

### Tarefas realizadas:
- Extração da tabela do Anexo I (todas as páginas)
- Conversão para CSV estruturado
- Substituição das colunas "OD" e "AMB" por descrições completas
- Compactação do CSV final em `.zip`

**Ferramentas usadas**: `pdfplumber`, `pandas`, `zipfile`

Arquivo gerado: `Teste_NomeCandidato.zip`

---

## ✅ 3. Teste de Banco de Dados

### Tarefas de preparação:
- Download dos arquivos trimestrais de demonstrações contábeis (2 anos)
- Download do CSV de operadoras ativas (ANS)
- Arquivos foram compactados no `dados.zip`

📦 **Importante:**
Os arquivos CSV estão compactados no arquivo `banco_dados/dados.zip`. Para utilizar os scripts SQL, descompacte este `.zip` para que a estrutura fique:

```
banco_dados/
└── dados/
    ├── operadoras.csv
    ├── demonstracoes_1T2023.csv
    └── ...
```

### Scripts incluídos:
- `criar_tabelas.sql`: Criação de tabelas `operadoras`, `demonstracoes_contabeis_staging` e `demonstracoes_contabeis`
- `importar_dados.sql`: Importa todos os CSVs com `\copy`, realiza consolidação
- `analiticas.sql`: Duas queries analíticas:
  - Top 10 operadoras com maiores despesas médicas no último trimestre
  - Top 10 operadoras com maiores despesas médicas no último ano

**Banco**: PostgreSQL (testado localmente com psql CLI)

---

## ✅ 4. Teste de API

### Backend (FastAPI):
- Rota `GET /buscar?q=texto`
- Busca textual em todas as colunas do CSV de operadoras
- Retorna os registros mais relevantes (top 10)
- CORS liberado para uso com frontend

### Frontend (Vue 3):
- Interface simples com campo de busca textual
- Conecta-se ao backend FastAPI com `fetch`
- Exibe os resultados em tempo real na tela

### Postman:
- A coleção `intuitivecare_api_postman.json` está incluída
- Contém requisição GET para a rota `/buscar?q=amil`

---

## ⚙️ Como executar o projeto

### 📌 Requisitos:
- Python 3.8+
- Node.js 16+
- PostgreSQL 12+ (para testar os scripts SQL)

### ⚡ Backend (FastAPI):
```bash
cd api_vue/backend
pip install -r requirements.txt  # se desejar
uvicorn main:app --host 127.0.0.1 --port 8000 --reload
```

### 🚀 Frontend (Vue):
```bash
cd api_vue/frontend
npm install
npm run dev
```

### 📂 Banco de Dados:
1. Descompacte `banco_dados/dados.zip`
2. Rode os scripts em ordem:
```bash
psql -U seu_usuario -d seu_banco -f banco_dados/criar_tabelas.sql
psql -U seu_usuario -d seu_banco -f banco_dados/importar_dados.sql
psql -U seu_usuario -d seu_banco -f banco_dados/analiticas.sql
```

### 📫 Postman:
- Abra o Postman
- Importe `intuitivecare_api_postman.json`
- Execute a requisição de teste

---

## 💡 Considerações finais

- Todos os dados foram processados com base em arquivos reais da ANS
- A estrutura foi pensada para facilitar reuso, legibilidade e testes
- O backend e frontend se integram de forma fluida
- Scripts e pastas organizados por contexto de entrega
- Utilização de caminhos relativos e estrutura leve para portabilidade

---

🙌 Obrigado pela oportunidade!

**Gustavo Fernandez**

