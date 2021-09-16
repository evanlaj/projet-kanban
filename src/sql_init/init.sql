DROP TABLE IF EXISTS acces;
DROP TABLE IF EXISTS tache;
DROP TABLE IF EXISTS colonne;
DROP TABLE IF EXISTS projet;
DROP TABLE IF EXISTS utilisateur;

CREATE TABLE utilisateur (
	nom VARCHAR(16) NOT NULL PRIMARY KEY,
	mdp VARCHAR(255) NOT NULL
);

CREATE TABLE projet (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	nom VARCHAR(32) NOT NULL,
	public BOOLEAN NOT NULL DEFAULT 0,
	proprietaire VARCHAR(16),
	date_creation DATETIME,
	derniere_maj DATETIME,
	FOREIGN KEY (proprietaire) REFERENCES utilisateur(nom) ON DELETE CASCADE
);

CREATE TABLE colonne (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	projet INT NOT NULL,
	nom VARCHAR(32) NOT NULL,
	position INT NOT NULL,
	FOREIGN KEY (projet) REFERENCES projet(id) ON DELETE CASCADE,
	UNIQUE (projet, nom),
	UNIQUE (projet, position)

);

CREATE TABLE tache (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	projet INT NOT NULL,
	affectation VARCHAR(16) DEFAULT NULL,
	description TEXT NOT NULL,
	date_limite DATETIME,
	colonne INT NOT NULL DEFAULT 0,
	FOREIGN KEY (projet) REFERENCES projet(id) ON DELETE CASCADE,
	FOREIGN KEY (affectation) REFERENCES utilisateur(nom) ON DELETE SET NULL
);

CREATE TABLE acces (
	utilisateur VARCHAR(16) NOT NULL,
	projet INT NOT NULL,
	PRIMARY KEY (utilisateur, projet),
	FOREIGN KEY (utilisateur) REFERENCES utilisateur(nom) ON DELETE CASCADE,
	FOREIGN KEY (projet) REFERENCES projet(id) ON DELETE CASCADE
);
