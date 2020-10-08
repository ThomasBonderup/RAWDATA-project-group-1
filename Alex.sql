CREATE OR REPLACE FUNCTION rate(user_id CHARACTER(10), movie_id CHARACTER(10), movie_rating INTEGER, movie_review TEXT)
RETURNS void LANGUAGE plpgsql AS $$
BEGIN

INSERT INTO 
rating (uconst, tconst, rating, review) 

VALUES (user_id, 
movie_id,
movie_rating, 
movie_review);

END $$;


CREATE OR REPLACE FUNCTION rate(user_id CHARACTER(10), movie_id CHARACTER(10), movie_rating INTEGER)
RETURNS void LANGUAGE plpgsql AS $$
BEGIN

INSERT INTO 
rating (uconst, tconst, rating, review) 

VALUES (user_id, 
movie_id,
movie_rating, 
'N/A');

END $$;

CREATE OR REPLACE FUNCTION update_rating_history()
RETURNS TRIGGER LANGUAGE plpgsql AS

$$ 
DECLARE 
arg TEXT;

BEGIN

RETURN NEW;

END;
$$


CREATE TRIGGER insert_rating_history 
AFTER INSERT OR UPDATE ON rating 
FOR EACH ROW 
EXECUTE PROCEDURE update_rating_history();


