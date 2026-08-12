USE Motriz;

-- ============================================================
-- C01
-- Quantas OS existem em cada status, numa unidade específica.
-- ============================================================

SET @unidade_id = 1;

SELECT
    u.id AS unidade_id,
    u.nome AS unidade,
    os.status,
    COUNT(os.id) AS quantidade_os
FROM unidade u
LEFT JOIN ordem_de_servico os
    ON os.unidade_id = u.id
WHERE u.id = @unidade_id
GROUP BY
    u.id,
    u.nome,
    os.status
ORDER BY
    os.status;


-- ============================================================
-- C02
-- Faturamento recebido no mês corrente, por unidade,
-- do maior para o menor.
-- ============================================================

SELECT
    u.id AS unidade_id,
    u.nome AS unidade,
    COALESCE(SUM(p.valor), 0) AS faturamento_recebido
FROM unidade u
LEFT JOIN ordem_de_servico os
    ON os.unidade_id = u.id
LEFT JOIN pagamento p
    ON p.os_id = os.id
    AND YEAR(p.data_e_hora) = YEAR(CURDATE())
    AND MONTH(p.data_e_hora) = MONTH(CURDATE())
GROUP BY
    u.id,
    u.nome
ORDER BY
    faturamento_recebido DESC;


-- ============================================================
-- C03
-- Ticket médio das OS entregues por unidade.
-- ============================================================

SELECT
    u.id AS unidade_id,
    u.nome AS unidade,
    COUNT(os.id) AS quantidade_os_entregues,
    ROUND(AVG(COALESCE(os.preco_total_os, 0)), 2) AS ticket_medio
FROM unidade u
LEFT JOIN ordem_de_servico os
    ON os.unidade_id = u.id
    AND os.status = 'entregue'
GROUP BY
    u.id,
    u.nome
ORDER BY
    ticket_medio DESC;


-- ============================================================
-- C04
-- Os 5 serviços mais vendidos no período,
-- com quantidade e receita gerada.
--
-- Aqui o período utilizado é o mês corrente.
-- ============================================================

SELECT
    s.id AS servico_id,
    s.nome AS servico,
    SUM(COALESCE(i.quantidade_servico, 0)) AS quantidade_vendida,
    SUM(COALESCE(i.preco_total_servico, 0)) AS receita_gerada
FROM item_os i
INNER JOIN servico s
    ON s.id = i.servico_id
INNER JOIN ordem_de_servico os
    ON os.id = i.os_id
WHERE
    i.servico_id IS NOT NULL
    AND YEAR(os.data_e_hora) = YEAR(CURDATE())
    AND MONTH(os.data_e_hora) = MONTH(CURDATE())
GROUP BY
    s.id,
    s.nome
ORDER BY
    quantidade_vendida DESC
LIMIT 5;


-- ============================================================
-- C05
-- Peças que estão abaixo do estoque mínimo,
-- mostrando quanto falta para repor.
--
-- Considera o estoque_atual da movimentação mais recente.
-- ============================================================

SELECT
    p.id AS peca_id,
    p.nome AS peca,
    p.estoque_minimo,
    COALESCE(m.estoque_atual, 0) AS estoque_atual,
    GREATEST(
        p.estoque_minimo - COALESCE(m.estoque_atual, 0),
        0
    ) AS quantidade_para_repor
FROM peca p
LEFT JOIN movimentacao m
    ON m.id = (
        SELECT m2.id
        FROM movimentacao m2
        WHERE m2.peca_id = p.id
        ORDER BY m2.quando DESC, m2.id DESC
        LIMIT 1
    )
WHERE
    COALESCE(m.estoque_atual, 0) < p.estoque_minimo
ORDER BY
    quantidade_para_repor DESC;


-- ============================================================
-- C06
-- OS abertas há mais de 7 dias que ainda não foram finalizadas,
-- mostrando quantos dias estão abertas.
--
-- "Não finalizadas" = diferente de finalizada e entregue.
-- ============================================================

SELECT
    os.id,
    os.numero,
    u.nome AS unidade,
    os.status,
    os.data_e_hora,
    DATEDIFF(
        CURDATE(),
        DATE(os.data_e_hora)
    ) AS dias_de_casa
FROM ordem_de_servico os
INNER JOIN unidade u
    ON u.id = os.unidade_id
WHERE
    os.data_e_hora < DATE_SUB(NOW(), INTERVAL 7 DAY)
    AND os.status NOT IN ('finalizada', 'entregue')
ORDER BY
    dias_de_casa DESC;


-- ============================================================
-- C07
-- Clientes que nunca abriram nenhuma OS.
-- ============================================================

SELECT
    c.id AS cliente_id,
    c.nome,
    c.documento,
    c.email
FROM cliente c
WHERE NOT EXISTS (
    SELECT 1
    FROM veiculo v
    INNER JOIN ordem_de_servico os
        ON os.veiculo_id = v.id
    WHERE v.cliente_id = c.id
)
ORDER BY
    c.nome;


-- ============================================================
-- C08
-- Clientes cadastrados sem nenhum telefone.
-- ============================================================

SELECT
    c.id AS cliente_id,
    c.nome,
    c.documento,
    c.email
FROM cliente c
LEFT JOIN telefone t
    ON t.cliente_id = c.id
WHERE
    t.id IS NULL
ORDER BY
    c.nome;


-- ============================================================
-- C09
-- Total de cada OS:
-- soma dos serviços,
-- soma das peças,
-- desconto
-- e valor final.
-- ============================================================

SELECT
    os.id AS os_id,
    os.numero,

    COALESCE(
        SUM(i.preco_total_servico),
        0
    ) AS total_servicos,

    COALESCE(
        SUM(i.preco_total_peca),
        0
    ) AS total_pecas,

    COALESCE(
        os.desconto_gerente,
        0
    ) AS desconto,

    (
        COALESCE(SUM(i.preco_total_servico), 0)
        +
        COALESCE(SUM(i.preco_total_peca), 0)
        -
        COALESCE(os.desconto_gerente, 0)
    ) AS valor_final

FROM ordem_de_servico os
LEFT JOIN item_os i
    ON i.os_id = os.id

GROUP BY
    os.id,
    os.numero,
    os.desconto_gerente

ORDER BY
    os.id;


-- ============================================================
-- C10
-- Mecânicos que finalizaram 5 ou mais OS no mês,
-- ordenados por quantidade.
-- ============================================================

SELECT
    c.id AS mecanico_id,
    c.nome AS mecanico,
    COUNT(os.id) AS quantidade_os_finalizadas
FROM colaborador c
INNER JOIN ordem_de_servico os
    ON os.mecanico_id = c.id
WHERE
    c.perfil = 'mecanico'
    AND os.status = 'finalizada'
    AND YEAR(os.data_e_hora) = YEAR(CURDATE())
    AND MONTH(os.data_e_hora) = MONTH(CURDATE())
GROUP BY
    c.id,
    c.nome
HAVING
    COUNT(os.id) >= 5
ORDER BY
    quantidade_os_finalizadas DESC;


-- ============================================================
-- C11
-- Cada colaborador com o nome do supervisor direto ao lado.
-- Quem não tem supervisor aparece mesmo assim.
-- ============================================================

SELECT
    c.id AS colaborador_id,
    c.nome AS colaborador,
    c.perfil,
    s.id AS supervisor_id,
    s.nome AS supervisor
FROM colaborador c
LEFT JOIN colaborador s
    ON s.id = c.colaborador_id
ORDER BY
    c.nome;


-- ============================================================
-- C12
-- Cada subcategoria de serviço com o nome da categoria pai.
--
-- ATENÇÃO:
-- No seu modelo atual, categoria possui subcategoria_id.
-- Portanto estamos considerando:
--
-- subcategoria = pai
-- categoria = subcategoria de serviço
--
-- O serviço aponta para categoria.
-- ============================================================

SELECT
    sc.id AS subcategoria_id,
    sc.nome AS categoria_pai,
    c.id AS categoria_id,
    c.nome AS subcategoria
FROM subcategoria sc
INNER JOIN categoria c
    ON c.subcategoria_id = sc.id
INNER JOIN servico s
    ON s.categoria_id = c.id
GROUP BY
    sc.id,
    sc.nome,
    c.id,
    c.nome
ORDER BY
    sc.nome,
    c.nome;


-- ============================================================
-- C13
-- Serviços com preço acima da média do catálogo.
-- ============================================================

SELECT
    s.id,
    s.codigo,
    s.nome,
    s.preco_de_tabela,
    (
        SELECT AVG(s2.preco_de_tabela)
        FROM servico s2
        WHERE s2.status = 'ativo'
    ) AS media_catalogo
FROM servico s
WHERE
    s.status = 'ativo'
    AND s.preco_de_tabela > (
        SELECT AVG(s2.preco_de_tabela)
        FROM servico s2
        WHERE s2.status = 'ativo'
    )
ORDER BY
    s.preco_de_tabela DESC;


-- ============================================================
-- C14
-- Movimentações de estoque agrupadas por dia,
-- com total de entradas e saídas.
--
-- ASSUMIMOS:
-- quantidade > 0 = entrada
-- quantidade < 0 = saída
-- ============================================================

SELECT
    DATE(m.quando) AS dia,

    SUM(
        CASE
            WHEN m.quantidade > 0
            THEN m.quantidade
            ELSE 0
        END
    ) AS total_entradas,

    SUM(
        CASE
            WHEN m.quantidade < 0
            THEN ABS(m.quantidade)
            ELSE 0
        END
    ) AS total_saidas

FROM movimentacao m
GROUP BY
    DATE(m.quando)
ORDER BY
    dia;


-- ============================================================
-- C15
-- Etiqueta do pátio:
-- placa, modelo, nome do cliente e status da OS
-- escrito por extenso, em uma coluna só.
-- ============================================================

SELECT
    CONCAT(
        'Placa: ', v.placa,
        ' | Modelo: ', v.modelo,
        ' | Cliente: ', c.nome,
        ' | Status: ',
        CASE os.status
            WHEN 'aberta'
                THEN 'Aberta'
            WHEN 'orçamento'
                THEN 'Orçamento'
            WHEN 'aprovada'
                THEN 'Aprovada'
            WHEN 'em_execução'
                THEN 'Em execução'
            WHEN 'aguardando_peca'
                THEN 'Aguardando peça'
            WHEN 'finalizada'
                THEN 'Finalizada'
            WHEN 'entregue'
                THEN 'Entregue'
            WHEN 'cancelado'
                THEN 'Cancelada'
            ELSE os.status
        END
    ) AS etiqueta_patio
FROM ordem_de_servico os
INNER JOIN veiculo v
    ON v.id = os.veiculo_id
INNER JOIN cliente c
    ON c.id = v.cliente_id
ORDER BY
    v.placa;


-- ============================================================
-- C16
-- Para cada OS não entregue:
-- quantos dias faltam para a previsão de entrega,
-- marcando "atrasada" quando o prazo já passou.
-- ============================================================

SELECT
    os.id AS os_id,
    os.numero,
    u.nome AS unidade,
    os.status,
    os.previsao_de_entrega,

    CASE
        WHEN os.previsao_de_entrega IS NULL
            THEN NULL

        WHEN os.previsao_de_entrega < CURDATE()
            THEN 'atrasada'

        ELSE CAST(
            DATEDIFF(
                os.previsao_de_entrega,
                CURDATE()
            ) AS CHAR
        )
    END AS dias_para_entrega

FROM ordem_de_servico os
INNER JOIN unidade u
    ON u.id = os.unidade_id
WHERE
    os.status <> 'entregue'
ORDER BY
    CASE
        WHEN os.previsao_de_entrega < CURDATE()
            THEN 0
        ELSE 1
    END,
    os.previsao_de_entrega;
