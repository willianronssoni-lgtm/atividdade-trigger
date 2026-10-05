CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    quantidade INT
);

CREATE TABLE historico_estoque (
    id INT PRIMARY KEY AUTO_INCREMENT,
    produto_id INT,
    quantidade_antiga INT,
    quantidade_nova INT,
    data_alteracao DATETIME
);

DELIMITER $$

CREATE TRIGGER registrar_alteracao_estoqueque
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    INSERT INTO historico_estoque (
        produto_id,
        quantidade_antiga,
        quantidade_nova,
        data_alteracao
    )
    VALUES (
        OLD.id,
        OLD.quantidade,
        NEW.quantidade,
        NOW()
    );
END$$

DELIMITER ;

INSERT INTO produtos (nome, quantidade)
VALUES
    ('Detergente', 10),
    ('WD40', 20);

UPDATE produtos
SET quantidade = 15
WHERE nome = 'Detergente';

UPDATE produtos
SET quantidade = 18
WHERE nome = 'Detergente';

SELECT * FROM historico_estoque;
