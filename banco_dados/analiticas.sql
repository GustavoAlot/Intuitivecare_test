--10 operadoras com maiores despesas no ultimo trimestre
WITH ultimo_trimestre AS (
    SELECT ano, trimestre
    FROM demonstracoes_contabeis
    ORDER BY ano DESC, trimestre DESC
    LIMIT 1
)
SELECT
    dc.reg_ans,
    o.razao_social,
    dc.ano,
    dc.trimestre,
    SUM(dc.vl_saldo_final) AS despesa_eventos
FROM demonstracoes_contabeis dc
LEFT JOIN operadoras o ON o.registro_ans = dc.reg_ans
JOIN ultimo_trimestre ut ON dc.ano = ut.ano AND dc.trimestre = ut.trimestre
WHERE dc.descricao ILIKE '%EVENTOS%' AND dc.descricao ILIKE '%MEDICO%'
GROUP BY dc.reg_ans, o.razao_social, dc.ano, dc.trimestre
ORDER BY despesa_eventos DESC
LIMIT 10;


-- 10 operadoras com maiores despesas no ultimo ano (soma dos 4 trimestres)
WITH ultimo_ano AS (
    SELECT ano
    FROM demonstracoes_contabeis
    ORDER BY ano DESC
    LIMIT 1
)
SELECT
    dc.reg_ans,
    o.razao_social,
    dc.ano,
    SUM(dc.vl_saldo_final) AS total_despesa_eventos
FROM demonstracoes_contabeis dc
LEFT JOIN operadoras o ON o.registro_ans = dc.reg_ans
JOIN ultimo_ano ua ON dc.ano = ua.ano
WHERE dc.descricao ILIKE '%EVENTOS%' AND dc.descricao ILIKE '%MEDICO%'
GROUP BY dc.reg_ans, o.razao_social, dc.ano
ORDER BY total_despesa_eventos DESC
LIMIT 10;

