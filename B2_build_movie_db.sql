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
