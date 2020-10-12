-- GROUP: RAW1, MEMBERS: <Alex Tao Korsgaard Wogelius>, <Emilie Beske Unna-Lindhard>, <Nils Müllenborn>, <Thomas Winther Bonderup>
-- test script for testing function and procedures
SET search_path TO movie_data_model;
-- D.1 Basic framework functionality
-- Test cases for user
SELECT add_user('ui000007', 'Test', 'User 07', 'test07@test.dk', '07pw', 'testuser07');
SELECT update_user('ui000007', 'Test', 'Test 07.2', 'test07.2@test.dk', '07.2pw', 'testuser07.2');
SELECT delete_user('ui000007');
-- Test cases for title bookmarks
SELECT add_title_bookmark('ui000002', 'tt0974011');
SELECT delete_title_bookmark('ui000002', 'tt0974011');
SELECT * from get_title_bookmarks('ui000002');
-- Test cases for name bookmarks
SELECT add_name_bookmark('ui000002', 'nm3800107');
SELECT delete_name_bookmark('ui000002', 'nm3800107');
SELECT * from get_name_bookmarks('ui000002');
-- Test cases for title notes
SELECT add_title_notes('ui000002', 'tt0974011', 'This is a note lets see what i can write here 123, ***');
SELECT update_title_notes('ui000002', 'tt0974011', 'this is the updated title note');
SELECT delete_title_notes('ui000002', 'tt0974011');
SELECT * from get_title_notes('ui000002');
-- Test cases for name notes
SELECT add_name_notes('ui000002', 'nm3800107', 'OG name note');
SELECT update_name_notes('ui000002', 'nm3800107', 'this is the updated name note');
SELECT delete_name_notes('ui000002', 'nm3800107');
SELECT * from get_name_notes('ui000002');
-- Test case for get search history
SELECT * from get_search_history('ui000002');
-- Test case for get rating history
SELECT * from get_rating_history('ui000002');

-- D.2 Simple Search
-- Test case: find all movies with simple search with 1 parameter on title name or plot
--   	      select on search_history before an after to check if search string is stored
SELECT * FROM search_history;

SELECT * FROM string_search('Remake', 'ui000001');

SELECT * FROM search_history;

-- D.3

-- Test case: Inserting a new (random) title rating to generate name ratings which is a trigger function 
-- We should make an initial generate function as well, that isn't a trigger. 
SELECT ins_user_rating('ui000001', 'tt0169084', 7);

-- Test case: Displaying the name rating of an actor, to show that this will be updated alongside a title rating 
SELECT *
FROM name_rating
WHERE nconst = 'nm1449677';

-- Test case: Inserting a title rating on a movie which "stars" nm1449677 to see that his name rating changes
SELECT ins_user_rating('ui000001', 'tt0323536', 1);

-- Test case: Showing that the name_rating of nm1449677 has changed 
SELECT *
FROM name_rating
WHERE nconst = 'nm1449677';

-- Test case: Updating a rating from the same user on the same movie.  
-- The old rating will be subtracted from the average title rating and the new value will be updated.
SELECT upd_user_rating('ui000001', 'tt0323536', 10);


-- Test case: Testing insert on user rating with review
SELECT ins_user_rating('ui000001', 'tt11097072', 8, 'Greatest movie I ever watched');

-- Test case: Showing the result ofthe query above
SELECT *
FROM rating
WHERE tconst = 'tt11097072'  AND uconst = 'ui000001';

-- Test case: Showing that the rating history is updated with inserts
SELECT *
FROM rating_history 
WHERE uconst = 'ui000001';

-- Test case: Testing update on user ratings with review
SELECT upd_user_rating('ui000001', 'tt11097072', 4, 'I watched it again and changed my mind');

-- Test case: Showing the result ofthe query above
SELECT *
FROM rating
WHERE tconst = 'tt11097072'  AND uconst = 'ui000001';

-- Test case: Showing that the rating history is updated with updates on title ratings
SELECT *
FROM rating_history 
WHERE uconst = 'ui000001';



-- D.4 Structured String Search
-- Test case: find all movies with structured search with 4 parameters,
-- 	      title name, plot, characters and name,
-- 	      lower and upper case characters added including empty parameters
SELECT * FROM structured_string_search('', 'see', '', 'Mads miKKelsen', 'ui000001');

-- D.5 Actor Search
-- Test case: find all actor names with actor search with 1 parameter on actor name or character
SELECT * FROM actor_search('Mads Mikkelsen', 'ui000001');

-- D.6
-- Test case: find the 12 actors that name co plays with (return table with primaryname and a count)
SELECT * from get_co_players('Clint Eastwood');

-- D.7
-- Should generate all ratings for names
--SELECT generate_name_ratings();

-- D.8

-- D.9

-- D.10

-- D.11 Exact-match Querying
-- Test case D11a: find titles by searching on 3 intersecting keywords in inverted index wi
SELECT * FROM exact_match_search('apple', 'mads', 'mikkelsen', 'ui000001');

-- D.12 Best-match Querying
-- Test case D.12a: find ranked titles with multiple paramters by using VARIADIC array
SELECT * FROM dynamic_bestmatch('apple', 'mads', 'mikkelsen');

-- Test case D.12b: find ranked titles with single paramter by using VARIADIC array
SELECT * FROM dynamic_bestmatch('apple');

-- D.13
-- no solution
-- D.14
-- no solution
-- D.15
-- no solution
