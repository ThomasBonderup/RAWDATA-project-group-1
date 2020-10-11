-- GROUP: RAW1, MEMBERS: <Alex Tao Korsgaard Wogelius>, <Emilie Beske Unna-Lindhard>, <Nils Müllenborn>, <Thomas Winther Bonderup>

-- code script to create function and procedures

SET search_path TO movie_data_model;

-- D.1

-- D.2 Simple Search function
-- searching on primary title or plot for movie
-- search string is stored in search history as a side effect when function is called
-- returns table with tconst and primary title
DROP FUNCTION IF EXISTS string_search (search_string CHARACTER(50), uconst CHARACTER(10));

CREATE OR REPLACE FUNCTION string_search (search_string CHARACTER(50), uconst CHARACTER(10))

RETURNS TABLE (
  tconst CHARACTER(10),
  primarytitle TEXT
)

LANGUAGE plpgsql
AS $$

BEGIN

-- stores search string in search history with timestamp
INSERT INTO search_history(uconst, tstamp, search)
VALUES(uconst, NOW(), search_string);

-- returns table by using ILIKE for string pattern matching
-- ILIKE is used to pattern match and lower and upper case characters
-- % matches sequences of zero or more characters
-- || is used for string concatenation
RETURN query SELECT t.tconst, t.primarytitle
FROM title t
WHERE t.primarytitle ILIKE '%'||search_string||'%' OR t.plot ILIKE '%'||search_string||'%';

END
$$;

-- D.3




-- D.4 Structured String Search function
-- searching with 4 parameters title, plot, characters, name and uconst for more precise search queries on title
-- search string is stored in search history as a side effect when function is called
-- returns table with tconst and primary title
DROP FUNCTION IF EXISTS structured_string_search(title CHARACTER(50), plot CHARACTER(50), characters CHARACTER(50),name CHARACTER(50), uconst CHARACTER(10));

CREATE OR REPLACE FUNCTION structured_string_search(title CHARACTER(50),
						    plot CHARACTER(50),
						    characters CHARACTER(50),
       	  	  	   			    name CHARACTER(50),
						    uconst CHARACTER(10))

RETURNS TABLE (
  tconst CHARACTER(10),
  primarytitle TEXT
)

LANGUAGE plpgsql
AS $$

BEGIN

-- stores search string in search history with timestamp
INSERT INTO search_history(uconst, tstamp, search)
VALUES(uconst, NOW(), CONCAT(title, plot, characters, name));

-- returns table by using ILIKE for string pattern matching
-- ILIKE is used to pattern match and lower and upper case characters
-- % matches sequences of zero or more characters
-- || is used for string concatenation
RETURN query SELECT title.tconst, title.primarytitle
FROM title NATURAL JOIN title_principals NATURAL JOIN name
WHERE title.primarytitle 	       ILIKE '%'||structured_string_search.title||'%'
AND   title.plot		       ILIKE '%'||structured_string_search.plot||'%'
AND   title_principals.characters      ILIKE '%'||structured_string_search.characters||'%'
AND   name.primaryname 		       ILIKE '%'||structured_string_search.name||'%';
END
$$;

-- D.5 actor_search function
-- searching on primary name of actor or character
-- search string is stored in search history as a side effect when function is called
-- returns table with nconst and primary name
DROP FUNCTION IF EXISTS actor_search(string CHARACTER(50), uconst CHARACTER(10));

CREATE OR REPLACE FUNCTION actor_search(string CHARACTER(50), uconst CHARACTER(10))

RETURNS TABLE (
  nconst CHARACTER(10),
  primaryname VARCHAR(256)
)

LANGUAGE plpgsql
AS $$

BEGIN

-- stores search string in search history with timestamp
INSERT INTO search_history(uconst, tstamp, search)
VALUES(uconst, NOW(), string);

-- returns table by using ILIKE for string pattern matching
-- ILIKE is used to pattern match and lower and upper case characters
-- % matches sequences of zero or more characters
-- || is used for string concatenation
RETURN query SELECT name.nconst, name.primaryname
FROM name NATURAL JOIN title_principals
WHERE name.primaryname ILIKE '%'||string||'%' OR title_principals.characters ILIKE '%'||string||'%';

END
$$;

-- D.6

-- D.7

-- D.8

-- D.9

-- D.10

-- D.11 Exact-match Querying
-- function returns a list of titles matching 3 intersecting keywords
DROP FUNCTION IF EXISTS exact_match_search(w1 CHARACTER(50), w2 CHARACTER(50), w3 CHARACTER(50));
CREATE OR REPLACE FUNCTION exact_match_search(w1 CHARACTER(50), w2 CHARACTER(50), w3 CHARACTER(50), uconst CHARACTER(10))

RETURNS TABLE (
  tconst CHARACTER(10),
  primarytitle TEXT
)

LANGUAGE plpgsql
AS $$

BEGIN

-- stores search string in search history with timestamp
INSERT INTO search_history(uconst, tstamp, search)
VALUES(uconst, NOW(), CONCAT(w1, w2, w3));

-- using the inverted index wi
RETURN query SELECT t.tconst, t.primarytitle
FROM title t,
(SELECT wi.tconst FROM wi WHERE word = w1
INTERSECT
SELECT wi.tconst FROM wi WHERE word = w2
INTERSECT
SELECT wi.tconst FROM wi WHERE word = w3
) w
WHERE t.tconst = w.tconst;

END
$$;

-- D.12 Best-match Querying
-- dynamic function using VARIADIC array for multiple input parameters
-- to build and execute a SQL-expression
DROP FUNCTION IF EXISTS dynamic_bestmatch(VARIADIC w text[]);

CREATE OR REPLACE FUNCTION dynamic_bestmatch(VARIADIC w text[])

RETURNS TABLE (
  tconst CHARACTER(10),
  rank BIGINT,
  title TEXT
)

LANGUAGE plpgsql
AS $$

DECLARE
  w_elem TEXT;
  q_start TEXT := 'SELECT t.tconst, SUM(relevance) RANK, primarytitle FROM title t, ( ';
  q_end TEXT := ') w WHERE t.tconst = w.tconst GROUP BY t.tconst, primarytitle ORDER BY RANK DESC';
  q_result TEXT;
BEGIN

-- using foreach loop to concatenate input parameters to SQL-expression q_start
FOREACH w_elem IN ARRAY w
LOOP
q_start := q_start || 'SELECT distinct wi.tconst, 1 relevance FROM wi WHERE word = '''|| w_elem ||''' UNION ALL ';
END LOOP;

-- use substring method to remove the last UNION ALL when building the query
q_start := SUBSTRING(q_start, 1, LENGTH(q_start)-10);
-- concatenate q_start and q_end into final query
q_result := q_start || q_end;
RETURN QUERY EXECUTE q_result;

END
$$;

-- D.13
-- no solution
-- D.14
-- no solution
-- D.15
-- no solution
