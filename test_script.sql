-- GROUP: RAW1, MEMBERS: <Alex Tao Korsgaard Wogelius>, <Emilie Beske Unna-Lindhard>, <Nils Müllenborn>, <Thomas Winther Bonderup>

SET search_path TO movie_data_model;
-- D.1.

-- D.2 Simple Search
-- Test case: 
SELECT * FROM string_search('Remake', 'ui000001');

-- D.3

-- D.4 Structured String Search
-- Test case: lower and upper case characters including empty parameters
SELECT * FROM structured_string_search('', 'see', '', 'Mads miKKelsen', 'ui000001');

-- D.5 Actor Search
-- Test case: 
SELECT * FROM actor_search('Mads Mikkelsen', 'ui000001');

-- D.6

-- D.7

-- D.8

-- D.9

-- D.10

-- D.11 Exact-match Querying
-- Test case: 
SELECT * FROM exact_match_search('apple', 'mads', 'mikkelsen', 'ui000001');

-- D.12 Best-match Querying
-- Test case:
SELECT * FROM exact_match_search('apple', 'mads', 'mikkelsen', 'ui000001');

-- Test case: dynamic function using VARIADIC array for multiple input parameters
SELECT * FROM dynamic_bestmatch('apple', 'mads', 'mikkelsen');

-- D.13

-- D.14

-- D.15
