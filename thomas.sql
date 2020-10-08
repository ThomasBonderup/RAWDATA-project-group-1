-- D.2 Simple Search

-- a string_search FUNCTION
CREATE OR REPLACE FUNCTION string_search (string char(50), uconst char(10))
-- ASsumes a table title - the main part of the source table title_bASics
RETURNS table (
  tconst char(10),
  primarytitle text,
  plot text
) 
LANGUAGE plpgsql
AS $$
BEGIN
INSERT INTO search_history(uconst, timestamp, search)
VALUES(uconst, NOW(), string); 
RETURN query SELECT t.tconst, t.primarytitle 
FROM title t
WHERE t.primarytitle LIKE '%'||string||'%' OR t.plot LIKE '%'||string||'%';
END
$$;

SELECT * FROM string_search('Remake', 'ui000123');
SELECT * FROM string_search('Frozen', 'ui000123')
SELECT * FROM string_search('Frozen 2', 'ui000123');


-- Trigger function to insert search query in search_history table
CREATE OR REPLACE FUNCTION insert_search_history() RETURNS event_trigger AS $$
BEGIN
	INSERT INTO search_history(uconst, timestamp, search)
	VALUES('1', NOW(), 'search string');
END;
$$ LANGUAGE plpgsql;

CREATE EVENT TRIGGER search_history_trigger ON string_search EXECUTE PROCEDURE insert_search_history();


