Por que a tabela de telefone existe em vez de três colunas no cliente?

- A tabela de telefone existe para evitar a violação da regra 1FN que diz que não pode repetir nomes de colunas e também para poder controlar melhor as regras de negócios.

2	Por que o preço fica repetido dentro do item da OS, se ele já está no catálogo. Isso não fere a normalização?

- O preço fica repetido como item da OS justamente para impedir que, caso a peça altere o valor, não altere junto no item da OS assim fazendo um congelamento do preço no exato momento que a OS foi aberta, feriria a normalização se o nome da coluna que tem na OS fosse o mesmo de peça por exemplo, mas como coloquei preco_total das peças não infere.


3	Como você resolveu o nó entre unidade e colaborador (RN31), e por que escolheu esse lado pra quebrar.

- Eu resolvi com meu modelo de banco de dados, onde colaborador depende de unidade mas unidade não depende de colaborador.


4	Por que cada regra de exclusão da seção 5.3 é a que você escolheu. Cite pelo menos um caso de cada: apagar em cascata, barrar a exclusão e anular a referência.

- RN16 - Cascade, escolhi essa pois excluindo uma OS (pai), os itens dela também são apagados (porém apenas os que estão incluidos na tabela intermediaria e não os itens mesmo).
- RN19 - Set NULL, fica nulo o fornecedor nas peças.
- RN20 - RESTRICT/NO ACTION, barra a exclusão de uma unidade se já tiver colaboradores incluídos nela.

5	Estoque atual: guardado ou calculado? Defenda a sua, sabendo que a outra também tem defesa.

- O estoque atual é guardado e calculado, é a mistura dos dois pois assim eu calculo e depois guardo para poder ser utilizado nos logs.

6	Quais regras da seção 5 o banco não consegue garantir sozinho, e por quê. Essa é a pergunta que separa quem entendeu constraint de quem decorou sintaxe.

- RN15 - Não se apaga cliente, veículo, serviço ou peça que já tenha aparecido
em alguma OS.
- RN23 - OS "entregue" ou "cancelada" não aceita item novo.
- RN25 - Não se lança peça na OS em quantidade maior que o estoque
disponível.
- RN26 - O desconto não pode ser maior que a soma dos itens da OS. API
- RN27 - A soma dos pagamentos de uma OS não pode passar o total dela. 
- RN34 - A OS pode existir sem mecânico responsável (enquanto está só em orçamento), mas nunca sem atendente.