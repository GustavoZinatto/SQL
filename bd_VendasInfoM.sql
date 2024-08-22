------------------------------------------------------------------------------------------------------------------------------------------------
--Criando Banco de dados

create database VendasInfoM;
go
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
--Acessar o Banco de Dados
use VendasInfoM
go
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
--Criar tabela Pessoas

create table Pessoas (
	idPessoa int not null primary key identity,
	nome varchar(50) not null,
	cpf varchar(14) not null unique,
	status int null,
	--restrições Status 1 = Ativo | 2 = Inativo | 3 = Cancelado
	check (status in(1,2,3))
)
go
------------------------------------------------------------------------------------------------------------------------------------------------

--Consultar informações sobre a Tabela
exec sp_help Pessoas
go

------------------------------------------------------------------------------------------------------------------------------------------------
--CRIAR TABELA CLIENTES

create table Clientes (
	pessoaId	int				not null	primary key,
	renda		decimal(10,2)	not null,
	credito		decimal(10,2)	not null,
	--chave estrangeira FK
	foreign	key(pessoaId)	references Pessoas(idPessoa),
	--restrições
	check(renda>=700.00),
	check(credito >= 100.00)
)
go
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
--CRIAR TABELA VENDEDORES

create table Vendedores (
	pessoaId	int			not null	primary key,
	salario		decimal		not null	check(salario >= 1000.00),
	--chave estrangeira FK
	foreign	key(pessoaId)	references Pessoas(idPessoa)
)
go
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
-- Cadastrar 10 Pessoas - INSERT NA TABELA PESSOAS

insert into Pessoas (nome, cpf, status)
values	('Valéria Maria Volpe', '111.111.111-11', 1),
		('Mário Henrique Pardo', '222.222.222-22', null),
		('Waldir Barros', '333.333.333-33', 2),
		('Lucimar Sasso Vieira', '444.444.444-44', 3),
		('Maura Frigo', '555.555.555-55', 1),
		('Lucimeire Schinelo', '666.666.666-66', 2),
		('Adriano Simonato', '777.777.777-77', 1),
		('Adriana Generoso', '888.888.888-88', 1),
		('Claudia Hidalgo', '999.999.999-99', 2),
		('Luciene Cavalcanti', '101.010.101-01', 3)
go
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
-- Cadastrar 5 Clientes - INSERT NA TABELA CLIENTES

insert into Clientes(pessoaId, renda, credito)
values	(1, 1500.00, 750.00),
		(3, 2500.00, 750.00),
		(5, 5000.00, 1500.00),
		(7, 1700.00, 980.00),
		(9, 1872.00, 258.00)
go

------------------------------------------------------------------------------------------------------------------------------------------------

select * from Pessoas
go

select * from Clientes
go

------------------------------------------------------------------------------------------------------------------------------------------------
-- CONSULTAR TODAS AS PESSOAS QUE SÃO CLIENTES

--SELECT MOSTRANDO A INTERSECÇÃO (traz tudo que é comum; Intersecção)
select	Pessoas.idPessoa Cod_Cliente, Pessoas.nome Cliente, Pessoas.cpf CPF_Cliente, Pessoas.status Situacao, Clientes.renda Renda_Cliente,
		Clientes.credito Credito_Cliente
from	Pessoas, Clientes
where	Pessoas.idPessoa = Clientes.pessoaId

--usando o INNER JOIN
select	Pessoas.idPessoa Cod_Cliente, Pessoas.nome Cliente, Pessoas.cpf CPF_Cliente, Pessoas.status Situacao, Clientes.renda Renda_Cliente,
		Clientes.credito Credito_Cliente
from Pessoas INNER JOIN Clientes ON Pessoas.idPessoa = Clientes.pessoaId
go
------------------------------------------------------------------------------------------------------------------------------------------------

