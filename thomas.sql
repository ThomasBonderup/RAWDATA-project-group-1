-- D.2 Simple Search function
-- searching on primary title or plot for movie
-- search string is stored in search history as a side effect when function is called
-- returns table with tconst and primary title
DROP FUNCTION IF EXISTS string_search (search_string CHARACTER(50), uconst CHARACTER(10));

CREATE OR REPLACE FUNCTION string_search (search_string CHARACTER(50), uconst CHARACTER(10))

RETURNS TABLE (
  tconst CHARACTER(10),
  primarytitle text
)

LANGUAGE plpgsql
AS $$

BEGIN

-- stores search string in search history with timestamp
INSERT INTO search_history(uconst, timestamp, search)
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

-- D.2 Simple Search function test
SELECT * FROM string_search('Remake', 'ui000123');

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
  primarytitle text
)

LANGUAGE plpgsql
AS $$

BEGIN

-- stores search string in search history with timestamp
INSERT INTO search_history(uconst, timestamp, search)
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

-- D.4 Structured String Search function test
-- test case with lower and upper case characters including empty parameters
SELECT * FROM structured_string_search('', 'see', '', 'Mads miKKelsen', 'ui000123');

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
INSERT INTO search_history(uconst, timestamp, search)
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

-- D.5 actor_search function test
SELECT * FROM actor_search('Mads Mikkelsen', 'ui000123');

-- D.11 Exact-match Querying
CREATE OR REPLACE FUNCTION exact_match_search(title CHARACTER(50), plot CHARACTER(50), characters CHARACTER(50), name CHARACTER(50), uconst CHARACTER(10))

RETURNS TABLE (
  tconst CHARACTER(10),
  primarytitle text
) 

LANGUAGE plpgsql
AS $$

BEGIN

INSERT INTO search_history(uconst, timestamp, search)
VALUES(uconst, NOW(), CONCAT(title, plot, characters, name));
RETURN query SELECT t.tconst, t.primarytitle 
FROM title t,
(SELECT wi.tconst from wi where word = title
UNION
SELECT wi.tconst from wi where word = plot
UNION
SELECT wi.tconst from wi where word = characters
UNION
SELECT wi.tconst from wi where word = name) w
WHERE t.tconst = w.tconst;

END
$$;

SELECT * FROM exact_match_search('', 'see', '', 'Mads miKKelsen', 'ui000123');
