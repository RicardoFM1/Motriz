-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema motriz
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema motriz
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `motriz` DEFAULT CHARACTER SET utf8mb4 ;
USE `motriz` ;

-- -----------------------------------------------------
-- Table `motriz`.`subcategoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`subcategoria` (
  `id` INT(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `motriz`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`categoria` (
  `id` INT(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `subcategoria_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) ,
  INDEX `fk_categoria_subcategoria_idx` (`subcategoria_id` ASC) ,
  CONSTRAINT `fk_categoria_subcategoria`
    FOREIGN KEY (`subcategoria_id`)
    REFERENCES `motriz`.`subcategoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `motriz`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`endereco` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(150) NOT NULL,
  `numero` INT(11) NOT NULL,
  `complemento` VARCHAR(150) NOT NULL,
  `bairro` VARCHAR(150) NOT NULL,
  `cidade` VARCHAR(150) NOT NULL,
  `UF` VARCHAR(45) NOT NULL,
  `CEP` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `motriz`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`cliente` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `documento` VARCHAR(20) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `data_de_nascimento` DATETIME NULL DEFAULT NULL,
  `endereco_id` INT(11) NOT NULL,
  `observacoes` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cliente_endereco_idx` (`endereco_id` ASC) ,
  CONSTRAINT `fk_cliente_endereco`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `motriz`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `motriz`.`unidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`unidade` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `telefone` VARCHAR(17) NOT NULL,
  `status` ENUM('ativo', 'inativo') NOT NULL,
  `endereco_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_unidade_endereco_idx` (`endereco_id` ASC) ,
  CONSTRAINT `fk_unidade_endereco`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `motriz`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `motriz`.`colaborador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`colaborador` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `perfil` ENUM('admin', 'gerente', 'atendente', 'mecanico', 'supervisor') NOT NULL,
  `data_de_admissao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `status` ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo',
  `colaborador_id` INT(11) NULL DEFAULT NULL,
  `unidade_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) ,
  INDEX `fk_colaborador_unidade_idx` (`unidade_id` ASC) ,
  INDEX `fk_colaborador_colaborador_idx` (`colaborador_id` ASC) ,
  CONSTRAINT `fk_colaborador_colaborador`
    FOREIGN KEY (`colaborador_id`)
    REFERENCES `motriz`.`colaborador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_colaborador_unidade`
    FOREIGN KEY (`unidade_id`)
    REFERENCES `motriz`.`unidade` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `motriz`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`fornecedor` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `razao_social` VARCHAR(45) NOT NULL,
  `CNPJ` VARCHAR(14) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `telefone` VARCHAR(17) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `motriz`.`veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`veiculo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `placa` VARCHAR(45) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `ano_de_fabricacao` YEAR(4) NOT NULL,
  `cor` VARCHAR(45) NOT NULL,
  `tipo_de_combustivel` VARCHAR(45) NOT NULL,
  `quilometragem` INT(11) NOT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `placa_UNIQUE` (`placa` ASC) ,
  CONSTRAINT `fk_veiculo_cliente`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `motriz`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `chk_ano_fabricacao` 
    CHECK (`ano_de_fabricacao` BETWEEN 1900 AND 2027)
    )
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `motriz`.`avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`avaliacao` (
  `id` INT NOT NULL,
  `nota` INT NOT NULL,
  `comentario` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `chk_avaliacao_nota`
  CHECK(`nota` BETWEEN 0 AND 10)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `motriz`.`ordem_de_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`ordem_de_servico` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `numero` INT(11) NOT NULL,
  `unidade_id` INT(11) NOT NULL,
  `veiculo_id` INT(11) NOT NULL,
  `mecanico_id` INT(11) NULL DEFAULT NULL,
  `atendente_id` INT(11) NOT NULL,
  `quilometragem` INT(11) NOT NULL,
  `data_e_hora` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `previsao_de_entrega` DATE NULL DEFAULT NULL,
  `status` ENUM('aberta', 'orçamento', 'aprovada', 'em_execução', 'aguardando_peca', 'finalizada', 'entregue', 'cancelado') NOT NULL DEFAULT 'aberta',
  `observacoes` VARCHAR(255) NULL DEFAULT NULL,
  `desconto_gerente` INT(11) NOT NULL,
  `preco_total_os` INT(11) NULL DEFAULT NULL,
  `cliente_id` INT NOT NULL,
  `avaliacao_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_os_veiculo_idx` (`veiculo_id` ASC) ,
  INDEX `fk_os_mecanico_idx` (`mecanico_id` ASC) ,
  INDEX `fk_os_atendente_idx` (`atendente_id` ASC) ,
  INDEX `fk_os_unidade_idx` (`unidade_id` ASC) ,
  UNIQUE INDEX `numero_UNIQUE` (`numero` ASC) ,
  INDEX `fk_os_cliente_idx` (`cliente_id` ASC) ,
  INDEX `fk_os_avaliacao_idx` (`avaliacao_id` ASC) ,
  CONSTRAINT `fk_os_atendente`
    FOREIGN KEY (`atendente_id`)
    REFERENCES `motriz`.`colaborador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_os_mecanico`
    FOREIGN KEY (`mecanico_id`)
    REFERENCES `motriz`.`colaborador` (`id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `fk_os_unidade`
    FOREIGN KEY (`unidade_id`)
    REFERENCES `motriz`.`unidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_os_veiculo`
    FOREIGN KEY (`veiculo_id`)
    REFERENCES `motriz`.`veiculo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_os_cliente`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `motriz`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_os_avaliacao`
    FOREIGN KEY (`avaliacao_id`)
    REFERENCES `motriz`.`avaliacao` (`id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
AUTO_INCREMENT = 41
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `motriz`.`peca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`peca` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `codigo` VARCHAR(45) NOT NULL,
  `preco_de_custo` INT(11) NOT NULL,
  `preco_de_venda` INT(11) NOT NULL,
  `estoque_minimo` INT(11) NOT NULL,
  `fornecedor_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) ,
  INDEX `fk_pecas_fornecedor_idx` (`fornecedor_id` ASC) ,
  CONSTRAINT `fk_pecas_fornecedor`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `motriz`.`fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `motriz`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`servico` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(255) NOT NULL,
  `preco_de_tabela` INT(11) NOT NULL,
  `tempo_estimado` TIME NOT NULL,
  `status` ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo',
  `categoria_id` INT(11) NOT NULL,
  `codigo` VARCHAR(45) NOT NULL,
  `colaborador_id` INT(11) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) ,
  INDEX `fk_servicos_colaborador_idx` (`colaborador_id` ASC) ,
  INDEX `fk_servico_categoria_idx` (`categoria_id` ASC) ,
  CONSTRAINT `fk_servico_categoria`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `motriz`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_colaborador`
    FOREIGN KEY (`colaborador_id`)
    REFERENCES `motriz`.`colaborador` (`id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `motriz`.`item_os`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`item_os` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `peca_id` INT(11) NULL DEFAULT NULL,
  `servico_id` INT(11) NULL DEFAULT NULL,
  `os_id` INT(11) NOT NULL,
  `quantidade_peca` INT(11) NULL DEFAULT NULL,
  `quantidade_servico` INT(11) NULL DEFAULT NULL,
  `preco_total_peca` INT(11) NULL DEFAULT NULL,
  `preco_total_servico` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_item_os_peca_idx` (`peca_id` ASC) ,
  INDEX `fk_item_os_servico_idx` (`servico_id` ASC) ,
  INDEX `fk_item_os_os_idx` (`os_id` ASC) ,
  CONSTRAINT `fk_item_os_os`
    FOREIGN KEY (`os_id`)
    REFERENCES `motriz`.`ordem_de_servico` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_item_os_peca`
    FOREIGN KEY (`peca_id`)
    REFERENCES `motriz`.`peca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_os_servico`
    FOREIGN KEY (`servico_id`)
    REFERENCES `motriz`.`servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    UNIQUE(os_id, servico_id),
    UNIQUE(os_id, peca_id)
    )
ENGINE = InnoDB
AUTO_INCREMENT = 101
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `motriz`.`movimentacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`movimentacao` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `estoque_atual` INT(11) NOT NULL,
  `peca_id` INT(11) NOT NULL,
  `fornecedor_id` INT(11) NOT NULL,
  `quantidade` INT(11) NOT NULL,
  `quando` DATETIME NOT NULL,
  `motivo` VARCHAR(255) NOT NULL,
  `colaborador_id` INT(11) NULL,
  `os_id` INT(11) NULL DEFAULT NULL,
  `tipo` ENUM('entrada', 'saida') NOT NULL DEFAULT 'entrada',
  PRIMARY KEY (`id`),
  INDEX `fk_movimentacao_peca_idx` (`peca_id` ASC) ,
  INDEX `fk_movimentacao_fornecedor_idx` (`fornecedor_id` ASC) ,
  INDEX `fk_movimentacao_colaborador_idx` (`colaborador_id` ASC) ,
  INDEX `fk_movimentacao_os_idx` (`os_id` ASC) ,
  CONSTRAINT `fk_movimentacao_colaborador`
    FOREIGN KEY (`colaborador_id`)
    REFERENCES `motriz`.`colaborador` (`id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `fk_movimentacao_fornecedor`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `motriz`.`fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movimentacao_os`
    FOREIGN KEY (`os_id`)
    REFERENCES `motriz`.`ordem_de_servico` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_movimentacao_peca`
    FOREIGN KEY (`peca_id`)
    REFERENCES `motriz`.`peca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 41
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `motriz`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`pagamento` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `valor` INT(11) NOT NULL,
  `forma` VARCHAR(45) NOT NULL,
  `numero_parcela` INT(11) NULL DEFAULT NULL,
  `data_e_hora` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `colaborador_id` INT(11) NOT NULL,
  `os_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pagamento_colaborador_idx` (`colaborador_id` ASC) ,
  INDEX `fk_pagamento_os_idx` (`os_id` ASC) ,
  CONSTRAINT `fk_pagamento_colaborador`
    FOREIGN KEY (`colaborador_id`)
    REFERENCES `motriz`.`colaborador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagamento_os`
    FOREIGN KEY (`os_id`)
    REFERENCES `motriz`.`ordem_de_servico` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `motriz`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `motriz`.`telefone` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `numero_fixo` VARCHAR(45) NULL DEFAULT NULL,
  `numero_celular` VARCHAR(45) NULL DEFAULT NULL,
  `numero_externo` VARCHAR(45) NULL DEFAULT NULL,
  `cliente_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cliente_id_UNIQUE` (`cliente_id` ASC) ,
  UNIQUE INDEX `numero_celular_UNIQUE` (`numero_celular` ASC) ,
  INDEX `fk_telefone_cliente_idx` (`cliente_id` ASC) ,
  CONSTRAINT `fk_telefone_cliente`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `motriz`.`cliente` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
