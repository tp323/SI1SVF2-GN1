CREATE TABLE PASSAGEIRO (
	nid char(10),
	nome nvarchar(150),
	dtnascimento date not null ,
	email nvarchar(60) check (email like '%@%'),
	genero char(2) check (genero in ('F', 'M', 'NR', null)),
	primary key (nid)
)


CREATE TABLE LOCALIDADE (
	codpostal int check (codpostal < 10000000), --menor que o primeiro numero com 8 algarismos
	nome nvarchar(150),
	primary key (codpostal)
)

CREATE TABLE AUTOCARROTIPO (
	marca nchar(10) check(marca in ('MAN', 'VOLVO', 'IVECO', 'TEMSA')),
	modelo nchar(6) check(modelo in ('City C', 'City L', '9700', '9900', '12.8', 'PRO', 'SAFARI', 'METROP')),
	nlugares tinyint check (nlugares>=33), --menos numero de lugar entre os modelos disponiveis
    primary key (marca,modelo)
)


CREATE TABLE COMBOIOTIPO
(
    id          char(2) check (id in ('AP', 'IC', 'IR', 'R')),
    nome        char(25) check (nome in ('alfa-pendular', 'inter-cidades', 'inter-regional', 'regional')),
    nlugclasse1 tinyint,
    nlugclasse2 tinyint,
    primary key (id),
    check (((nome != 'alfa-pendular') and (nlugclasse1 <= 100 and nlugclasse1 >= 10) and
            (nlugclasse2 <= 250 and nlugclasse2 >= 100))
        or (nome = 'alfa-pendular' and (299-nlugclasse2) = nlugclasse1))
)

CREATE TABLE LUGARTIPO (
	numero int,
	nome nvarchar(10) check (nome in ('adulto', 'jovem', 'senior', 'crianca', 'militar')),
	classe tinyint check (classe = 1 or classe = 2),
	preco decimal(5,2),
	primary key (numero)
)

CREATE TABLE ESTACAO (
	nome varchar(40), --restricao?
	tipo char(10) check(tipo in ('terminal', 'paragem')),
	nplataforma tinyint check (nplataforma > 0),
	localidade int references LOCALIDADE(codpostal),
	primary key (nome)
)

CREATE TABLE VIAGEM (
	ident int unique ,
	dataviagem date,
	horapartida time,
	horachegada time ,
	distancia int,
	estpartida varchar(40) references ESTACAO(nome),
	estchegada varchar(40) references ESTACAO(nome) ,
	primary key (ident),
	check (estchegada != estpartida),
	check (horachegada > horapartida),
)

CREATE TABLE RESERVA (
	ident int,
	datareserva smalldatetime,
	modopagamento char(10) check(modopagamento in ('MB', 'Pay Pal', 'CC')) ,
	viagem int references VIAGEM(ident),
	primary key (ident)
)

CREATE TABLE TRANSPORTE (
	ident tinyint,
	viagem int references VIAGEM(ident),
	velmaxima int,
	dataentradaservico date check (getdate() > dataentradaservico),
	atrdiscriminante char(1) check (atrdiscriminante in ('A', 'C')),
	primary key (ident)
)

CREATE TABLE AUTOCARRO (
	matricula nchar(8) check([matricula] like ('[A-Z][A-Z]-[0-9][0-9]-[A-Z][A-Z]')),
	transporte tinyint references TRANSPORTE(ident),
	datarevisao date not null check (DATEDIFF(day, getdate(),datarevisao) > 0), --rever isto
	marca nchar(10),
	modelo nchar(6),
	primary key (matricula,transporte),
    foreign key (marca,modelo) references AUTOCARROTIPO(marca, modelo)
)

CREATE TABLE COMBOIO (
	transporte tinyint references TRANSPORTE(ident),
	tipo char(2) references COMBOIOTIPO(id),
	ncarruagens tinyint ,
	primary key (transporte),
	check ((ncarruagens <= 8 and tipo = 'AP') or (ncarruagens <= 6 and tipo != 'AP'))
)

CREATE TABLE LUGAR (
	numero int,
	transporte tinyint references TRANSPORTE(ident),
	tipo int references LUGARTIPO(numero),
	primary key (numero, transporte, tipo)
)

CREATE TABLE PAGMBWAY (
	reserva int references RESERVA(ident),
	telefone varchar(25) check (telefone like '+3519[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	primary key (reserva, telefone)
)

CREATE TABLE BILHETE (
	passageiro char(10) references PASSAGEIRO(nid),
	nlugar int ,
	tipolugar int,
	transporte tinyint,
	reserva int references RESERVA(ident),
    primary key (passageiro,nlugar,tipolugar,transporte,reserva),
    foreign key (nlugar,transporte,tipolugar) references LUGAR(numero, transporte, tipo)
)

CREATE TABLE LOCOMOTIVA (
	nserie int unique ,
	comboio tinyint references COMBOIO(transporte),
	marca varchar(15) check (marca in ('Stadler','Medway','Mehano','Roco')),
	primary key (nserie,comboio)
)

CREATE TABLE ALFAPENDULAR (
	nserie int ,
	comboio tinyint,
	numero int,
	primary key (nserie,comboio),
	foreign key (nserie,comboio) references LOCOMOTIVA(nserie, comboio)
)










