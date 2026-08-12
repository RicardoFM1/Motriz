# Dicionário de Dados — Motriz

## 1. Informações gerais

| Propriedade | Valor |
|---|---|
| Banco de dados | `Motriz` |
| SGBD | MySQL |
| Engine | InnoDB |
| Charset | `utf8mb4` |
| Quantidade de tabelas | 15 |

O banco de dados **Motriz** foi desenvolvido para gerenciamento de uma oficina mecânica, contemplando unidades, colaboradores, clientes, veículos, serviços, peças, fornecedores, movimentações de estoque, ordens de serviço e pagamentos.

---

# 2. Tabelas

## 2.1 `endereco`

Armazena os dados de endereço utilizados por clientes e unidades.

| Campo | Tipo | Nulo | Chave | Padrão | Descrição |
|---|---|---|---|---|---|
| `id` | `INT` | Não | PK | Auto Incremento | Identificador único do endereço. |
| `logradouro` | `VARCHAR(150)` | Não | — | — | Nome da rua, avenida ou logradouro. |
| `numero` | `INT` | Não | — | — | Número do endereço. |
| `complemento` | `VARCHAR(150)` | Não | — | — | Complemento do endereço. |
| `bairro` | `VARCHAR(150)` | Não | — | — | Bairro do endereço. |
| `cidade` | `VARCHAR(150)` | Não | — | — | Cidade do endereço. |
| `UF` | `VARCHAR(45)` | Não | — | — | Unidade federativa/estado. |
| `CEP` | `VARCHAR(8)` | Não | — | — | Código de Endereçamento Postal. |

**Relacionamentos:**

- `unidade.endereco_id` → `endereco.id`
- `cliente.endereco_id` → `endereco.id`

---

## 2.2 `unidade`

Representa as unidades ou filiais da oficina.

| Campo | Tipo | Nulo | Chave | Padrão | Descrição |
|---|---|---|---|---|---|
| `id` | `INT` | Não | PK | Auto Incremento | Identificador único da unidade. |
| `nome` | `VARCHAR(150)` | Não | — | — | Nome da unidade. |
| `telefone` | `VARCHAR(17)` | Não | — | — | Telefone de contato da unidade. |
| `status` | `ENUM('ativo','inativo')` | Não | — | — | Situação cadastral da unidade. |
| `endereco_id` | `INT` | Não | FK | — | Referência ao endereço da unidade. |

**Chave estrangeira:**

- `endereco_id` → `endereco.id`

**Regras:**

- `ON DELETE NO ACTION`
- `ON UPDATE NO ACTION`

---

## 2.3 `colaborador`

Armazena os funcionários e usuários do sistema.

| Campo | Tipo | Nulo | Chave | Padrão | Descrição |
|---|---|---|---|---|---|
| `id` | `INT` | Não | PK | Auto Incremento | Identificador único do colaborador. |
| `nome` | `VARCHAR(150)` | Não | — | — | Nome completo do colaborador. |
| `email` | `VARCHAR(150)` | Não | UK | — | E-mail utilizado pelo colaborador. |
| `cpf` | `VARCHAR(11)` | Não | UK | — | CPF do colaborador. |
| `senha` | `VARCHAR(255)` | Não | — | — | Senha armazenada para autenticação. |
| `perfil` | `ENUM('admin','gerente','atendente','mecanico','supervisor')` | Não | — | — | Perfil/permissão do colaborador. |
| `data_de_admissao` | `TIMESTAMP` | Não | — | `CURRENT_TIMESTAMP` | Data e hora de admissão. |
| `status` | `ENUM('ativo','inativo')` | Não | — | `ativo` | Situação do colaborador. |
| `colaborador_id` | `INT` | Não | FK | — | Referência a outro colaborador. |
| `unidade_id` | `INT` | Não | FK | — | Unidade à qual o colaborador pertence. |

**Chaves estrangeiras:**

- `unidade_id` → `unidade.id`
- `colaborador_id` → `colaborador.id`

**Restrições:**

- `email` é único.
- `cpf` é único.
- `unidade_id`: `ON DELETE RESTRICT`, `ON UPDATE RESTRICT`.
- `colaborador_id`: `ON DELETE NO ACTION`, `ON UPDATE NO ACTION`.

---

## 2.4 `cliente`

Armazena os dados cadastrais dos clientes.

| Campo | Tipo | Nulo | Chave | Padrão | Descrição |
|---|---|---|---|---|---|
| `id` | `INT` | Não | PK | Auto Incremento | Identificador único do cliente. |
| `nome` | `VARCHAR(150)` | Não | — | — | Nome completo do cliente. |
| `documento` | `VARCHAR(20)` | Não | — | — | Documento de identificação do cliente. |
| `email` | `VARCHAR(150)` | Não | — | — | E-mail do cliente. |
| `data_de_nascimento` | `DATETIME` | Sim | — | `NULL` | Data de nascimento. |
| `endereco_id` | `INT` | Não | FK | — | Endereço do cliente. |
| `observacoes` | `VARCHAR(255)` | Não | — | — | Observações relacionadas ao cliente. |

**Chave estrangeira:**

- `endereco_id` → `endereco.id`

**Regras:**

- `ON DELETE NO ACTION`
- `ON UPDATE NO ACTION`

---

## 2.5 `telefone`

Armazena os números de telefone associados a um cliente.

| Campo | Tipo | Nulo | Chave | Padrão | Descrição |
|---|---|---|---|---|---|
| `id` | `INT` | Não | PK | Auto Incremento | Identificador do registro de telefone. |
| `numero_fixo` | `VARCHAR(45)` | Sim | — | `NULL` | Número de telefone fixo. |
| `numero_celular` | `VARCHAR(45)` | Sim | UK | `NULL` | Número de telefone celular. |
| `numero_externo` | `VARCHAR(45)` | Sim | — | `NULL` | Número externo ou telefone adicional. |
| `cliente_id` | `INT` | Não | FK, UK | — | Cliente associado ao telefone. |

**Chave estrangeira:**

- `cliente_id` → `cliente.id`

**Regras:**

- `ON DELETE CASCADE`
- `ON UPDATE CASCADE`
- `cliente_id` é único.
- `numero_celular` é único.

---

## 2.6 `veiculo`

Armazena os veículos cadastrados pelos clientes.

| Campo | Tipo | Nulo | Chave | Padrão | Descrição |
|---|---|---|---|---|---|
| `id` | `INT` | Não | PK | Auto Incremento | Identificador único do veículo. |
| `placa` | `VARCHAR(45)` | Não | UK | — | Placa do veículo. |
| `marca` | `VARCHAR(45)` | Não | — | — | Marca do veículo. |
| `modelo` | `VARCHAR(45)` | Não | — | — | Modelo do veículo. |
| `ano_fabricacao` | `YEAR` | Não | — | — | Ano de fabricação. |
| `cor` | `VARCHAR(45)` | Não | — | — | Cor do veículo. |
| `tipo_de_combustivel` | `VARCHAR(45)` | Não | — | — | Tipo de combustível utilizado. |
| `quilometragem` | `INT` | Não | — | — | Quilometragem atual do veículo. |
| `cliente_id` | `INT` | Não | FK | — | Cliente proprietário/responsável pelo veículo. |

**Chave estrangeira:**

- `cliente_id` → `cliente.id`

**Restrições:**

- `placa` é única.
- `ON DELETE NO ACTION`
- `ON UPDATE NO ACTION`

---

## 2.7 `subcategoria`

Armazena subcategorias utilizadas para classificação de serviços.

| Campo | Tipo | Nulo | Chave | Padrão | Descrição |
|---|---|---|---|---|---|
| `id` | `INT` | Não | PK | — | Identificador da subcategoria. |
| `nome` | `VARCHAR(45)` | Não | — | — | Nome da subcategoria. |

---

## 2.8 `categoria`

Armazena as categorias dos serviços.

| Campo | Tipo | Nulo | Chave | Padrão | Descrição |
|---|---|---|---|---|---|
| `id` | `INT` | Não | PK | — | Identificador da categoria. |
| `nome` | `VARCHAR(45)` | Não | UK | — | Nome da categoria. |
| `subcategoria_id` | `INT` | Sim | FK | `NULL` | Subcategoria relacionada à categoria. |

**Chave estrangeira:**

- `subcategoria_id` → `subcategoria.id`

**Restrições:**

- `nome` é único.
- `ON DELETE NO ACTION`
- `ON UPDATE NO ACTION`

---

## 2.9 `servico`

Armazena os serviços oferecidos pela oficina.

| Campo | Tipo | Nulo | Chave | Padrão | Descrição |
|---|---|---|---|---|---|
| `id` | `INT` | Não | PK | Auto Incremento | Identificador único do serviço. |
| `nome` | `VARCHAR(45)` | Não | — | — | Nome do serviço. |
| `descricao` | `VARCHAR(255)` | Não | — | — | Descrição detalhada do serviço. |
| `preco_de_tabela` | `INT` | Não | — | — | Preço padrão/tabela do serviço. |
| `tempo_estimado` | `TIME` | Não | — | — | Tempo estimado para execução. |
| `status` | `ENUM('ativo','inativo')` | Não | — | `ativo` | Situação do serviço. |
| `categoria_id` | `INT` | Não | FK | — | Categoria à qual o serviço pertence. |
| `codigo` | `VARCHAR(45)` | Não | UK | — | Código único do serviço. |
| `colaborador_id` | `INT` | Não | FK | — | Colaborador relacionado ao cadastro/serviço. |
| `quantidade` | `INT` | Não | — | — | Quantidade associada ao serviço. |

**Chaves estrangeiras:**

- `categoria_id` → `categoria.id`
- `colaborador_id` → `colaborador.id`

**Restrições:**

- `codigo` é único.
- `ON DELETE NO ACTION`
- `ON UPDATE NO ACTION`

---

## 2.10 `fornecedor`

Armazena os fornecedores de peças.

| Campo | Tipo | Nulo | Chave | Padrão | Descrição |
|---|---|---|---|---|---|
| `id` | `INT` | Não | PK | Auto Incremento | Identificador único do fornecedor. |
| `razao_social` | `VARCHAR(45)` | Não | — | — | Razão social do fornecedor. |
| `CNPJ` | `VARCHAR(14)` | Não | — | — | CNPJ do fornecedor. |
| `email` | `VARCHAR(150)` | Não | — | — | E-mail do fornecedor. |
| `telefone` | `VARCHAR(17)` | Não | — | — | Telefone do fornecedor. |

---

## 2.11 `peca`

Armazena as peças utilizadas pela oficina e seus dados de estoque/comercialização.

| Campo | Tipo | Nulo | Chave | Padrão | Descrição |
|---|---|---|---|---|---|
| `id` | `INT` | Não | PK | Auto Incremento | Identificador único da peça. |
| `nome` | `VARCHAR(45)` | Não | — | — | Nome da peça. |
| `codigo` | `VARCHAR(45)` | Não | UK | — | Código único da peça. |
| `preco_de_custo` | `INT` | Não | — | — | Preço de aquisição da peça. |
| `preco_de_venda` | `INT` | Não | — | — | Preço de venda da peça. |
| `estoque_minimo` | `INT` | Não | — | — | Quantidade mínima desejada em estoque. |
| `fornecedor_id` | `INT` | Sim | FK | `NULL` | Fornecedor da peça. |

**Chave estrangeira:**

- `fornecedor_id` → `fornecedor.id`

**Restrições:**

- `codigo` é único.
- `ON DELETE NO ACTION`
- `ON UPDATE NO ACTION`

---

## 2.12 `movimentacao`

Registra movimentações de estoque de peças.

| Campo | Tipo | Nulo | Chave | Padrão | Descrição |
|---|---|---|---|---|---|
| `id` | `INT` | Não | PK | Auto Incremento | Identificador da movimentação. |
| `estoque_atual` | `INT` | Não | — | — | Estoque registrado após a movimentação. |
| `peca_id` | `INT` | Não | FK | — | Peça movimentada. |
| `fornecedor_id` | `INT` | Não | FK | — | Fornecedor relacionado à movimentação. |
| `quantidade` | `INT` | Não | — | — | Quantidade movimentada. |
| `quando` | `DATETIME` | Não | — | — | Data e hora da movimentação. |
| `motivo` | `VARCHAR(255)` | Não | — | — | Motivo da movimentação. |
| `colaborador_id` | `INT` | Não | FK | — | Colaborador responsável pela movimentação. |
| `os_id` | `INT` | Sim | — | `NULL` | Identificador da ordem de serviço relacionada. |

**Chaves estrangeiras:**

- `peca_id` → `peca.id`
- `fornecedor_id` → `fornecedor.id`
- `colaborador_id` → `colaborador.id`

**Observação:** o campo `os_id` existe na tabela, porém não possui uma `FOREIGN KEY` definida no SQL fornecido.

Todas as chaves estrangeiras possuem:

- `ON DELETE NO ACTION`
- `ON UPDATE NO ACTION`

---

## 2.13 `ordem_de_servico`

Representa as ordens de serviço abertas para atendimento dos veículos.

| Campo | Tipo | Nulo | Chave | Padrão | Descrição |
|---|---|---|---|---|---|
| `id` | `INT` | Não | PK | Auto Incremento | Identificador único da ordem de serviço. |
| `numero` | `INT` | Não | — | — | Número da ordem de serviço. |
| `unidade_id` | `INT` | Não | FK, UK | — | Unidade responsável pela OS. |
| `veiculo_id` | `INT` | Não | FK | — | Veículo atendido. |
| `mecanico_id` | `INT` | Sim | FK | `NULL` | Mecânico responsável pela execução. |
| `atendente_id` | `INT` | Não | FK | — | Atendente responsável pelo atendimento. |
| `quilometragem` | `INT` | Não | — | — | Quilometragem registrada na abertura da OS. |
| `data_e_hora` | `TIMESTAMP` | Sim | — | `CURRENT_TIMESTAMP` | Data e hora de abertura/registro da OS. |
| `previsao_de_entrega` | `DATE` | Sim | — | `NULL` | Previsão de entrega do veículo. |
| `status` | `ENUM(...)` | Não | — | `aberta` | Situação atual da ordem de serviço. |
| `observações` | `VARCHAR(255)` | Sim | — | `NULL` | Observações da OS. |
| `desconto_gerente` | `INT` | Não | — | — | Desconto aplicado/autorizado pelo gerente. |
| `preco_total_os` | `INT` | Sim | — | `NULL` | Valor total da ordem de serviço. |

### Valores de `status`

| Valor | Significado |
|---|---|
| `aberta` | Ordem de serviço aberta. |
| `orçamento` | OS em fase de orçamento. |
| `aprovada` | Orçamento aprovado pelo cliente. |
| `em_execução` | Serviço em execução. |
| `aguardando_peca` | Execução aguardando peça. |
| `finalizada` | Serviço finalizado. |
| `entregue` | Veículo entregue ao cliente. |
| `cancelado` | Ordem de serviço cancelada. |

**Chaves estrangeiras:**

- `unidade_id` → `unidade.id`
- `veiculo_id` → `veiculo.id`
- `mecanico_id` → `colaborador.id`
- `atendente_id` → `colaborador.id`

**Restrições:**

- `unidade_id` possui índice `UNIQUE`.
- `mecanico_id` pode ser nulo.
- Todas as FKs possuem `ON DELETE NO ACTION` e `ON UPDATE NO ACTION`.

---

## 2.14 `item_os`

Relaciona peças e serviços utilizados em uma ordem de serviço.

| Campo | Tipo | Nulo | Chave | Padrão | Descrição |
|---|---|---|---|---|---|
| `id` | `INT` | Não | PK | Auto Incremento | Identificador do item da OS. |
| `peca_id` | `INT` | Não | FK, UK | — | Peça utilizada na OS. |
| `servico_id` | `INT` | Não | FK, UK | — | Serviço realizado na OS. |
| `os_id` | `INT` | Não | FK | — | Ordem de serviço relacionada. |
| `quantidade_peca` | `INT` | Sim | — | `NULL` | Quantidade de peças utilizadas. |
| `quantidade_servico` | `INT` | Sim | — | `NULL` | Quantidade de serviços. |
| `preco_total_peca` | `INT` | Sim | — | `NULL` | Valor total das peças. |
| `preco_total_servico` | `INT` | Sim | — | `NULL` | Valor total dos serviços. |

**Chaves estrangeiras:**

- `peca_id` → `peca.id`
- `servico_id` → `servico.id`
- `os_id` → `ordem_de_servico.id`

**Restrições:**

- `peca_id` é `UNIQUE`.
- `servico_id` é `UNIQUE`.
- `os_id` utiliza `ON DELETE CASCADE` e `ON UPDATE CASCADE`.
- As FKs de `peca_id` e `servico_id` utilizam `ON DELETE NO ACTION` e `ON UPDATE NO ACTION`.

---

## 2.15 `pagamento`

Armazena os pagamentos realizados referentes às ordens de serviço.

| Campo | Tipo | Nulo | Chave | Padrão | Descrição |
|---|---|---|---|---|---|
| `id` | `INT` | Não | PK | Auto Incremento | Identificador do pagamento. |
| `valor` | `INT` | Não | — | — | Valor do pagamento. |
| `forma` | `VARCHAR(45)` | Não | — | — | Forma de pagamento utilizada. |
| `numero_parcela` | `INT` | Sim | — | `NULL` | Número da parcela do pagamento. |
| `data_e_hora` | `TIMESTAMP` | Sim | — | `CURRENT_TIMESTAMP` | Data e hora do pagamento. |
| `colaborador_id` | `INT` | Não | FK | — | Colaborador responsável pelo registro. |
| `os_id` | `INT` | Não | FK | — | Ordem de serviço relacionada ao pagamento. |

**Chaves estrangeiras:**

- `colaborador_id` → `colaborador.id`
- `os_id` → `ordem_de_servico.id`

Todas as chaves estrangeiras utilizam:

- `ON DELETE NO ACTION`
- `ON UPDATE NO ACTION`

---

# 3. Relacionamentos

| Tabela origem | Campo | Tabela destino | Campo destino | Relação |
|---|---|---|---|---|
| `unidade` | `endereco_id` | `endereco` | `id` | Unidade → Endereço |
| `colaborador` | `unidade_id` | `unidade` | `id` | Colaborador → Unidade |
| `colaborador` | `colaborador_id` | `colaborador` | `id` | Colaborador → Colaborador |
| `cliente` | `endereco_id` | `endereco` | `id` | Cliente → Endereço |
| `telefone` | `cliente_id` | `cliente` | `id` | Telefone → Cliente |
| `veiculo` | `cliente_id` | `cliente` | `id` | Veículo → Cliente |
| `categoria` | `subcategoria_id` | `subcategoria` | `id` | Categoria → Subcategoria |
| `servico` | `categoria_id` | `categoria` | `id` | Serviço → Categoria |
| `servico` | `colaborador_id` | `colaborador` | `id` | Serviço → Colaborador |
| `peca` | `fornecedor_id` | `fornecedor` | `id` | Peça → Fornecedor |
| `movimentacao` | `peca_id` | `peca` | `id` | Movimentação → Peça |
| `movimentacao` | `fornecedor_id` | `fornecedor` | `id` | Movimentação → Fornecedor |
| `movimentacao` | `colaborador_id` | `colaborador` | `id` | Movimentação → Colaborador |
| `ordem_de_servico` | `unidade_id` | `unidade` | `id` | OS → Unidade |
| `ordem_de_servico` | `veiculo_id` | `veiculo` | `id` | OS → Veículo |
| `ordem_de_servico` | `mecanico_id` | `colaborador` | `id` | OS → Mecânico |
| `ordem_de_servico` | `atendente_id` | `colaborador` | `id` | OS → Atendente |
| `item_os` | `peca_id` | `peca` | `id` | Item OS → Peça |
| `item_os` | `servico_id` | `servico` | `id` | Item OS → Serviço |
| `item_os` | `os_id` | `ordem_de_servico` | `id` | Item OS → OS |
| `pagamento` | `colaborador_id` | `colaborador` | `id` | Pagamento → Colaborador |
| `pagamento` | `os_id` | `ordem_de_servico` | `id` | Pagamento → OS |

---

# 4. Chaves primárias

| Tabela | Chave primária | Auto Incremento |
|---|---|---|
| `endereco` | `id` | Sim |
| `unidade` | `id` | Sim |
| `colaborador` | `id` | Sim |
| `cliente` | `id` | Sim |
| `telefone` | `id` | Sim |
| `veiculo` | `id` | Sim |
| `subcategoria` | `id` | Não |
| `categoria` | `id` | Não |
| `servico` | `id` | Sim |
| `fornecedor` | `id` | Sim |
| `peca` | `id` | Sim |
| `movimentacao` | `id` | Sim |
| `ordem_de_servico` | `id` | Sim |
| `item_os` | `id` | Sim |
| `pagamento` | `id` | Sim |

---

# 5. Campos com valores enumerados

## `unidade.status`

| Valor |
|---|
| `ativo` |
| `inativo` |

## `colaborador.perfil`

| Valor |
|---|
| `admin` |
| `gerente` |
| `atendente` |
| `mecanico` |
| `supervisor` |

## `colaborador.status`

| Valor |
|---|
| `ativo` |
| `inativo` |

## `servico.status`

| Valor |
|---|
| `ativo` |
| `inativo` |

## `ordem_de_servico.status`

| Valor |
|---|
| `aberta` |
| `orçamento` |
| `aprovada` |
| `em_execução` |
| `aguardando_peca` |
| `finalizada` |
| `entregue` |
| `cancelado` |

---

# 6. Índices e restrições UNIQUE

| Tabela | Campo | Restrição |
|---|---|---|
| `colaborador` | `email` | UNIQUE |
| `colaborador` | `cpf` | UNIQUE |
| `telefone` | `cliente_id` | UNIQUE |
| `telefone` | `numero_celular` | UNIQUE |
| `veiculo` | `placa` | UNIQUE |
| `categoria` | `nome` | UNIQUE |
| `servico` | `codigo` | UNIQUE |
| `peca` | `codigo` | UNIQUE |
| `ordem_de_servico` | `unidade_id` | UNIQUE |
| `item_os` | `peca_id` | UNIQUE |
| `item_os` | `servico_id` | UNIQUE |

---

# 7. Observações técnicas

## 7.1 Valores monetários

Os campos abaixo estão definidos como `INT`:

- `servico.preco_de_tabela`
- `peca.preco_de_custo`
- `peca.preco_de_venda`
- `ordem_de_servico.desconto_gerente`
- `ordem_de_servico.preco_total_os`
- `item_os.preco_total_peca`
- `item_os.preco_total_servico`
- `pagamento.valor`

Caso esses campos representem valores monetários em reais, recomenda-se avaliar o uso de `DECIMAL(10,2)` ou, alternativamente, armazenar valores em centavos utilizando `INT`.

---

## 7.2 Campo `ordem_de_servico.unidade_id`

O campo `unidade_id` possui uma restrição `UNIQUE`.

Isso significa que uma unidade só poderá aparecer uma vez na tabela `ordem_de_servico`. Na prática, isso impede que uma mesma unidade possua várias ordens de serviço.

Caso a intenção seja permitir várias OS por unidade, essa restrição `UNIQUE` provavelmente deverá ser removida.

---

## 7.3 Campo `item_os.peca_id`

O campo `peca_id` possui `UNIQUE`.

Isso impede que a mesma peça seja utilizada em mais de um registro de `item_os`.

Caso uma peça possa aparecer em várias ordens de serviço, essa restrição provavelmente deverá ser removida.

---

## 7.4 Campo `item_os.servico_id`

O campo `servico_id` também possui `UNIQUE`.

Isso impede que o mesmo serviço apareça em mais de um registro de `item_os`.

Caso um serviço possa ser utilizado em várias ordens de serviço, essa restrição provavelmente deverá ser removida.

---

## 7.5 Campo `movimentacao.os_id`

O campo `os_id` está presente em `movimentacao`, porém não existe uma chave estrangeira para `ordem_de_servico`.

Caso a movimentação de estoque possa estar vinculada a uma OS, pode ser interessante criar:

```text
movimentacao.os_id → ordem_de_servico.id
colaborador.colaborador_id → colaborador.id
```

--- 

7.7 telefone e relacionamento com cliente
telefone.cliente_id é UNIQUE, portanto cada cliente pode possuir no máximo um registro na tabela telefone.

Como esse registro possui numero_fixo, numero_celular e numero_externo, a modelagem aparentemente permite armazenar até três números para cada cliente.

7.8 subcategoria.id e categoria.id
Os IDs de subcategoria e categoria não possuem AUTO_INCREMENT, diferentemente da maioria das outras tabelas.

Assim, os valores desses IDs deverão ser fornecidos explicitamente durante os INSERTs.

---

|Entidade|	Finalidade|
|---|---|
|endereco |	Cadastro de endereços. |
|unidade |	Cadastro das unidades da oficina. |
|colaborador |	Funcionários e usuários do sistema. |
|cliente |	Cadastro de clientes. |
|telefone |	Telefones dos clientes. |
|veiculo |	Veículos vinculados aos clientes. |
|subcategoria |	Subcategorias de classificação. |
|categoria |	Categorias de serviços. |
|servico |	 Serviços oferecidos pela oficina. |
|fornecedor |	Fornecedores de peças. |
|peca |	Peças e informações comerciais/estoque. |
|movimentacao |	Movimentações de estoque. |
|ordem_de_servico |	Ordens de serviço da oficina. |
|item_os |	Peças e serviços associados às OS. |
|pagamento |	Pagamentos das ordens de serviço. |

