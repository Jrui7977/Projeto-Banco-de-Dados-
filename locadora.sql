CREATE Varchar DATABASE IF NOT EXISTS mydb;
use mydb;
CREATE TABLE IF NOT EXISTS `mydb`.`Endereco` (
  `Rua` VARCHAR(40) NULL,
  `CEP` VARCHAR(16) NULL,
  `BAIRRO` VARCHAR(16) NULL,
  `numero` INT NULL,
  `complemento` VARCHAR(16) NULL,
  `cidade` VARCHAR(16) NULL,
  `email` VARCHAR(45) NULL,
  `idEndereco` INT NOT NULL,
  PRIMARY KEY (`idEndereco`));

CREATE TABLE IF NOT EXISTS `mydb`.`Telefone` (
  `idTelefone` INT NOT NULL,
  `telefoneFixo` INT NULL,
  `telefoneSecundario` INT NULL,
  `telefoneCelular` INT NULL,
  PRIMARY KEY (`idTelefone`));


CREATE TABLE IF NOT EXISTS `mydb`.`Locadora` (
  `nomeLocadora` VARCHAR(16) NULL,
  `qtdVeiculos` INT NULL,
  `CNPJ` VARCHAR(32) NOT NULL,
  `Endereco_idEndereco` INT NOT NULL,
  `Telefone_idTelefone` INT NOT NULL,
  PRIMARY KEY (`CNPJ`),
  INDEX `fk_Locadora_Endereco1_idx` (`Endereco_idEndereco` ASC) ,
  INDEX `fk_Locadora_Telefone1_idx` (`Telefone_idTelefone` ASC) ,
  CONSTRAINT `fk_Locadora_Endereco1`
    FOREIGN KEY (`Endereco_idEndereco`)
    REFERENCES `mydb`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Locadora_Telefone1`
    FOREIGN KEY (`Telefone_idTelefone`)
    REFERENCES `mydb`.`Telefone` (`idTelefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `mydb`.`Veiculo` (
  `idVeiculo` INT NOT NULL,
  `descricao_veiculo` VARCHAR(45) NULL,
  `modelo` VARCHAR(16) NULL,
  `fabricante` VARCHAR(16) NULL,
  `nomeVeiculo` VARCHAR(16) NULL,
  `Veiculocol` VARCHAR(45) NULL,
  `tipoVeiculo` VARCHAR(16) NULL,
  `placa` VARCHAR(16) NULL,
  `Locadora_CNPJ` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`idVeiculo`),
  INDEX `fk_Veiculo_Locadora1_idx` (`Locadora_CNPJ` ASC),
  CONSTRAINT `fk_Veiculo_Locadora1`
    FOREIGN KEY (`Locadora_CNPJ`)
    REFERENCES `mydb`.`Locadora` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `nomeCliente` VARCHAR(32) NULL,
  `data_nasci` DATE NULL,
  `sexo` VARCHAR(45) NULL,
  `CNH` VARCHAR(16) NOT NULL,
  `Locadora_CNPJ` VARCHAR(32) NOT NULL,
  `Endereco_idEndereco` INT NOT NULL,
  PRIMARY KEY (`CNH`),
  INDEX `fk_Cliente_Locadora1_idx` (`Locadora_CNPJ` ASC),
  INDEX `fk_Cliente_Endereco1_idx` (`Endereco_idEndereco` ASC),
  CONSTRAINT `fk_Cliente_Locadora1`
    FOREIGN KEY (`Locadora_CNPJ`)
    REFERENCES `mydb`.`Locadora` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Endereco1`
    FOREIGN KEY (`Endereco_idEndereco`)
    REFERENCES `mydb`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `mydb`.`Reserva` (
  `idReserva` INT NOT NULL,
  `dataReserva` DATE NULL,
  `ativa` INT NULL,
  `valor` FLOAT NULL,
  `dataDevolucao` DATE NULL,
  `Cliente_CNH` VARCHAR(16) NOT NULL,
  `Veiculo_idVeiculo` INT NOT NULL,
  PRIMARY KEY (`idReserva`, `Veiculo_idVeiculo`),
  INDEX `fk_Reserva_Cliente1_idx` (`Cliente_CNH` ASC),
  INDEX `fk_Reserva_Veiculo1_idx` (`Veiculo_idVeiculo` ASC),
  CONSTRAINT `fk_Reserva_Cliente1`
    FOREIGN KEY (`Cliente_CNH`)
    REFERENCES `mydb`.`Cliente` (`CNH`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_Veiculo1`
    FOREIGN KEY (`Veiculo_idVeiculo`)
    REFERENCES `mydb`.`Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `mydb`.`Funcionario` (
  `nome_funcionario` VARCHAR(32) NULL,
  `ctps` VARCHAR(45) NULL,
  `turno` VARCHAR(45) NULL,
  `SIAPE` INT NOT NULL,
  `Locadora_CNPJ` VARCHAR(32) NOT NULL,
  `Telefone_idTelefone` INT NOT NULL,
  `Endereco_idEndereco` INT NOT NULL,
  PRIMARY KEY (`SIAPE`, `Telefone_idTelefone`, `Endereco_idEndereco`),
  INDEX `fk_Funcionario_Locadora1_idx` (`Locadora_CNPJ` ASC) ,
  INDEX `fk_Funcionario_Telefone1_idx` (`Telefone_idTelefone` ASC) ,
  INDEX `fk_Funcionario_Endereco1_idx` (`Endereco_idEndereco` ASC) ,
  CONSTRAINT `fk_Funcionario_Locadora1`
    FOREIGN KEY (`Locadora_CNPJ`)
    REFERENCES `mydb`.`Locadora` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_Telefone1`
    FOREIGN KEY (`Telefone_idTelefone`)
    REFERENCES `mydb`.`Telefone` (`idTelefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_Endereco1`
    FOREIGN KEY (`Endereco_idEndereco`)
    REFERENCES `mydb`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `mydb`.`Cadastro` (
  `idCadastro` INT NOT NULL,
  `Funcionario_SIAPE` INT NOT NULL,
  `Cliente_CNH` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`idCadastro`),
  INDEX `fk_Cadastro_Funcionario1_idx` (`Funcionario_SIAPE` ASC),
  INDEX `fk_Cadastro_Cliente1_idx` (`Cliente_CNH` ASC),
  CONSTRAINT `fk_Cadastro_Funcionario1`
    FOREIGN KEY (`Funcionario_SIAPE`)
    REFERENCES `mydb`.`Funcionario` (`SIAPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cadastro_Cliente1`
    FOREIGN KEY (`Cliente_CNH`)
    REFERENCES `mydb`.`Cliente` (`CNH`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `mydb`.`Contrato` (
  `inicioContrato` DATE NULL,
  `fimContrato` DATE NULL,
  `Salario` FLOAT NULL,
  `idContrato` INT NOT NULL,
  `Funcionario_SIAPE` INT NOT NULL,
  PRIMARY KEY (`idContrato`),
  INDEX `fk_Contrato_Funcionario1_idx` (`Funcionario_SIAPE` ASC),
  CONSTRAINT `fk_Contrato_Funcionario1`
    FOREIGN KEY (`Funcionario_SIAPE`)
    REFERENCES `mydb`.`Funcionario` (`SIAPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


