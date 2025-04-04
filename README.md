# IntuitiveCare Test Project

Este projeto contém os testes de nivelamento conforme solicitado:

- **web_scraping:** Scripts para baixar PDFs do site da ANS e compactá-los.
- **transformacao_dados:** Scripts para extrair tabelas do PDF, transformar os dados e gerar um CSV.
- **banco_dados:** Scripts SQL para criação de tabelas, importação dos dados e execução de queries analíticas.
- **api:** API desenvolvida com FastAPI para realizar uma busca textual no CSV de operadoras.
- **postman:** Coleção Postman para demonstrar a API.

## Instruções

### Web Scraping
1. Instale as dependências listadas em `web_scraping/requisitos.txt`.
2. Execute o script `web_scraping/baixar_e_zipar.py` para baixar os PDFs e compactá-los.

### Transformação de Dados
1. Configure o caminho do PDF de entrada no script `transformacao_dados/extrair_tabela.py`.
2. Execute o script para gerar o CSV e aplicar as substituições definidas em `transformacao_dados/substituicoes.csv`.

### Banco de Dados
1. Utilize os scripts SQL em `banco_dados/` para criar tabelas, importar dados e executar as queries analíticas.
2. Ajuste os caminhos e configurações conforme o seu ambiente de banco de dados.

### API
1. Instale as dependências listadas em `api/requirements.txt`.
2. Execute o servidor com:
   ```bash
   uvicorn main:app --reload
