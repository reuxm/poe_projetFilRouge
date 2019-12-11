DROP DATABASE IF EXISTS poeFilRouge;

CREATE DATABASE poeFilRouge;

USE poeFilRouge;

CREATE TABLE Client (
	idClient INT
	PRIMARY KEY AUTO_INCREMENT,
	
	lastName VARCHAR(64) NOT NULL,
	firstName VARCHAR(64),
	adress VARCHAR(255),
	pc VARCHAR(5),
	town VARCHAR(64),
	phone VARCHAR(14)
);

CREATE TABLE Staff (
	idStaff INT
	PRIMARY KEY AUTO_INCREMENT,
	
	networkAccess VARCHAR(255)
);

CREATE TABLE Vehicule (
	model VARCHAR(64)
	PRIMARY KEY,
	
	uPrice INT,
	amountInStock INT NOT NULL
);

CREATE TABLE Role (
	roleName VARCHAR(16)
	PRIMARY KEY
);
INSERT INTO Role VALUES
	('Admin'),
	('Chef d\'atelier'),
	('Commercial'),
	('Magasinier'),
	('Mecanicien');
	
CREATE TABLE Fournisseur (
	numFournisseur INT
	PRIMARY KEY AUTO_INCREMENT,
	
	mail VARCHAR(64),
	phone VARCHAR(64),
	adress VARCHAR(255)
);
	
CREATE TABLE Devis (
	num INT
	PRIMARY KEY AUTO_INCREMENT,
	
	sum DECIMAL NOT NULL,
	designation TEXT NOT NULL,
	
	client INT NOT NULL,
	FOREIGN KEY(client) REFERENCES Client(idClient)
);

CREATE TABLE Facture (
	numBill INT
	PRIMARY KEY AUTO_INCREMENT,
	
	sum DECIMAL NOT NULL,
	tax DECIMAL NOT NULL,
	
	client INT NOT NULL,
	FOREIGN KEY (client) REFERENCES Client(idClient)
);

CREATE TABLE CommandeV (
	idOrder INT
	PRIMARY KEY AUTO_INCREMENT,
	
	bill INT,
	FOREIGN KEY (bill) REFERENCES Facture(numBill),
	
	client INT NOT NULL,
	FOREIGN KEY (client) REFERENCES Client(idClient)
);

CREATE TABLE CommandeP (
	idOrder INT
	PRIMARY KEY AUTO_INCREMENT,
	
	sum INT,
	
	fournisseur INT,
	FOREIGN KEY (fournisseur) REFERENCES Fournisseur(numFournisseur)
);

CREATE TABLE Form (
	idForm INT
	PRIMARY KEY AUTO_INCREMENT,
	
	open BOOLEAN NOT NULL,
	type ENUM('nettoyage', 'reparation', 'peinture'),
	description TEXT
);

CREATE TABLE Task (
	idTask INT
	PRIMARY KEY AUTO_INCREMENT,
	
	form INT,
	FOREIGN KEY (form) REFERENCES Form(idForm),
	
	creator INT,
	FOREIGN KEY (creator) REFERENCES Staff(idStaff),
	
	description TEXT,
	priorite ENUM('tres uregent', 'urgent', 'normal', 'pas prioritaire') NOT NULL
);

CREATE TABLE Piece (
	name VARCHAR(64)
	PRIMARY KEY,
	
	amoutInStock INT NOT NULL,
	alertTriggeringAlert INT
);

CREATE TABLE RoleStaff (
	role VARCHAR(16) NOT NULL,
	FOREIGN KEY (role) REFERENCES Role(roleName),
	
	staffMember INT NOT NULL,
	FOREIGN KEY (staffMember) REFERENCES Staff(idStaff),
	
	PRIMARY KEY(role, staffMember)
);

CREATE TABLE ClientStaff (
	staffMember INT NOT NULL,
	FOREIGN KEY (staffMember) REFERENCES Staff(idStaff),
	
	client INT NOT NULL,
	FOREIGN KEY (client) REFERENCES Client(idClient),
	
	PRIMARY KEY(staffMember, client),
	
	section ENUM('Atelier', 'Vente') NOT NULL,
	creation BOOLEAN NOT NULL,
	lastActiv DATE NOT NULL
);

CREATE TABLE CommandeVehicule (
	vOrder INT NOT NULL,
	FOREIGN KEY (vOrder) REFERENCES CommandeV(idOrder),
	
	car VARCHAR(64) NOT NULL,
	FOREIGN KEY (car) REFERENCES Vehicule(model),
	
	PRIMARY KEY(vOrder, car)
);

CREATE TABLE PiecesOrdered (
	pOrder INT NOT NULL,
	FOREIGN KEY (pOrder) REFERENCES CommandeP(idOrder),
	
	piece VARCHAR(64) NOT NULL,
	FOREIGN KEY (piece) REFERENCES Piece(name),
	
	PRIMARY KEY(pOrder, piece),
	
	qte INT NOT NULL
);
