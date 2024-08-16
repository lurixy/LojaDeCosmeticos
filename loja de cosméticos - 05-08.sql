-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema lojadecosmeticos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lojadecosmeticos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lojadecosmeticos` DEFAULT CHARACTER SET utf8 ;
USE `lojadecosmeticos` ;

-- -----------------------------------------------------
-- Table `lojadecosmeticos`.`cidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojadecosmeticos`.`cidades` (
  `idcidades` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcidades`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojadecosmeticos`.`vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojadecosmeticos`.`vendas` (
  `idvendas` INT NOT NULL,
  `codigoproduto` VARCHAR(45) NOT NULL,
  `valor` DECIMAL(8,2) NOT NULL,
  `descproduto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idvendas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojadecosmeticos`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojadecosmeticos`.`clientes` (
  `idclientes` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `endereço` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `rg` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `idvendas` INT NOT NULL,
  `idcidades` INT NOT NULL,
  PRIMARY KEY (`idclientes`),
  INDEX `fk_clientes_Vendas1_idx` (`idvendas` ASC) VISIBLE,
  INDEX `fk_clientes_cidades1_idx` (`idcidades` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_Vendas1`
    FOREIGN KEY (`idvendas`)
    REFERENCES `lojadecosmeticos`.`vendas` (`idvendas`),
  CONSTRAINT `fk_clientes_cidades1`
    FOREIGN KEY (`idcidades`)
    REFERENCES `lojadecosmeticos`.`cidades` (`idcidades`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojadecosmeticos`.`estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojadecosmeticos`.`estoque` (
  `idestoque` INT NOT NULL,
  `codigo` VARCHAR(45) NULL DEFAULT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `preco` DECIMAL(8,5) NULL DEFAULT NULL,
  PRIMARY KEY (`idestoque`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojadecosmeticos`.`fornecedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojadecosmeticos`.`fornecedores` (
  `idfornecedores` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idfornecedores`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojadecosmeticos`.`produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojadecosmeticos`.`produtos` (
  `idprodutos` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(8,5) NOT NULL,
  `quantidade` INT NOT NULL,
  `idfornecedores` INT NOT NULL,
  `quantidadeestoque` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idprodutos`),
  INDEX `fk_produtos_fornecedores1_idx` (`idfornecedores` ASC) VISIBLE,
  CONSTRAINT `fk_produtos_fornecedores1`
    FOREIGN KEY (`idfornecedores`)
    REFERENCES `lojadecosmeticos`.`fornecedores` (`idfornecedores`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lojadecosmeticos`.`itens_venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojadecosmeticos`.`itens_venda` (
  `idprodutos` INT NOT NULL,
  `idvendas` INT NOT NULL,
  INDEX `fk_produtos_has_Vendas_Vendas1_idx` (`idvendas` ASC) VISIBLE,
  INDEX `fk_produtos_has_Vendas_produtos1_idx` (`idprodutos` ASC) VISIBLE,
  CONSTRAINT `fk_produtos_has_Vendas_produtos1`
    FOREIGN KEY (`idprodutos`)
    REFERENCES `lojadecosmeticos`.`produtos` (`idprodutos`),
  CONSTRAINT `fk_produtos_has_Vendas_Vendas1`
    FOREIGN KEY (`idvendas`)
    REFERENCES `lojadecosmeticos`.`vendas` (`idvendas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO fornecedores (idfornecedores, nome, endereco, telefone, email)
VALUES (1, 'Lurian', 'Rua Fabio de Oliveira Coimbra', '35992567739', 'lurianleticia@hotmail.com'),
       (2, 'Gian', 'Rua 13', '35995564123', 'gianlucca@gmail.com'),
       (3, 'Anderson', 'Rua Professor Salatiel de Almeida', '3595544789', 'andersonhenrique@gmail.com'),
       (4, 'Tulio', 'Rua Benedito', '3592569987', 'tuliomz@gmail.com');
SELECT * FROM Fornecedores;

INSERT INTO produtos (idprodutos, nome, marca, preco, quantidade, idfornecedores, quantidadeestoque)
VALUES (1, 'Base Liquida', 'Vult', '35.00', '25', '1', '50'),
       (2, 'Delineador', 'Vult', '25.00', '25', '1', '50'),
       (3, 'Pó Compacto', 'Vult', '20.00', '25', '1', '50'),
       (4, 'Mascara de Cilios', 'Vult', '25.00', '25', '1', '50'),
       (5, 'Shampoo', 'Lolla Cosmeticos', '35.00', '25', '2', '50'),
       (6, 'Condicionador', 'Lolla Cosmeticos', '35.00', '25', '2', '50'),
       (7, 'Mascara', 'Lolla Cosmeticos', '40.00', '25', '2', '50'),
       (8, 'Oleo Capilar', 'Lolla Cosmeticos', '18.00', '25', '2', '50'),
       (9, 'Protetor Solar', 'LaRoche Posay', '70.00', '25', '3', '50'),
       (10, 'Protetor Solar', 'Neostrata', '60.00', '25', '3', '50'),
	   (11, 'Protetor Solar', 'Nivea', '30.00', '25', '3', '50'),
       (12, 'Sabonete Liquido', 'LaRoche Posay', '80.00', '25', '3', '50'),
       (13, 'Sabonete Liquido', 'Neostrata', '40.00', '25', '3', '50'),
       (14, 'Sabonete Liquido', 'Nivea', '25.00', '25', '3', '50'),
       (15, 'Hidratante Corpo e Rosto', 'Nivea', '25.00', '25', '4', '50'),
       (16, 'Hidratante Corpo e Rosto', 'Monange', '15.00', '25', '4', '50'),
       (17, 'Hidratante Corpo e Rosto', 'Hidraderme', '20.00', '25', '4', '50'),
	   (18, 'Hidratante Corpo e Rosto', 'Flores e Vegetais', '30.00', '25', '4', '50');
SELECT * FROM Produtos; 


-- Atualizando a tabela de vendas com novas vendas
INSERT INTO vendas (idvendas, codigoproduto, valor, descproduto)
VALUES 
(16, '22025', '00.00', 'Base de longa duração 24h'),
(17, '22026', '00.00', 'Delineador de longa duração 24h'),
(18, '22027', '00.00', 'Pó compacto de longa duração 24h'),
(19, '22028', '00.00', 'Mascara de Cilios de longa duração 24h'),
(20, '22029', '00.00', 'Shampoo sem sal hidratante'),
(21, '22030', '00.00', 'Condicionador hidratante'),
(22, '22031', '00.00', 'Mascara super concentrada'),
(23, '22032', '00.00', 'Oleo Capilar com protecao termica'),
(24, '22033', '00.00', 'Protecao solar filtro UV/UVA'),
(25, '22034', '00.00', 'Protecao solar OIL CONTROL filtro UV/UVA'),
(26, '22035', '00.00', 'Protecao solar hidratante filtro UV/UVA'),
(27, '22036', '00.00', 'Hidratação 24h com oleos naturais'),
(28, '22037', '00.00', 'Hidratacao 24h OIL CONTROL'),
(29, '22038', '00.00', 'Hidratacao 24h OIL CONTROL'),
(30, '22039', '00.00', 'Hidratacao 24h erva doce');

SELECT * FROM Vendas;

INSERT INTO cidades (idcidades, nome, estado)
VALUES (1,'Muzambinho', 'Minas Gerais'),
       (2, 'Muzambinho', 'Minas Gerais'),
       (3, 'Guaxupe', 'Minas Gerais'),
       (4, 'Pocos de Caldas', 'Minas Gerais');
       
-- Atualizando a tabela de clientes com novos clientes correspondentes às novas vendas
INSERT INTO clientes (idclientes, nome, endereço, cpf, rg, telefone, idvendas, idcidades)
VALUES 
(5, 'Heloisa', 'Rua Fabio de Oliveira Coimbra', '155.659.569.83', '15.426.598', '3595548779', '16','1'),
(6, 'Lauro', 'Rua Fabio de Oliveira Coimbra', '258.569.854.89', '25.569.874',  '35998855632', '17', '2'),
(7, 'Renan', 'Rua Fabio de Oliveira Coimbra', '265.784.569.32', '23.542.587', '35995523695', '18','3'),
(8, 'Luiza', 'Rua Fabio de Oliveira Coimbra', '222.566.356.69', '25.897.354', '35995568471', '19', '4'),
(9, 'Heloisa', 'Rua Fabio de Oliveira Coimbra', '155.659.569.83', '15.426.598', '3595548779', '20', '1'),
(10, 'Lauro', 'Rua Fabio de Oliveira Coimbra', '258.569.854.89', '25.569.874',  '35998855632', '21','2'),
(11, 'Renan', 'Rua Fabio de Oliveira Coimbra', '265.784.569.32', '23.542.587', '35995523695', '22','3'),
(12, 'Luiza', 'Rua Fabio de Oliveira Coimbra', '222.566.356.69', '25.897.354', '35995568471', '23','4'),
(13, 'Heloisa', 'Rua Fabio de Oliveira Coimbra', '155.659.569.83', '15.426.598', '3595548779', '24','1'),
(14, 'Lauro', 'Rua Fabio de Oliveira Coimbra', '258.569.854.89', '25.569.874',  '35998855632', '25','2'),
(15, 'Renan', 'Rua Fabio de Oliveira Coimbra', '265.784.569.32', '23.542.587', '35995523695', '26','3');




INSERT INTO itens_Venda
VALUES (1, '2' ),
       (5, '3' ),
	   (2, '5' ),
	   (6, '7' ),
	   (3, '8' ),
	   (8, '9' );
       
SELECT * FROM fornecedores;
SELECT idprodutos, nome, marca, preco FROM produtos WHERE marca = 'Vult'; -- produtos marca vult
SELECT COUNT(*) AS total_vendas FROM vendas;
SELECT AVG(preco) AS average_price FROM produtos;
SELECT p.nome AS produto, f.nome AS fornecedor
FROM produtos p
INNER JOIN fornecedores f ON p.idfornecedores = f.idfornecedores;
SELECT v.codigoproduto, SUM(v.valor) AS total_sales
FROM vendas v
GROUP BY v.codigoproduto;
SELECT c.nome AS cliente, SUM(v.valor) AS total_compras
FROM clientes c
INNER JOIN vendas v ON c.idvendas = v.idvendas
INNER JOIN cidades cid ON c.idclientes = cid.idclientes
WHERE cid.nome = 'Muzambinho'
GROUP BY c.nome;
SELECT nome, quantidadeestoque
FROM produtos
ORDER BY quantidadeestoque DESC
LIMIT 5;
SELECT * FROM produtos WHERE preco > 30.00; -- produtos acima de 30,00
SELECT nome, preco
FROM produtos
WHERE idfornecedores = 2
ORDER BY preco DESC;

-- Qual é o produto, nome e preço, mais caros? --
SELECT produtos.nome, produtos.preco
FROM produtos
INNER JOIN (
    SELECT MAX(preco) AS max_preco
    FROM produtos
) AS max_precos
ON produtos.preco = max_precos.max_preco;

--  Quais são os fornecedores que forneceram produtos com preços acima de R$ 30,00?--

SELECT f.nome AS nome_fornecedor, p.nome AS nome_produto, p.preco
FROM fornecedores f
INNER JOIN produtos p ON f.idfornecedores = p.idfornecedores
WHERE p.preco > 30.00;

-- Qual é o total de vendas de cada produto?-- 

SELECT p.nome AS nome_produto, SUM(iv.idprodutos) AS total_vendas
FROM produtos p
INNER JOIN itens_venda iv ON p.idprodutos = iv.idprodutos
GROUP BY p.nome;

-- Qual é o produto mais vendido e seu respectivo fornecedor?--

SELECT p.nome AS nome_produto, f.nome AS nome_fornecedor, COUNT(iv.idprodutos) AS total_vendas
FROM produtos p
INNER JOIN itens_venda iv ON p.idprodutos = iv.idprodutos
INNER JOIN fornecedores f ON p.idfornecedores = f.idfornecedores
GROUP BY p.nome
ORDER BY total_vendas DESC
LIMIT 1;

-- Quais são os produtos fornecidos por cada fornecedor?--

-- LEFT JOIN
SELECT f.nome AS nome_fornecedor, p.nome AS nome_produto
FROM fornecedores f
LEFT JOIN produtos p ON f.idfornecedores = p.idfornecedores;

-- Quais são os clientes que fizeram compras e quais produtos eles compraram? --

-- RIGHT JOIN
SELECT c.nome AS nome_cliente, v.descproduto
FROM clientes c
RIGHT JOIN vendas v ON c.idvendas = v.idvendas;

CREATE VIEW vw_produtos_fornecedores AS
SELECT p.nome AS produto, p.preco, f.nome AS fornecedor
FROM produtos p
INNER JOIN fornecedores f ON p.idfornecedores = f.idfornecedores;

CREATE VIEW vw_vendas_clientes AS
SELECT c.nome AS cliente, v.codigoproduto, v.valor, v.descproduto
FROM clientes c
INNER JOIN vendas v ON c.idvendas = v.idvendas;


SELECT p.nome AS item, 'Produto' AS tipo
FROM produtos p
UNION
SELECT f.nome AS item, 'Fornecedor' AS tipo
FROM fornecedores f;


SELECT p.nome AS item, 'Produto' AS tipo
FROM produtos p
UNION ALL
SELECT f.nome AS item, 'Fornecedor' AS tipo
FROM fornecedores f;



DELIMITER //


CREATE TRIGGER trg_atualizar_estoque AFTER INSERT ON itens_venda
FOR EACH ROW
BEGIN
    UPDATE produtos
    SET quantidade = quantidade - 1
    WHERE idprodutos = NEW.idprodutos;
END; DELIMITER ;

DELIMITER //
--  Atualizar o Estoque ao Inserir em itens_venda --
CREATE TRIGGER trg_check_valor_venda BEFORE INSERT ON vendas
FOR EACH ROW
BEGIN
    IF NEW.valor < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O valor da venda não pode ser negativo.';
    END IF; 
END; DELIMITER ;


CREATE PROCEDURE sp_inserir_produto(
    IN p_nome VARCHAR(45),
    IN p_marca VARCHAR(45),
    IN p_preco DECIMAL(8,5),
    IN p_quantidade INT,
    IN p_idfornecedores INT,
    IN p_quantidadeestoque VARCHAR(45)
)
BEGIN
    INSERT INTO produtos (nome, marca, preco, quantidade, idfornecedores, quantidadeestoque)
    VALUES (p_nome, p_marca, p_preco, p_quantidade, p_idfornecedores, p_quantidadeestoque);
END; DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_vendas_cliente(IN cliente_id INT)
BEGIN
    SELECT v.codigoproduto, v.valor, v.descproduto
    FROM vendas v
    INNER JOIN clientes c ON v.idvendas = c.idvendas
    WHERE c.idclientes = cliente_id;
END; DELIMITER ;







       
