Notes on script creation 

Private github repo created for code and script. 

Alex, Emilie and Nils create a github account and send me your account email, so I can invite you to the private github repo. Link to github: http://github.com/ 

# RAWDATA-project-group-1 
 
Step 1  
  
Download rawdata_small.backup  

Step 2  

Create or re-create imdb database  

psql -U postgres -C "create database imdb"  

psql -U postgres -d imdb -f rawdata_small.backup 

Step 3 + Step 4 

Create tables for The Movie Data Model 

 Insert / distribute data from imdb database into new tables 

DO loop to split values to complied 

CREATE tables 

ALTER new tables and give right to owner postgres 

Primary keys & foreigns keys 

Not null or other rules 

Delete on cascade, what happens when a title is deleted. Alex and Thomas talked about using delete on cascade effect to delete records from tables that depend on title. 

create table course 

    (course_id        varchar(8),  

     title            varchar(50) not null,  

     dept_name        varchar(20), 

     credits        numeric(2,0) check (credits > 0), 

     primary key (course_id), 

     foreign key (dept_name) references department (dept_name) 

        on delete set null 

    ); 

--
-- Name: title; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.title (
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
    primary key (tconst),
    foreign key () references . . . . . . . . . .
    on delete cascade..
);

ALTER TABLE public.title OWNER TO postgres;

--
-- Name: title_genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.title_genres {
    tconst character(10),
    genre character varying(20),
    foreign key (tconst) references title (tconst)
}

ALTER TABLE public.title_genres OWNER TO postgres;

--
-- Name: public.name; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.name (
    nconst character(10),
    primaryname character varying(256),
    birthyear character(4),
    deathyear character(4)
);

ALTER TABLE public.name OWNER TO postgres;

--
-- Name: title_principals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.title_principals (
    tconst character(10),
    ordering integer,
    nconst character(10),
    category character varying(50),
    job text,
    characters text,
    primary key (nconst, tconst),
    foreign key (nconst) references name (nconst),
    foreign key (tconst) references title (tconst)
);

ALTER TABLE public.title_principals OWNER TO postgres;

--
-- Name: public.primaryprofession; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.primaryprofession {
    nconst character(10),
    profession character varying(20),
    foreign key (nconst) references name (nconst)
}

ALTER TABLE public.primaryprofession OWNER TO postgres;

--
-- Name: public.knownfortitles; Type: TABLE; Schema: public; Owner: postgres
-- Change diagram
--

CREATE TABLE public.knownfortitles {
    nconst character(10),
    tconst character(10),   
    primary key (nconst, tconst),
    foreign key (nconst, tconst) references title_principals (nconst, tconst)
}

ALTER TABLE public.knownfortitles OWNER TO postgres;

--
-- Name: local_title; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.local_title (
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

ALTER TABLE public.local_title OWNER TO postgres;

--
-- Name: title_episode; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.title_episode (
    tconst character(10),
    parenttconst character(10),
    seasonnumber integer,
    episodenumber integer
    primary key(tconst, parenttconst),
    foreign key (tconst, parenttconst) references title (tconst)
);

ALTER TABLE public.title_episode OWNER TO postgres;

--
-- Name: title_ratings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.title_ratings (
    tconst character(10),
    averagerating numeric(5,1),
    numvotes integer
    primary key(tconst),
    foreign key (tconst) references title (tconst)
);

ALTER TABLE public.title_ratings OWNER TO postgres;

--
-- Name: wi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wi (
    tconst character(10) NOT NULL,
    word text NOT NULL,
    field character(1) NOT NULL,
    lexeme text
    primary key(tconst, word, field),
    foreign key (tconst) references title (tconst)
);


ALTER TABLE public.wi OWNER TO postgres;

Insert 

insert into course values ('CS-347', 'Database System Concepts', 'Comp. Sci.', '3');  

psql -U postgres -C "create database movie_data"  

psql -U postgres -d movie_data -f B2_build_movie_db.sql 

Thomas and Alex have broken the process of table creation and data-migration into 4 steps,  