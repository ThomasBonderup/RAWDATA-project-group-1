-- GROUP: RAW1, MEMBERS: <Alex Tao Korsgaard Wogelius>, <Emilie Beske Unna-Lindhard>, <Nils Müllenborn>, <Thomas Winther Bonderup>
-- C.2 Creating tables for framework

CREATE SCHEMA framework_data_model;

SET search_path TO framework_data_model;

CREATE TABLE framework_data_model.user (
uconst CHARACTER(10),
firstName text,
lastName text,
email VARCHAR(50),
password VARCHAR(16),
username VARCHAR(15),
PRIMARY KEY (uconst)
);

ALTER TABLE framework_data_model.user OWNER TO postgres;

CREATE TABLE framework_data_model.search_history (
uconst CHARACTER(10),
timestamp TIMESTAMP,
search text,
PRIMARY key (uconst),
FOREIGN key (uconst) REFERENCES framework_data_model.user (uconst)
);

ALTER TABLE framework_data_model.search_history OWNER TO postgres;

CREATE TABLE framework_data_model.rating (
uconst CHARACTER(10),
tconst CHARACTER(10),
rating integer,
review text,
PRIMARY KEY (uconst, tconst),
FOREIGN	 KEY (uconst) REFERENCES framework_data_model.user (uconst),
FOREIGN KEY (tconst) REFERENCES movie_data_model.title (tconst)
);

ALTER TABLE framework_data_model.rating OWNER TO postgres;

CREATE TABLE framework_data_model.rating_history (
uconst CHARACTER(10),
tconst CHARACTER(10),
timestamp TIMESTAMP,
rating integer,
review text,
PRIMARY KEY (uconst, tconst, timestamp),
FOREIGN	 KEY (uconst) REFERENCES framework_data_model.user (uconst),
FOREIGN KEY (tconst) REFERENCES movie_data_model.title (tconst)
);

ALTER TABLE framework_data_model.rating_history OWNER TO postgres;

CREATE TABLE framework_data_model.title_notes (
uconst CHARACTER(10),
tconst CHARACTER(10),
notes text,
PRIMARY KEY (uconst, tconst),
FOREIGN	 KEY (uconst) REFERENCES framework_data_model.user (uconst),
FOREIGN KEY (tconst) REFERENCES movie_data_model.title (tconst)
);

ALTER TABLE framework_data_model.title_notes OWNER TO postgres;

CREATE TABLE framework_data_model.title_bookmark (
uconst CHARACTER(10),
tconst CHARACTER(10),
timestamp TIMESTAMP,
PRIMARY KEY (uconst, tconst),
FOREIGN	 KEY (uconst) REFERENCES framework_data_model.user (uconst),
FOREIGN KEY (tconst) REFERENCES movie_data_model.title (tconst)
);

ALTER TABLE framework_data_model.title_bookmark OWNER TO postgres;

CREATE TABLE framework_data_model.name_notes (
uconst CHARACTER(10),
nconst CHARACTER(10),
notes text,
PRIMARY KEY (uconst, nconst),
FOREIGN	 KEY (uconst) REFERENCES framework_data_model.user (uconst),
FOREIGN KEY (nconst) REFERENCES movie_data_model.name (nconst)
);

ALTER TABLE framework_data_model.name_notes OWNER TO postgres;

CREATE TABLE framework_data_model.name_bookmark (
uconst CHARACTER(10),
nconst CHARACTER(10),
timestamp TIMESTAMP,
PRIMARY KEY (uconst, nconst),
FOREIGN	 KEY (uconst) REFERENCES framework_data_model.user (uconst),
FOREIGN KEY (nconst) REFERENCES movie_data_model.name (nconst)
);

ALTER TABLE framework_data_model.name_bookmark OWNER TO postgres;
