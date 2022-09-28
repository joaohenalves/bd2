-- 1 - 

select e1.nome as empregado, e2.nome as chefe, e1.salario as "emp sal", e2.salario as "chef sal" from empregados e1 join empregados e2 on e1.supervisor_id=e2.emp_id where e1.salario > e2.salario;

-- 2 - 

select e.dep_id, max(e.salario) from empregados e group by e.dep_id;

-- 3 - 

select e1.dep_id, e1.nome, e1.salario from empregados e1 join (select e.dep_id, max(e.salario) as salr from empregados e group by e.dep_id) e2 on e1.dep_id=e2.dep_id and e1.salario=e2.salr;

-- 4 - 

select d.nome from departamentos d join empregados e on d.dep_id=e.dep_id group by d.nome having count(e.emp_id) < 3;

-- 6 - 

select d.nome, count(e.emp_id) from departamentos d join empregados e on d.dep_id=e.dep_id group by d.nome;

-- 7 - 

select e1.nome, e1.dep_id from empregados e1 join empregados e2 on e1.supervisor_id=e2.emp_id where e1.dep_id <> e2.dep_id;

-- 8 - 

select d.nome, sum(e.salario) from departamentos d join empregados e on d.dep_id=e.dep_id group by d.nome;

-- 9 - 

select e.nome, e.salario from empregados e join (select e.dep_id, avg(e.salario) as average from empregados e group by e.dep_id) e2 on e.dep_id=e2.dep_id where e.salario > e2.average;

-- 10 - 

with avgtable(dep_id, average) as (select e.dep_id, avg(e.salario) from empregados e group by e.dep_id) select e.emp_id, e.nome, e.dep_id, e.salario, a.average from empregados e natural join avgtable a;

-- 11 - 

with avgtable(dep_id, average) as (select e.dep_id, avg(e.salario) from empregados e group by e.dep_id) select e.nome, e.salario, e.dep_id, a.average from empregados e natural join avgtable a where e.salario >= a.average;

-- Custom question: Mostra a lista de empregados e quem os supervisiona:

select e1.nome as supervisor, e2.nome as supervisionado from empregados e1 right join empregados e2 on e1.emp_id=e2.supervisor_id;