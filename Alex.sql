
-- D3
/*--------- INSERT OR UPDATE USER RATING  BASIC ---------*/

CREATE OR REPLACE FUNCTION insert_or_update_rating(user_id CHARACTER(10), movie_id CHARACTER(10), movie_rating INTEGER)
RETURNS void LANGUAGE plpgsql AS $$
BEGIN

<<<<<<< HEAD
INSERT INTO
rating (uconst, tconst, rating, review)
=======
IF EXISTS(SELECT * 
FROM rating 
WHERE uconst = user_id) 
AND EXISTS(SELECT *
FROM rating
WHERE tconst = movie_id)
THEN 
RAISE NOTICE 'Already exists';

UPDATE rating
SET uconst = user_id,
tconst = movie_id,
rating = movie_rating,
review = 'N/A'
WHERE uconst = user_id AND tconst = movie_id;
RAISE NOTICE 'Update complete';

RETURN;

END IF;

INSERT INTO 
rating (uconst, tconst, rating, review) 
>>>>>>> 3444d421b2e9b33dfdffc9d47acc7c3e077487e6

VALUES (user_id,
movie_id,
movie_rating,
'N/A');

END $$;


/*--------- INSERT OR UPDATE USER RATING  OVERLOADED ---------*/

CREATE OR REPLACE FUNCTION insert_or_update_rating(user_id CHARACTER(10), movie_id CHARACTER(10), movie_rating INTEGER, movie_review TEXT)
RETURNS void LANGUAGE plpgsql AS $$
BEGIN

<<<<<<< HEAD
INSERT INTO
rating (uconst, tconst, rating, review)
=======
IF EXISTS(SELECT * 
FROM rating 
WHERE uconst = user_id) 
AND EXISTS(SELECT *
FROM rating
WHERE tconst = movie_id)
THEN 
RAISE NOTICE 'Already exists';

UPDATE rating
SET uconst = user_id,
tconst = movie_id,
rating = movie_rating,
review = movie_review
WHERE uconst = user_id AND tconst = movie_id;
RAISE NOTICE 'Update complete';

RETURN;

END IF;

INSERT INTO 
rating (uconst, tconst, rating, review) 
>>>>>>> 3444d421b2e9b33dfdffc9d47acc7c3e077487e6

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

/*--------- UPDATE AVERAGE RATING ---------*/

CREATE OR REPLACE FUNCTION update_avrg_rating()
RETURNS TRIGGER LANGUAGE plpgsql AS $$

BEGIN

<<<<<<< HEAD
UPDATE title_ratings
=======
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
>>>>>>> 3444d421b2e9b33dfdffc9d47acc7c3e077487e6
SET numvotes = numvotes + 1,
averagerating = (averagerating) + ((NEW.rating - averagerating) / numvotes)
WHERE tconst = NEW.tconst;

RAISE NOTICE 'Average updated';

RETURN NEW;
END; $$

CREATE TRIGGER upd_avrg_rating_trigger
<<<<<<< HEAD
AFTER INSERT OR UPDATE ON rating
FOR EACH ROW
EXECUTE PROCEDURE update_avrg_rating();
=======
AFTER INSERT OR UPDATE ON rating 
FOR EACH ROW 
EXECUTE PROCEDURE update_avrg_rating();







>>>>>>> 3444d421b2e9b33dfdffc9d47acc7c3e077487e6
