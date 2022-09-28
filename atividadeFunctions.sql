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
RETURNS TEXT
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
(1,'aaaaaa'),
(2,'bbbbbb'),
(3,'cccccc'),
(4,'dddddd'),
(5,'eeeeee');


CREATE OR REPLACE FUNCTION retornaMedia()
RETURNS TABLE (id INTEGER, nome VARCHAR(50))
AS
$$
BEGIN
    RETURN QUERY SELECT u.id, u.nome FROM usuario u WHERE u.id > (SELECT avg(u.id) FROM usuario u);
END;
$$
LANGUAGE plpgsql;


-- Exercício 1 (condicionais)

CREATE OR REPLACE FUNCTION calculaValor(op INTEGER, valor REAL)
RETURNS REAL
AS
$$
BEGIN
    IF op = 1 THEN
        RETURN valor*1.1;
    ELSIF op = 2 THEN
        RETURN valor*0.9;
    ELSE
        RETURN valor;
    END IF;
END;
$$
LANGUAGE plpgsql;

-- Exercício 2 (condicionais)

CREATE TABLE users (
    id_user INTEGER NOT NULL,
    nome_user VARCHAR(50) NOT NULL,
    salario_user REAL NOT NULL,
    CONSTRAINT pk_id_user PRIMARY KEY (id_user)
);

INSERT INTO users (id_user, nome_user, salario_user) VALUES 
(1, 'aaaa', 3000),
(2, 'bbbb', 7500),
(3, 'cccc', 2876),
(4, 'dddd', 10500),
(5, 'eeee', 11350);

CREATE OR REPLACE FUNCTION attSalario()
RETURNS TABLE (iduser INTEGER, nomeuser VARCHAR(50), slruser REAL)
AS
$$
BEGIN
    UPDATE users SET salario_user = (case when salario_user < 10000 then salario_user * 1.05 when salario_user >= 10000 then salario_user * 1.01 END);
    RETURN QUERY SELECT u.* from users u;
END;
$$
LANGUAGE plpgsql;

-- Atividade A1 (a)

CREATE TABLE employee (
    id INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    anonasc INTEGER NOT NULL,
    salary REAL NOT NULL,
    CONSTRAINT pk_id_emp PRIMARY KEY (id)
);

INSERT INTO employee (id, nome, anonasc, salary) VALUES 
(1, 'aaaaaa', 1996, 3000),
(2, 'bbbbbb', 1998, 2500),
(3, 'cccccc', 1990, 6200),
(4, 'dddddd', 2003, 10500),
(5, 'eeeeee', 2000, 1750);

CREATE OR REPLACE FUNCTION aplicaAumento()
RETURNS SETOF employee
AS
$$
BEGIN
    UPDATE employee SET salary = salary * 1.1;
    RETURN QUERY SELECT * FROM employee;
END;
$$
LANGUAGE plpgsql;

-- Atividade A1 (b)

CREATE OR REPLACE FUNCTION aumentoCustom(prct REAL, id_target INTEGER)
RETURNS SETOF employee
AS
$$
DECLARE
prct_aum REAL = (prct / 100.0) + 1;
BEGIN
    UPDATE employee SET salary = salary * prct_aum WHERE id > id_target;
    RETURN QUERY SELECT * FROM employee;
END;
$$
LANGUAGE plpgsql;

-- Atividade A1 (c)

CREATE OR REPLACE FUNCTION deletaAcimaMedia()
RETURNS SETOF employee
AS
$$
BEGIN
    DELETE FROM employee WHERE salary > (SELECT avg(salary) FROM employee);
    RETURN QUERY SELECT * FROM employee;
END;
$$
LANGUAGE plpgsql;
