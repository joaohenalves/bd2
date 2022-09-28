-- Exercício 1

CREATE OR REPLACE FUNCTION incrementa(num INTEGER)
RETURNS INTEGER
AS
$$
BEGIN
    RETURN num + 1;
END;
$$
LANGUAGE plpgsql;

-- Exercício 2

CREATE OR REPLACE FUNCTION retornaTexto(texto TEXT)
RETURNS text
AS
$$
BEGIN
    RETURN texto;
END;
$$
LANGUAGE plpgsql;

-- Exercício 3

CREATE TABLE usuario (
    id INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY (id)
);

INSERT INTO usuario (id,nome) VALUES 
('1','aaaaaa'),
('2','bbbbbb'),
('3','cccccc'),
('4','dddddd'),
('5','eeeeee');


CREATE OR REPLACE FUNCTION retornaMedia()
RETURNS TABLE (id INTEGER, nome VARCHAR(50))
AS
$$
BEGIN
RETURN QUERY SELECT u.id, u.nome FROM usuario u WHERE u.id > (SELECT avg(u.id) FROM usuario u);
END;
$$
LANGUAGE plpgsql;



CREATE TABLE employee (
    id INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    anonasc INTEGER NOT NULL,
    salary MONEY NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY (id)
);

CREATE OR REPLACE FUNCTION aplicaAumento()
RETURNS TABLE (id INTEGER, nome VARCHAR(50), anonasc INTEGER, salary MONEY)
AS
$$
BEGIN
RETURN QUERY UPDATE employee SET salary *= 1.1;
END;
$$
LANGUAGE plpgsql;