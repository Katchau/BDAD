.bail ON
.mode columns
.headers on
.nullvalue NULL
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS OCORRENCIA;
DROP TABLE IF EXISTS BILHETE;
DROP TABLE IF EXISTS PESSOA;
DROP TABLE IF EXISTS SEXO_WINK;
DROP TABLE IF EXISTS CLIENTE;
DROP TABLE IF EXISTS FUNCIONARIO;
DROP TABLE IF EXISTS ITINERARIO;
DROP TABLE IF EXISTS TIPODEFUNCAO;
DROP TABLE IF EXISTS ESTACAO;
DROP TABLE IF EXISTS CIDADE; 
DROP TABLE IF EXISTS COMBOIOCARRUAGEM;
DROP TABLE IF EXISTS ITINERARIOESTACAO;
DROP TABLE IF EXISTS COMBOIO;
DROP TABLE IF EXISTS CARRUAGEM;
DROP TABLE IF EXISTS FUNCIONARIOESTACAO;



CREATE TABLE SEXO_WINK
(
	idSexo INTEGER NOT NULL PRIMARY KEY,
	hora TIME NOT NULL,
	dataOcorr DATE NOT NULL,
	idClient INTEGER NOT NULL,
	idFuncionario INTEGER NOT NULL,
	FOREIGN KEY (idClient) REFERENCES CLIENTE(idClient),
	FOREIGN KEY (idFuncionario) REFERENCES FUNCIONARIO(idFuncionario)
);

CREATE TABLE OCORRENCIA
(
	idOcorrencia INTEGER NOT NULL PRIMARY KEY,
	hora TIME NOT NULL,
	dataOcorr DATE NOT NULL,
	idComboio INTEGER NOT NULL,
	idItinerario INTEGER NOT NULL,
	FOREIGN KEY (idComboio) REFERENCES COMBOIO(idComboio),
	FOREIGN KEY (idItinerario) REFERENCES ITINERARIO(idItinerario)
);

CREATE TABLE COMBOIO
(
	idComboio INTEGER NOT NULL PRIMARY KEY,
	id INTEGER NOT NULL,
	tipo VARCHAR(50) NOT NULL
);

CREATE TABLE CARRUAGEM
(
	idCarruagem INTEGER NOT NULL PRIMARY KEY,
	nLugares INTEGER NOT NULL
);

CREATE TABLE BILHETE
(
	idBilhete INTEGER NOT NULL PRIMARY KEY,
	preco INTEGER NOT NULL,
	dataCompra DATE NOT NULL,
	idItinerario INTEGER NOT NULL,
	FOREIGN KEY (idItinerario) REFERENCES ITINERARIO(idItinerario)
);

CREATE TABLE PESSOA
(
	idPessoa INTEGER NOT NULL PRIMARY KEY,
	dataNascimento DATE NOT NULL,
	nome VARCHAR(50) NOT NULL,
	nif NUMBER(9,0) NOT NULL 
);

CREATE TABLE CLIENTE
(
	idCliente INTEGER NOT NULL PRIMARY KEY,
	desconto INTEGER,
	necessidadesEspeciais BOOLEAN,
	idBilhete INTEGER NOT NULL,
	FOREIGN KEY (idCliente) REFERENCES PESSOA(idPessoa),
	FOREIGN KEY (idBilhete) REFERENCES BILHETE(idBilhete)
);

CREATE TABLE FUNCIONARIO
(
	idFuncionario INTEGER NOT NULL PRIMARY KEY,
	anoEntrada DATE NOT NULL,
	salario INTEGER NOT NULL,
	idTipoDeFuncao INTEGER NOT NULL,
	FOREIGN KEY (idFuncionario)  REFERENCES PESSOA(idPessoa),
	FOREIGN KEY (idTipoDeFuncao) REFERENCES TIPODEFUNCAO(idTipoDeFuncao)
);

CREATE TABLE TIPODEFUNCAO
(
	idTipoDeFuncao INTEGER NOT NULL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL
);

CREATE TABLE ESTACAO
(
	idEstacao INTEGER NOT NULL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	idCidade INTEGER NOT NULL,
	FOREIGN KEY (idCidade) REFERENCES CIDADE(idCidade)
);

CREATE TABLE CIDADE
(
	idCidade INTEGER NOT NULL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL
);

CREATE TABLE ITINERARIO
(
	idItinerario INTEGER NOT NULL PRIMARY KEY,
	codigo INTEGER NOT NULL,
	nOcorrencias INTEGER NOT NULL
);

CREATE TABLE COMBOIOCARRUAGEM
(
	idComboio INTEGER NOT NULL,
	idCarruagem INTEGER NOT NULL,
	FOREIGN KEY (idComboio) REFERENCES COMBOIO(idComboio),
	FOREIGN KEY (idCarruagem) REFERENCES CARRUAGEM(idCarruagem),
	PRIMARY KEY (idComboio,idCarruagem)
);

CREATE TABLE ITINERARIOESTACAO
(
	ordem INTEGER NOT NULL,
	idEstacao INTEGER NOT NULL,
	idItinerario INTEGER NOT NULL,
	FOREIGN KEY (idEstacao) REFERENCES ESTACAO(idEstacao),
	FOREIGN KEY (idItinerario) REFERENCES ITINERARIO(idItinerario),
	PRIMARY KEY(ordem,idItinerario)
);

CREATE TABLE FUNCIONARIOESTACAO 
(
	idFuncionario INTEGER NOT NULL,
	idEstacao INTEGER NOT NULL,
	FOREIGN KEY (idFuncionario) REFERENCES FUNCIONARIO(idFuncionario),
	FOREIGN KEY (idEstacao) REFERENCES ESTACAO(idEstacao),
	PRIMARY KEY(idFuncionario,idEstacao)
);
