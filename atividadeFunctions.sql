CREATE OR REPLACE FUNCTION incrementa(num int)
RETURNS int
AS
$$
BEGIN
    RETURN num + 1;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION retornaTexto(texto text)
RETURNS text
AS
$$
BEGIN
    RETURN texto;
END;
$$
LANGUAGE plpgsql;

CREATE TABLE usuario (
    ide INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    CONSTRAINT pk_ide PRIMARY KEY (ide)
);

INSERT INTO usuario (ide,nome) VALUES 
('1','aaaaaa'),
('2','bbbbbb'),
('3','cccccc'),
('4','dddddd'),
('5','eeeeee');


CREATE OR REPLACE FUNCTION retornaMedia()
RETURNS TABLE (ide INTEGER, nome VARCHAR(50))
AS
$$
BEGIN
RETURN QUERY SELECT u.ide, u.nome FROM usuario u WHERE u.ide > (SELECT avg(u.ide) FROM usuario u);
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
RETURN QUERY UPDATE employee set salary *= 1.1;
END;
$$
LANGUAGE plpgsql;