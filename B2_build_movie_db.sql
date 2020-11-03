-- GROUP: RAW1, MEMBERS: <Alex Tao Korsgaard Wogelius>, <Emilie Beske Unna-Lindhard>, <Nils Müllenborn>, <Thomas Winther Bonderup>
--
-- B.2 Creating tables
--

--
-- fix db build issue
--

-- remove p_key violations from title_basic
-- create temporary table for storing duplicates
create TABLE public.tmpFix (
tconst char(10),
titletype varchar(20),
primarytitle text,
originaltitle text,
isadult bool,
startyear char(4),
endyear char(4),
runtimeminutes int4,
genres varchar(256));
-- insert duplicates into temporary table
INSERT INTO public.tmpFix
SELECT tconst, titletype, primarytitle, originaltitle, isadult, startyear, endyear, runtimeminutes, genres
FROM public.title_basics
GROUP BY tconst, titletype, primarytitle, originaltitle, isadult, startyear, endyear, runtimeminutes, genres
HAVING count(*) > 1;
-- delete all entries in title_basics with duplicates
DELETE from public.title_basics where tconst in (SELECT tconst from public.tmpFix);
-- re-insert rows now without duplicates from temporary table
INSERT INTO public.title_basics
SELECT *
from public.tmpFix;
-- drop temporary table
drop TABLE public.tmpFix;



-- remove p_key violations from title_episode
-- create temporary table for storing duplicates
create TABLE public.tmpFix (
tconst char(10),
parenttconst char(10),
seasonnumber int4,
episodenumber int4);
-- insert duplicates into temporary table
INSERT INTO public.tmpFix
SELECT tconst, parenttconst, seasonnumber, episodenumber
FROM public.title_episode
GROUP BY tconst, parenttconst, seasonnumber, episodenumber
HAVING count(*) > 1;
-- delete all entries in title_episode with duplicates
DELETE from public.title_episode where tconst in (SELECT tconst from public.tmpFix);
-- re-insert rows now without duplicates from temporary table
INSERT INTO public.title_episode
SELECT *
from public.tmpFix;
-- drop temporary table
drop TABLE public.tmpFix;



-- remove p_key violations from title_ratings
-- create temporary table for storing duplicates
create TABLE public.tmpFix (
tconst char(10),
averagerating numeric(5,1),
numvotes int4);
-- insert duplicates into temporary table
INSERT INTO public.tmpFix
SELECT  tconst, averagerating, numvotes
FROM public.title_ratings
GROUP BY  tconst, averagerating, numvotes
HAVING count(*) > 1;
-- delete all entries in title_ratings with duplicates
DELETE from public.title_ratings where tconst in (SELECT tconst from public.tmpFix);
-- re-insert rows now without duplicates from temporary table
INSERT INTO public.title_ratings
SELECT *
from public.tmpFix;
-- drop temporary table
drop TABLE public.tmpFix;


-- remove p_key violations from omdb_data
-- create temporary table for storing duplicates
create TABLE public.tmpFix (
tconst text,
poster text,
awards text,
plot text);
-- insert duplicates into temporary table
INSERT INTO public.tmpFix
SELECT tconst, poster, awards, plot
FROM public.omdb_data
GROUP BY tconst, poster, awards, plot
HAVING count(*) >1;
-- delete all entries in omdb_data with duplicates
DELETE from public.omdb_data where tconst in (SELECT tconst from public.tmpFix);
-- re-insert rows now without duplicates from temporary table
INSERT INTO public.omdb_data
SELECT *
from public.tmpFix;
-- drop temporary table
drop TABLE public.tmpFix;

-- remove f_key violations from title_basic
Delete from public.title_principals tp
where not exists (
  select null
  from public.name_basics nb
  where tp.nconst = nb.nconst
);
-- remove p_key violations from title_principals
-- create temporary table for storing duplicates
create TABLE public.tmpFix (
tconst char(10),
ordering int4,
nconst char(10),
category varchar(50),
job text,
characters text
);
-- insert duplicates into temporary table
INSERT INTO public.tmpFix
SELECT tconst, ordering, nconst, category, job, characters
FROM public.title_principals
GROUP BY tconst, ordering, nconst, category, job, characters
HAVING count(*) > 1;
-- delete all entries in title_principals with duplicates
DELETE from public.title_principals where tconst in (SELECT tconst from public.tmpFix);
-- re-insert rows now without duplicates from temporary table
INSERT INTO public.title_principals
SELECT *
from public.tmpFix;
-- drop temporary table
drop TABLE public.tmpFix;





DROP SCHEMA IF EXISTS movie_data_model CASCADE;

CREATE SCHEMA movie_data_model;

SET search_path TO movie_data_model;

--
-- Name: title; Type: TABLE; Schema: public; Owner: postgres
--

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
    primary key (nconst, tconst, ordering),
    foreign key (tconst) references title (tconst),
    foreign key (nconst) references name (nconst)
);

ALTER TABLE movie_data_model.title_principals OWNER TO postgres;

--
-- Name: movie_data_model.primaryprofession; Type: TABLE; Schema: movie_data_model; Owner: postgres
--

CREATE TABLE movie_data_model.primaryprofession (
    nconst character(20),
    profession character varying(30),
    primary key (nconst, profession),
    foreign key (nconst) references name (nconst)
);

ALTER TABLE movie_data_model.primaryprofession OWNER TO postgres;

--
-- Name: movie_data_model.knownfortitles; Type: TABLE; Schema: movie_data_model; Owner: postgres
-- DEFAULT VALUE
--

CREATE TABLE movie_data_model.knownfortitles (
    nconst character(10),
    tconst character(10),
    primary key (nconst, tconst),
    foreign key (nconst) references name (nconst),
    foreign key (tconst) references title (tconst)
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
    primary key(titleid, ordering, region),
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

CREATE TABLE movie_data_model.title_ratings (
    tconst character(10),
    averagerating numeric(5,1),
    numvotes integer,
    weightedaverage numeric(5,1),
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
SELECT tconst, titletype, primarytitle, originaltitle, isadult, startyear, endyear, runtimeminutes, poster, awards, plot
FROM public.title_basics NATURAL LEFT OUTER JOIN public.omdb_data;

INSERT INTO movie_data_model.title_genres
SELECT tconst, regexp_split_to_table(genres, E',') AS genre
FROM public.title_basics;

INSERT INTO movie_data_model.title_episode
SELECT tconst, parenttconst, seasonnumber, episodenumber
FROM public.title_episode;

INSERT INTO movie_data_model.title_ratings
SELECT tconst, averagerating, numvotes
FROM public.title_ratings;

UPDATE movie_data_model.title_ratings
SET weightedaverage = (((movie_data_model.title_ratings.averagerating * movie_data_model.title_ratings.numvotes) + (7.0 * 25000)) / (movie_data_model.title_ratings.numvotes + 25000));

INSERT INTO movie_data_model.wi
SELECT tconst, word, field, lexeme
FROM public.wi;

INSERT INTO movie_data_model.local_title
SELECT DISTINCT titleid, ordering, title, region, language, types, attributes, isoriginaltitle
FROM public.title_akas;

INSERT INTO movie_data_model.title_principals
SELECT tconst, nconst, ordering, category, job, characters
FROM public.title_principals;

INSERT INTO movie_data_model.primaryprofession
SELECT DISTINCT nconst, regexp_split_to_table(primaryprofession, E',') AS profession
FROM public.name_basics;

CREATE TABLE movie_data_model.knownfortitles_temp (
    knownfortitles character varying(256),
    nconst character varying(256)
);

INSERT INTO movie_data_model.knownfortitles_temp
SELECT regexp_split_to_table(knownfortitles, E',') AS knownfortitles, nconst
FROM public.name_basics;

INSERT INTO movie_data_model.knownfortitles
SELECT movie_data_model.knownfortitles_temp.nconst, movie_data_model.knownfortitles_temp.knownfortitles AS tconst
FROM movie_data_model.knownfortitles_temp
WHERE movie_data_model.knownfortitles_temp.knownfortitles IN (SELECT tconst FROM title);

DROP TABLE movie_data_model.knownfortitles_temp;

DROP SCHEMA IF EXISTS public CASCADE;
