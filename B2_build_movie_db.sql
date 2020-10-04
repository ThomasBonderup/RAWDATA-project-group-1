-- GROUP: RAW1, MEMBERS: <Alex Tao Korsgaard Wogelius>, <Emilie Beske Unna-Lindhard>, <Nils Müllenborn>, <Thomas Winther Bonderup>
--
-- B.2 Creating tables
--

--
-- Name: title; Type: TABLE; Schema: public; Owner: postgres
--

CREATE SCHEMA movie_data_model;

SET search_path TO movie_data_model;

CREATE TABLE movie_data_model.title (
    tconst character(10),
    titletype character varying(20),
    primarytitle text,
    originaltitle text,
    isadult boolean,
    startyear character(4),
    endyear character(4),
    runtimeminutes integer,
    poster character varying(256),
    awards text,
    plot text,
    primary key (tconst)   
);

ALTER TABLE movie_data_model.title OWNER TO postgres;

--
-- Name: title_genres; Type: TABLE; Schema: movie_data_model; Owner: postgres
--

CREATE TABLE movie_data_model.title_genres (
    tconst character(10),
    genre character varying(20),
    primary key (tconst, genre),
    foreign key (tconst) references title (tconst)
);

ALTER TABLE movie_data_model.title_genres OWNER TO postgres;

--
-- Name: movie_data_model.name; Type: TABLE; Schema: movie_data_model; Owner: postgres
--

CREATE TABLE movie_data_model.name (
    nconst character(10),
    primaryname character varying(256),
    birthyear character(4),
    deathyear character(4),
    primary key (nconst)
);

ALTER TABLE movie_data_model.name OWNER TO postgres;

--
-- Name: title_principals; Type: TABLE; Schema: movie_data_model; Owner: postgres
--

CREATE TABLE movie_data_model.title_principals (
    tconst character(10),
    nconst character(10),
    ordering integer,
    category character varying(50),
    job text,
    characters text,
    primary key (nconst, tconst),
    foreign key (nconst) references name (nconst),
    foreign key (tconst) references title (tconst)
);

ALTER TABLE movie_data_model.title_principals OWNER TO postgres;

--
-- Name: movie_data_model.primaryprofession; Type: TABLE; Schema: movie_data_model; Owner: postgres
--

CREATE TABLE movie_data_model.primaryprofession (
    nconst character(10),
    profession character varying(20),
    primary key (nconst, profession),
    foreign key (nconst) references name (nconst)
);

ALTER TABLE movie_data_model.primaryprofession OWNER TO postgres;

--
-- Name: movie_data_model.knownfortitles; Type: TABLE; Schema: movie_data_model; Owner: postgres
-- 
--

CREATE TABLE movie_data_model.knownfortitles (
    nconst character(10),
    tconst character(10),   
    primary key (nconst, tconst),
    foreign key (nconst, tconst) references title_principals (nconst, tconst)
);

ALTER TABLE movie_data_model.knownfortitles OWNER TO postgres;

--
-- Name: local_title; Type: TABLE; Schema: movie_data_model; Owner: postgres
--

CREATE TABLE movie_data_model.local_title (
    titleid character(10),
    ordering integer,
    title text,
    region character varying(10),
    language character varying(10),
    types character varying(256),
    attributes character varying(256),
    isoriginaltitle boolean,
    primary key(titleid),
    foreign key (titleid) references title (tconst)
);

ALTER TABLE movie_data_model.local_title OWNER TO postgres;

--
-- Name: title_episode; Type: TABLE; Schema: movie_data_model; Owner: postgres
--

CREATE TABLE movie_data_model.title_episode (
    tconst character(10),
    parenttconst character(10),
    seasonnumber integer,
    episodenumber integer,
    primary key(tconst, parenttconst),
    foreign key (tconst) references title (tconst),
    foreign key (parenttconst) references title (tconst)
);

ALTER TABLE movie_data_model.title_episode OWNER TO postgres;

--
-- Name: title_ratings; Type: TABLE; Schema: movie_data_model; Owner: postgres
--

CREATE TABLE movie_data_miiodel.title_ratings (
    tconst character(10),
    averagerating numeric(5,1),
    numvotes integer,
    primary key(tconst),
    foreign key (tconst) references title (tconst)
);

ALTER TABLE movie_data_model.title_ratings OWNER TO postgres;

--
-- Name: wi; Type: TABLE; Schema: movie_data_model; Owner: postgres
--

CREATE TABLE movie_data_model.wi (
    tconst character(10) NOT NULL,
    word text NOT NULL,
    field character(1) NOT NULL,
    lexeme text,
    primary key(tconst, word, field),
    foreign key (tconst) references title (tconst)
);

ALTER TABLE movie_data_model.wi OWNER TO postgres;

--
-- Distributing data
--

INSERT INTO movie_data_model.name
SELECT DISTINCT nconst, primaryname, birthyear, deathyear FROM public.name_basics;

INSERT INTO movie_data_model.title
SELECT tconst, titletype, primarytitle, originaltitle, isadult, startyear, endyear, runtimeminutes
FROM public.title_basics;

INSERT INTO movie_data_model.title_genres
SELECT tconst, regexp_split_to_table(genres, E',') AS genre
FROM public.title_basics;

