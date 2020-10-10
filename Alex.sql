
/*---------USER RATING - BASIC ---------*/

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


/*---------USER RATING - OVERLOADED ---------*/

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

/*---------UPDATE RATING HISTORY - TRIGGER ---------*/

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

/*---------UPDATE AVRG RATING - TRIGGER ---------*/

CREATE OR REPLACE FUNCTION update_avrg_rating()
RETURNS TRIGGER LANGUAGE plpgsql AS $$

BEGIN

UPDATE title_ratings
SET numvotes = numvotes + 1,
averagerating = (averagerating) + ((NEW.rating - averagerating) / numvotes)
WHERE tconst = NEW.tconst;

RETURN NEW;
END; $$

CREATE TRIGGER upd_avrg_rating_trigger
AFTER INSERT OR UPDATE ON rating
FOR EACH ROW
EXECUTE PROCEDURE update_avrg_rating();
