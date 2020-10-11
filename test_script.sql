-- GROUP: RAW1, MEMBERS: <Alex Tao Korsgaard Wogelius>, <Emilie Beske Unna-Lindhard>, <Nils Müllenborn>, <Thomas Winther Bonderup>

SET search_path TO movie_data_model;
-- D.1.

-- D.2 Simple Search
-- Test case: find all movies with simple search with 1 parameter on title name or plot
--   	      select on search_history before an after to check if search string is stored  
SELECT * FROM search_history;

SELECT * FROM string_search('Remake', 'ui000001');

SELECT * FROM search_history;

-- D.3

-- D.4 Structured String Search
-- Test case: find all movies with structured search with 4 parameters,
-- 	      title name, plot, characters and name,
-- 	      lower and upper case characters added including empty parameters
SELECT * FROM structured_string_search('', 'see', '', 'Mads miKKelsen', 'ui000001');

-- D.5 Actor Search
-- Test case: find all actor names with actor search with 1 parameter on actor name or character
SELECT * FROM actor_search('Mads Mikkelsen', 'ui000001');

-- D.6

-- D.7

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

-- D.14

-- D.15
