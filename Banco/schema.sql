-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Motriz
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Motriz
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Motriz` DEFAULT CHARACTER SET utf8mb4 ;
USE `Motriz` ;

-- -----------------------------------------------------
-- Table `Motriz`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Motriz`.`endereco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(150) NOT NULL,
  `numero` INT NOT NULL,
  `complemento` VARCHAR(150) NOT NULL,
  `bairro` VARCHAR(150) NOT NULL,
  `cidade` VARCHAR(150) NOT NULL,
  `UF` VARCHAR(45) NOT NULL,
  `CEP` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Motriz`.`unidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Motriz`.`unidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `telefone` VARCHAR(17) NOT NULL,
  `status` ENUM('ativo', 'inativo') NOT NULL,
  `endereco_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_unidade_endereco_idx` (`endereco_id` ASC) ,
  CONSTRAINT `fk_unidade_endereco`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `Motriz`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Motriz`.`colaborador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Motriz`.`colaborador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `perfil` ENUM('admin', 'gerente', 'atendente', 'mecanico', 'supervisor') NOT NULL,
  `data_de_admissao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo',
  `colaborador_id` INT NULL,
  `unidade_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) ,
  INDEX `fk_colaborador_unidade_idx` (`unidade_id` ASC) ,
  INDEX `fk_colaborador_colaborador_idx` (`colaborador_id` ASC) ,
  CONSTRAINT `fk_colaborador_unidade`
    FOREIGN KEY (`unidade_id`)
    REFERENCES `Motriz`.`unidade` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_colaborador_colaborador`
    FOREIGN KEY (`colaborador_id`)
    REFERENCES `Motriz`.`colaborador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Motriz`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Motriz`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `documento` VARCHAR(20) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `data_de_nascimento` DATETIME NULL,
  `endereco_id` INT NOT NULL,
  `observacoes` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cliente_endereco_idx` (`endereco_id` ASC) ,
  CONSTRAINT `fk_cliente_endereco`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `Motriz`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Motriz`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Motriz`.`telefone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero_fixo` VARCHAR(45) NULL,
  `numero_celular` VARCHAR(45) NULL,
  `numero_externo` VARCHAR(45) NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_telefone_cliente_idx` (`cliente_id` ASC) ,
  UNIQUE INDEX `cliente_id_UNIQUE` (`cliente_id` ASC) ,
  UNIQUE INDEX `numero_celular_UNIQUE` (`numero_celular` ASC) ,
  CONSTRAINT `fk_telefone_cliente`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `Motriz`.`cliente` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Motriz`.`veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Motriz`.`veiculo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `placa` VARCHAR(45) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `ano_fabricacao` YEAR NOT NULL,
  `cor` VARCHAR(45) NOT NULL,
  `tipo_de_combustivel` VARCHAR(45) NOT NULL,
  `quilometragem` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `placa_UNIQUE` (`placa` ASC) ,
  INDEX `fk_veiculo_cliente_idx` (`cliente_id` ASC) ,
  CONSTRAINT `fk_veiculo_cliente`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `Motriz`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Motriz`.`subcategoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Motriz`.`subcategoria` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Motriz`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Motriz`.`categoria` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `subcategoria_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) ,
  INDEX `fk_categoria_subcategoria_idx` (`subcategoria_id` ASC) ,
  CONSTRAINT `fk_categoria_subcategoria`
    FOREIGN KEY (`subcategoria_id`)
    REFERENCES `Motriz`.`subcategoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Motriz`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Motriz`.`servico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(255) NOT NULL,
  `preco_de_tabela` INT NOT NULL,
  `tempo_estimado` TIME NOT NULL,
  `status` ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo',
  `categoria_id` INT NOT NULL,
  `codigo` VARCHAR(45) NOT NULL,
  `colaborador_id` INT NOT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) ,
  INDEX `fk_servicos_colaborador_idx` (`colaborador_id` ASC) ,
  INDEX `fk_servico_categoria_idx` (`categoria_id` ASC) ,
  CONSTRAINT `fk_servico_colaborador`
    FOREIGN KEY (`colaborador_id`)
    REFERENCES `Motriz`.`colaborador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_categoria`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `Motriz`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Motriz`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Motriz`.`fornecedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `razao_social` VARCHAR(45) NOT NULL,
  `CNPJ` VARCHAR(14) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `telefone` VARCHAR(17) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Motriz`.`peca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Motriz`.`peca` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `codigo` VARCHAR(45) NOT NULL,
  `preco_de_custo` INT NOT NULL,
  `preco_de_venda` INT NOT NULL,
  `estoque_minimo` INT NOT NULL,
  `fornecedor_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) ,
  INDEX `fk_pecas_fornecedor_idx` (`fornecedor_id` ASC) ,
  CONSTRAINT `fk_pecas_fornecedor`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `Motriz`.`fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;





-- -----------------------------------------------------
-- Table `Motriz`.`ordem_de_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Motriz`.`ordem_de_servico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero` INT NOT NULL,
  `unidade_id` INT NOT NULL,
  `veiculo_id` INT NOT NULL,
  `mecanico_id` INT NULL,
  `atendente_id` INT NOT NULL,
  `quilometragem` INT NOT NULL,
  `data_e_hora` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `previsao_de_entrega` DATE NULL,
  `status` ENUM('aberta', 'orçamento', 'aprovada', 'em_execução', 'aguardando_peca', 'finalizada', 'entregue', 'cancelado') NOT NULL DEFAULT 'aberta',
  `observações` VARCHAR(255) NULL,
  `desconto_gerente` INT NOT NULL,
  `preco_total_os` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_os_veiculo_idx` (`veiculo_id` ASC) ,
  INDEX `fk_os_mecanico_idx` (`mecanico_id` ASC) ,
  INDEX `fk_os_atendente_idx` (`atendente_id` ASC) ,
  INDEX `fk_os_unidade_idx` (`unidade_id` ASC),
  CONSTRAINT `fk_os_veiculo`
    FOREIGN KEY (`veiculo_id`)
    REFERENCES `Motriz`.`veiculo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_os_mecanico`
    FOREIGN KEY (`mecanico_id`)
    REFERENCES `Motriz`.`colaborador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_os_atendente`
    FOREIGN KEY (`atendente_id`)
    REFERENCES `Motriz`.`colaborador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_os_unidade`
    FOREIGN KEY (`unidade_id`)
    REFERENCES `Motriz`.`unidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Motriz`.`movimentacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Motriz`.`movimentacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `estoque_atual` INT NOT NULL,
  `peca_id` INT NOT NULL,
  `fornecedor_id` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `quando` DATETIME NOT NULL,
  `motivo` VARCHAR(255) NOT NULL,
  `colaborador_id` INT NOT NULL,
  `os_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_movimentacao_peca_idx` (`peca_id` ASC) ,
  INDEX `fk_movimentacao_fornecedor_idx` (`fornecedor_id` ASC) ,
  INDEX `fk_movimentacao_colaborador_idx` (`colaborador_id` ASC) ,
  INDEX `fk_movimentacao_os_idx` (`os_id` ASC),

  CONSTRAINT `fk_movimentacao_peca`
    FOREIGN KEY (`peca_id`)
    REFERENCES `Motriz`.`peca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movimentacao_fornecedor`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `Motriz`.`fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movimentacao_colaborador`
    FOREIGN KEY (`colaborador_id`)
    REFERENCES `Motriz`.`colaborador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_movimentacao_os`
  FOREIGN KEY (`os_id`)
  REFERENCES `Motriz`.`ordem_de_servico` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION

    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Motriz`.`item_os`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Motriz`.`item_os` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `peca_id` INT NULL,
  `servico_id` INT NULL,
  `os_id` INT NOT NULL,
  `quantidade_peca` INT NULL,
  `quantidade_servico` INT NULL,
  `preco_total_peca` INT NULL,
  `preco_total_servico` INT NULL,
  PRIMARY KEY (`id`),

  INDEX `fk_item_os_peca_idx` (`peca_id` ASC),
  INDEX `fk_item_os_servico_idx` (`servico_id` ASC),
  INDEX `fk_item_os_os_idx` (`os_id` ASC),

  CONSTRAINT `fk_item_os_peca`
    FOREIGN KEY (`peca_id`)
    REFERENCES `Motriz`.`peca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  CONSTRAINT `fk_item_os_servico`
    FOREIGN KEY (`servico_id`)
    REFERENCES `Motriz`.`servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  CONSTRAINT `fk_item_os_os`
    FOREIGN KEY (`os_id`)
    REFERENCES `Motriz`.`ordem_de_servico` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `Motriz`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Motriz`.`pagamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `valor` INT NOT NULL,
  `forma` VARCHAR(45) NOT NULL,
  `numero_parcela` INT NULL,
  `data_e_hora` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `colaborador_id` INT NOT NULL,
  `os_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pagamento_colaborador_idx` (`colaborador_id` ASC) ,
  INDEX `fk_pagamento_os_idx` (`os_id` ASC) ,
  CONSTRAINT `fk_pagamento_colaborador`
    FOREIGN KEY (`colaborador_id`)
    REFERENCES `Motriz`.`colaborador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagamento_os`
    FOREIGN KEY (`os_id`)
    REFERENCES `Motriz`.`ordem_de_servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
