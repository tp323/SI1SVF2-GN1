CREATE TABLE PASSAGEIRO (
	nid char(10),
	nome nvarchar(150),
	dtnascimento date,
	email nvarchar(60),
	genero char(2)
)


CREATE TABLE LOCALIDADE (
	codpostal int,
	nome nvarchar(150)
)

CREATE TABLE AUTOCARROTIPO (
	marca nchar(10),
	modelo nchar(6),
	nlugares tinyint
)


CREATE TABLE COMBOIOTIPO (
	id char(2),
	nome nchar(10),
	nlugclasse1 tinyint,
	nlugclasse2 tinyint
)

CREATE TABLE LUGARTIPO (
	numero int,
	nome nvarchar(10),
	classe tinyint,
	preço decimal(5,2)
)

CREATE TABLE ESTACAO (
	nome varchar(25),
	tipo char(10),
	nplataforma tinyint,
	localidade int
)

CREATE TABLE VIAGEM (
	ident int,
	dataviagem date,
	horapartida time,
	horachegada time,
	distancia int,
	estpartida varchar(40),
	estchegada varchar(40)
)

CREATE TABLE RESERVA (
	ident int,
	datareserva smalldatetime,
	modopagamento char(10),
	viagem int
)

CREATE TABLE TRANSPORTE (
	ident tinyint,
	viagem int,
	velmaxima int,
	dataentradaserviço date,
	atrdiscriminante char(1)
)

CREATE TABLE AUTOCARRO (
	matricula nchar(10),
	transporte tinyint,
	datarevisao date,
	marca nchar(10),
	modelo nchar(6)
)

CREATE TABLE COMBOIO (
	transporte tinyint,
	tipo char(2),
	ncarruagens tinyint
)

CREATE TABLE LUGAR (
	numero int,
	transporte int,
	tipo int
)

CREATE TABLE PAGMBWAY (
	reserva int,
	telefone varchar(25)
)

CREATE TABLE BILHETE (
	passageiro char(10),
	nlugar int,
	tipolugar int,
	transporte int,
	reserva int
)

CREATE TABLE LOCOMOTIVA (
	nserie int,
	comboio tinyint,
	marca varchar(15)
)

CREATE TABLE ALFAPENDULAR (
	nserie int,
	comboio tinyint,
	numero int
)










