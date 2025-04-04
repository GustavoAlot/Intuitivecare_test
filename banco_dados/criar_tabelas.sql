-- =============================
-- TABELA DE OPERADORAS
-- =============================
CREATE TABLE IF NOT EXISTS operadoras (
    registro_ans TEXT PRIMARY KEY,
    cnpj TEXT,
    razao_social TEXT,
    nome_fantasia TEXT,
    modalidade TEXT,
    logradouro TEXT,
    numero TEXT,
    complemento TEXT,
    bairro TEXT,
    cidade TEXT,
    uf TEXT,
    cep TEXT,
    ddd TEXT,
    telefone TEXT,
    fax TEXT,
    endereco_eletronico TEXT,
    representante TEXT,
    cargo_representante TEXT,
    regiao_comercializacao TEXT,
    data_registro_ans DATE
);

-- =============================
-- TABELA STAGING – DADOS BRUTOS
-- =============================
CREATE TABLE IF NOT EXISTS demonstracoes_contabeis_staging (
    data DATE,
    reg_ans TEXT,
    cd_conta_contabil TEXT,
    descricao TEXT,
    vl_saldo_inicial TEXT,
    vl_saldo_final TEXT
);

-- =============================
-- TABELA FINAL – TRANSFORMADA
-- =============================
CREATE TABLE IF NOT EXISTS demonstracoes_contabeis (
    id SERIAL PRIMARY KEY,
    operadora_id INTEGER, -- opcional, se quiser associar via chave estrangeira
    data DATE,
    ano INTEGER,
    trimestre INTEGER,
    descricao TEXT,
    vl_saldo_inicial NUMERIC,
    vl_saldo_final NUMERIC,
    reg_ans TEXT
);
