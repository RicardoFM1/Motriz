Tabelas:

-----

Unidade (PAI de colaborador):
id
- Nome
- Endereço(tabela separada)
- Telefone
- Indicador de ativo ou não


Cada unidade tem um gerente associado, que é um dos colaboradores, ou seja, se o perfil do colaborador for gerente ele está associado a uma unidade, pois administra a unidade.

A unidade não precisa de um gerente para existir, então na tabela de unidade pode ter o id do gerente ou no gerente ter o id da unidade, mas sendo nullable.


-----
Endereço:

-logradouro
-número,
-complemento
-bairro
-cidade
-UF
-CEP


-----





-----

Colaborador (FILHO de colaborador):

id
- Nome
- Email
- Cpf
- Senha
- Perfil
- Data de admissão
- Ativo ou não ativo
colaborador_id (não pode ser o mesmo que o id) - Para supervisor - Verificar no banco com check
unidade_id (restrict)
os_id (nullable) (tirei por enquanto)


Todo colaborador está incluso em uma unidade.

Colaborador tem um supervisor direto, que é outro colaborador.

-----


Cliente (PAI do telefone) - CASCADE:

Pode ser físico ou jurídico

- nome (físico) ou razão social (jurídico)
- documento (CPF ou CNPJ)
- email
- data de nascimento (pessoa física)
- endereço (outra tabela)
- Observações

 
Mais de um telefone quase sempre, celular, fixo e whats da esposa
Numero de telefone único na tabela de telefones e também na referencia da tabela de
telefones.

A idade do cliente só é retornada para o frontend poder utilizar e não armazenada no banco
------

Telefone (FILHO de cliente) - CASCADE:

Numero fixo
Numero celular
Whats de outra pessoa
cliente_id


-----



Veículo:

Cada cliente tem um ou mais veículos

- Placa (Unique)
- Marca
- Modelo
- Ano de fabricação (fica entre 1900-2027) - Ver se consigo fazer isso no banco ou é melhor na API
- Cor
- Tipo de combustível
- Quilometragem da ultima passada na oficina
cliente_id

Identifica o veiculo na rede inteira, ou seja, não tem por unidade.


-----

Serviços (mão de obra da OS FILHO DE OS):

- nome
- descrição
- preco de tabela
- tempo estimado em minutos
- ativo ou não ativo
- categoria_id
- código (tipo MOT-014) (único)
- Mecanico responsável
Quantidade

Precisa verificar na API para apenas incluir colaboradores no serviço que são mecânicos.

Distribuído em categorias
Tabela nova para categorias que o serviço puxa de lá e pode ser criado uma nova quando quiser.
Nas categorias há níveis e dentro desses níveis tem outros níveis e a diretoria pode criar quantos níveis quiser.

Tabela de categorias (recebe camadas, que tem objetos já)


Depois chama a categoria no serviço

-----

Peças (uso interno, vendendo junto com o serviço FILHO DE OS):

- Nome
- Código (único)
- Preco de custo
- Preco de venda
- Estoque mínimo abaixo do qual precisa comprar
- fornecedor_id (nullable)


Pode não ter fornecedor


-----
Painel (para log):

estoque atual
peca_id
fornecedo_id
quanto
quando
porque
quem registrou
OS_id


Toda vez que um OS for criada vai ir para aqui também
Toda vez que uma peça for criada vai ir para aqui também
Toda vez que um fornecedor for criado vai ir para aqui também

Isso fazer na API.


-----

Fornecedor:

- Razao social
- CNPJ
- email
- Telefone


Quando o fornecedor sai do sistema, pode excluir e tirar da peças, mas precisa
guardar como um log


DELETAR O PAI -> DELETE O FILHO
DELETAR O FILHO -> NAO DELETA O PAI


-----

servicos_ordem_de_servico_pecas:

id
pecas_id (unique)
servicos_id (unique)
os_id (cascade)

Tentar lancar o mesmo serviço na OS não pode e isso é feito pela API.


Verificar na api para impedir de deletar servicos, pecas, clientes ou veiculos que já foram associados a uma OS.
-----

Ordem de serviço (PAI de PECAS E SERVICOS INTERMEDIARIA):

- Numero da OS (entregue para o cliente tipo: OS-2026-000417)
- Unidade
- Veiculo_id
mecanico_id (nullable enquanto tiver status = orcamento)
- atendente_id (tipo: atendente apenas) - NOT NULL
- Quilometragem de entrada (quando foi fazer a ordem)
- data e hora de abertura da OS
- Previsão de entrega
Status
- Observações
- Quantidade de peças utilizadas (verificar estoque e pegar de um select da tabela intermediaria servicos_ordem_de_servico_pecas)
Preço total das peças (para congelamento de preço)
Desconto do gerente (apenas o gerente pode descontar, não pode ser maior que a soma dos itens, calcular e verificar na API)
Preço total da OS (soma dos serviços + soma das peças - desconto do gerente)



Verificar na hora de lançar peça na OS se a quantidade tentada lançar é maior que o estoque disponível.


Buscar das outras tabelas com left join ou inner join a tabela intermediaria servicos_ordem_de_servico_pecas para consultar total de peças utilizadas e servicos e conseguir fazer a somatório.




Depois a OS ganha um mecânico responsável (colaborador)
aberta, orçamento, aprovada, em execução, aguardando peça, finalizada, entregue,
cancelada. Toda OS nasce em "aberta" <- DEFAULT.

-----



Pagamento:

valor
forma (dinheiro, pix, debito, credito, boleto)
numero de parcelas
data e hora
colaborador_id (precisa ser o atendente) ou pode ser qualquer um??
os_id (A soma dos pagamentos de uma OS não pode passar o total dela.)

Pode ter vários pagamentos nessa OS.


------


O que a diretoria ainda quer (extensões)

Só entra depois que o núcleo estiver de pé e rodando:

Agendamento: o cliente liga e marca dia e hora pra levar o carro numa
unidade. O agendamento tem status (agendado, confirmado, compareceu,
faltou, cancelado) e, quando o carro chega, vira uma OS.



Avaliação:

avaliacao_id 1
nota (0-10 apenas)
cliente_id 1
os_id (unique)


Avaliação do cliente: depois da entrega, o cliente responde uma nota de 0 a
10 e um comentário. Cada OS recebe no máximo uma avaliação