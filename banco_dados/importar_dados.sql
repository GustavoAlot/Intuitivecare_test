-- Importação das operadoras
\copy operadoras(registro_ans, cnpj, razao_social, nome_fantasia, modalidade, logradouro, numero, complemento, bairro, cidade, uf, cep, ddd, telefone, fax, endereco_eletronico, representante, cargo_representante, regiao_comercializacao, data_registro_ans) FROM 'banco_dados/dados/operadoras.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8', QUOTE '"');

------------------------------------------------------------
-- Importação dos arquivos trimestrais para a tabela staging

-- 1º Trimestre de 2023
\copy demonstracoes_contabeis_staging(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final) FROM 'banco_dados/dados/1T2023.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');

-- 2º Trimestre de 2023
\copy demonstracoes_contabeis_staging(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final) FROM 'banco_dados/dados/2T2023.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');

-- 3º Trimestre de 2023
\copy demonstracoes_contabeis_staging(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final) FROM 'banco_dados/dados/3T2023.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');

-- 4º Trimestre de 2023
\copy demonstracoes_contabeis_staging(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final) FROM 'banco_dados/dados/4T2023.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');

-- 1º Trimestre de 2024
\copy demonstracoes_contabeis_staging(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final) FROM 'banco_dados/dados/1T2024.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');

-- 2º Trimestre de 2024
\copy demonstracoes_contabeis_staging(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final) FROM 'banco_dados/dados/2T2024.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');

-- 3º Trimestre de 2024
\copy demonstracoes_contabeis_staging(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final) FROM 'banco_dados/dados/3T2024.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');

-- 4º Trimestre de 2024
\copy demonstracoes_contabeis_staging(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final) FROM 'banco_dados/dados/4T2024.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');

------------------------------------------------------------
-- Consolidação dos dados da tabela staging na tabela final

INSERT INTO demonstracoes_contabeis (
    operadora_id, data, ano, trimestre, descricao, vl_saldo_inicial, vl_saldo_final, reg_ans
)
SELECT
    NULL,
    data,
    EXTRACT(YEAR FROM data) AS ano,
    EXTRACT(QUARTER FROM data) AS trimestre,
    descricao,
    REPLACE(vl_saldo_inicial, ',', '.')::NUMERIC,
    REPLACE(vl_saldo_final, ',', '.')::NUMERIC,
    reg_ans
FROM demonstracoes_contabeis_staging;
