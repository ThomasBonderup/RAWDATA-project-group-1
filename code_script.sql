-- GROUP: RAW1, MEMBERS: <Alex Tao Korsgaard Wogelius>, <Emilie Beske Unna-Lindhard>, <Nils Müllenborn>, <Thomas Winther Bonderup>

-- code script to create function and procedures

SET search_path TO movie_data_model;

-- D.1
----------------------------------------- user functions
-- add new user
CREATE OR REPLACE FUNCTION add_user (
uconst CHARACTER(10),
firstname text,
lastname text,
email VARCHAR(50),
password VARCHAR(16),
username VARCHAR(15)) RETURNS void AS $$
BEGIN
insert into movie_data_model.user
values (uconst, firstname, lastname, email,  password, username);
END;
$$ LANGUAGE plpgsql;

-- update user
CREATE OR REPLACE FUNCTION update_user (
uconst CHARACTER(10),
firstname text,
lastname text,
email VARCHAR(50),
password VARCHAR(16),
username VARCHAR(15)) RETURNS void AS $$
BEGIN
UPDATE movie_data_model.user
set firstname = update_user.firstname,
		lastname = update_user.lastname,
		email = update_user.email,
		password = update_user.password,
		username = update_user.username
		WHERE movie_data_model.user.uconst = update_user.uconst;
END;
$$ LANGUAGE plpgsql;

-- delete user
CREATE OR REPLACE FUNCTION delete_user (uconst CHARACTER(10)) RETURNS void AS $$
BEGIN
DELETE FROM movie_data_model.user
WHERE movie_data_model.user.uconst = delete_user.uconst;
END;
$$ LANGUAGE plpgsql;

----------------------------------------- bookmarks functions
-- add title bookmark
CREATE OR REPLACE FUNCTION add_title_bookmark (uconst CHARACTER(10), tconst CHARACTER(10)) RETURNS void AS $$
BEGIN
insert into movie_data_model.title_bookmark
values (uconst, tconst, now());
END;
$$ LANGUAGE plpgsql;

-- add name bookmark
CREATE OR REPLACE FUNCTION add_name_bookmark (uconst CHARACTER(10), nconst CHARACTER(10)) RETURNS void AS $$
BEGIN
insert into movie_data_model.name_bookmark
values (uconst, nconst, now());
END;
$$ LANGUAGE plpgsql;

-- delete title bookmark
CREATE OR REPLACE FUNCTION delete_title_bookmark (uconst CHARACTER(10), tconst CHARACTER(10)) RETURNS void AS $$
BEGIN
DELETE FROM movie_data_model.title_bookmark
WHERE movie_data_model.title_bookmark.uconst = delete_title_bookmark.uconst AND movie_data_model.title_bookmark.tconst = delete_title_bookmark.tconst;
END;
$$ LANGUAGE plpgsql;

-- delete name bookmark
CREATE OR REPLACE FUNCTION delete_name_bookmark (uconst CHARACTER(10), nconst CHARACTER(10)) RETURNS void AS $$
BEGIN
DELETE FROM movie_data_model.name_bookmark
WHERE movie_data_model.name_bookmark.uconst = delete_name_bookmark.uconst AND movie_data_model.name_bookmark.nconst = delete_name_bookmark.nconst;
END;
$$ LANGUAGE plpgsql;

-- getbookmarks name
create or replace function get_name_bookmarks (usern CHARACTER(10))
returns table (
  uconst char(10),
  nconst char(10)
)
language plpgsql
as $$
begin
return query select t.uconst, t.nconst
from name_bookmark t
where t.uconst = usern;
end;
$$;

-- getbookmarks title
create or replace function get_title_bookmarks (titlen CHARACTER(10))
returns table (
  uconst char(10),
  tconst char(10)
)
language plpgsql
as $$
begin
return query select t.uconst, t.tconst
from title_bookmark t
where t.uconst = titlen;
end;
$$;

----------------------------------------- note functions
-- add title note
CREATE OR REPLACE FUNCTION add_title_notes (uconst CHARACTER(10), tconst CHARACTER(10), notes text) RETURNS void AS $$
BEGIN
insert into movie_data_model.title_notes
values (uconst, tconst, notes);
END;
$$ LANGUAGE plpgsql;

-- add name note
CREATE OR REPLACE FUNCTION add_name_notes (uconst CHARACTER(10), nconst CHARACTER(10), notes text) RETURNS void AS $$
BEGIN
insert into movie_data_model.name_notes
values (uconst, nconst, notes);
END;
$$ LANGUAGE plpgsql;

-- update title note
CREATE OR REPLACE FUNCTION update_title_notes (
uconst CHARACTER(10), tconst CHARACTER(10), notes text) RETURNS void AS $$
BEGIN
UPDATE movie_data_model.title_notes
set	notes = update_title_notes.notes
WHERE movie_data_model.title_notes.uconst = update_title_notes.uconst AND movie_data_model.title_notes.tconst = update_title_notes.tconst;
END;
$$ LANGUAGE plpgsql;

-- update name note
CREATE OR REPLACE FUNCTION update_name_notes (
uconst CHARACTER(10), nconst CHARACTER(10), notes text) RETURNS void AS $$
BEGIN
UPDATE movie_data_model.name_notes
set	notes = update_name_notes.notes
WHERE movie_data_model.name_notes.uconst = update_name_notes.uconst AND movie_data_model.name_notes.nconst = update_name_notes.nconst;
END;
$$ LANGUAGE plpgsql;

-- delete title note
CREATE OR REPLACE FUNCTION delete_title_notes (uconst CHARACTER(10), tconst CHARACTER(10)) RETURNS void AS $$
BEGIN
DELETE FROM movie_data_model.title_notes
WHERE movie_data_model.title_notes.uconst = delete_title_notes.uconst AND movie_data_model.title_notes.tconst = delete_title_notes.tconst;
END;
$$ LANGUAGE plpgsql;

-- delete name note
CREATE OR REPLACE FUNCTION delete_name_notes (uconst CHARACTER(10), nconst CHARACTER(10)) RETURNS void AS $$
BEGIN
DELETE FROM movie_data_model.name_notes
WHERE movie_data_model.name_notes.uconst = delete_name_notes.uconst AND movie_data_model.name_notes.nconst = delete_name_notes.nconst;
END;
$$ LANGUAGE plpgsql;

-- getnotes name
create or replace function get_name_notes (usern CHARACTER(10))
returns table (
  uconst char(10),
  nconst char(10),
	notes text
)
language plpgsql
as $$
begin
return query select t.uconst, t.nconst, t.notes
from name_notes t
where t.uconst = usern;
end;
$$;

-- getnotes title
create or replace function get_title_notes (titlen CHARACTER(10))
returns table (
  uconst char(10),
  tconst char(10),
	notes text
)
language plpgsql
as $$
begin
return query select t.uconst, t.tconst, t.notes
from title_notes t
where t.uconst = titlen;
end;
$$;

-- get search history
create or replace function get_search_history (usr CHARACTER(10))
returns table (
uconst char(10),
tstamp TIMESTAMP,
search text
)
LANGUAGE plpgsql
as $$
BEGIN
return query SELECT t.uconst, t.tstamp, t.search
from search_history t
where t.uconst = get_search_history.usr;
end;
$$;

-- get rating history
create or replace function get_rating_history (usr CHARACTER(10))
returns table (
uconst CHARACTER(10),
tconst CHARACTER(10),
tstamp TIMESTAMP,
rating integer,
review text
)
LANGUAGE plpgsql
as $$
BEGIN
return query SELECT t.uconst, t.tconst, t.tstamp, t.rating, t.review
from rating_history t
where t.uconst = get_rating_history.usr;
end;
$$;


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
-- Insert user rating
CREATE OR REPLACE FUNCTION ins_user_rating(user_id CHARACTER(10), movie_id CHARACTER(10), movie_rating INTEGER)
RETURNS void LANGUAGE plpgsql AS $$
BEGIN

INSERT INTO
rating (uconst, tconst, rating, review)

VALUES (user_id,
movie_id,
movie_rating,
'N/A');

RAISE NOTICE 'Insert complete';

END $$;

-- Insert user rating - overloaded
CREATE OR REPLACE FUNCTION ins_user_rating(user_id CHARACTER(10), movie_id CHARACTER(10), movie_rating INTEGER, movie_review TEXT)
RETURNS void LANGUAGE plpgsql AS $$
BEGIN

INSERT INTO
rating (uconst, tconst, rating, review)

VALUES (user_id,
movie_id,
movie_rating,
movie_review);

RAISE NOTICE 'Insert complete';

END $$;


-- Update user rating
CREATE OR REPLACE FUNCTION upd_user_rating(user_id CHARACTER(10), movie_id CHARACTER(10), movie_rating INTEGER)
RETURNS void LANGUAGE plpgsql AS $$
BEGIN

UPDATE rating
SET uconst = user_id,
tconst = movie_id,
rating = movie_rating,
review = OLD.review
WHERE uconst = user_id AND tconst = movie_id;

RAISE NOTICE 'Update complete';

END $$;


-- Update user rating - overloaded
CREATE OR REPLACE FUNCTION upd_user_rating(user_id CHARACTER(10), movie_id CHARACTER(10), movie_rating INTEGER, movie_review TEXT)
RETURNS void LANGUAGE plpgsql AS $$
BEGIN

UPDATE rating
SET uconst = user_id,
tconst = movie_id,
rating = movie_rating,
review = movie_review
WHERE uconst = user_id AND tconst = movie_id;

RAISE NOTICE 'Update complete';

END $$;

-- UPDATE RATING HISTORY - TRIGGER

CREATE OR REPLACE FUNCTION update_rating_history()
RETURNS TRIGGER LANGUAGE plpgsql AS $$

BEGIN

INSERT INTO rating_history(uconst, tconst, tstamp, rating, review)
VALUES (NEW.uconst, NEW.tconst, NOW(), NEW.rating, NEW.review);

RETURN NEW;
END; $$


CREATE TRIGGER insert_rating_history
AFTER INSERT OR UPDATE ON rating
FOR EACH ROW
EXECUTE PROCEDURE update_rating_history();

-- UPDATE AVERAGE RATING

CREATE OR REPLACE FUNCTION update_avrg_rating()
RETURNS TRIGGER LANGUAGE plpgsql AS $$

BEGIN

IF EXISTS(SELECT *
FROM rating
WHERE OLD.uconst = NEW.uconst)
AND EXISTS(SELECT *
FROM rating
WHERE OLD.tconst = NEW.tconst)
THEN
RAISE NOTICE 'Value already exists.. .. .. proceeding';

UPDATE title_ratings
SET averagerating = (averagerating * numvotes - OLD.rating) / (numvotes - 1),
numvotes = numvotes - 1
WHERE tconst = NEW.tconst;

RAISE NOTICE 'Value subtracted from average';

END IF;

UPDATE title_ratings
SET numvotes = numvotes + 1,
averagerating = (averagerating) + ((NEW.rating - averagerating) / numvotes)
WHERE tconst = NEW.tconst;

RAISE NOTICE 'Average updated';

UPDATE title_ratings
SET weightedaverage = (((title_ratings.averagerating * title_ratings.numvotes) + (7.0 * 25000)) / (title_ratings.numvotes + 25000));

RAISE NOTICE 'Weighted Average updated';

RETURN NEW;
END; $$

CREATE TRIGGER upd_avrg_rating_trigger
AFTER INSERT OR UPDATE ON rating
FOR EACH ROW
EXECUTE PROCEDURE update_avrg_rating();





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
create or replace function generate_name_ratings() RETURNS TRIGGER LANGUAGE plpgsql AS $$
begin

create or replace view casting as
select tconst, primarytitle, nconst, primaryname from title natural join title_principals natural join name;

UPDATE name_rating
SET rating = t.rating
from ( select nconst, sum(averagerating*numvotes)/sum(numvotes) as rating
from casting natural join title_ratings
GROUP BY casting.nconst) as t

where t.nconst = name_rating.nconst;
RETURN NEW;
END; $$;

CREATE TRIGGER upd_name_rating_trigger
AFTER INSERT OR UPDATE ON rating
FOR EACH ROW
EXECUTE PROCEDURE generate_name_ratings();

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
