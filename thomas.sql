-- D.2 Simple Search

CREATE OR REPLACE FUNCTION string_search (string char(50), uconst char(10))

RETURNS TABLE (
  tconst char(10),
  primarytitle text
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

-- D.4 Structured String Search

CREATE OR REPLACE FUNCTION structured_string_search(title char(50), plot char(50), characters char(50), name char(50), uconst char(10))

RETURNS TABLE (
  tconst char(10),
  primarytitle text
) 
LANGUAGE plpgsql
AS $$
BEGIN
INSERT INTO search_history(uconst, timestamp, search)
VALUES(uconst, NOW(), CONCAT(title, plot, characters, name)); 
RETURN query SELECT t.tconst, t.primarytitle 
FROM title NATURAL JOIN title_principals NATURAL JOIN name t
WHERE (t.title IS NULL OR t.title = title)
AND (t.plot IS NULL OR t.plot = plot)
END
$$;

SELECT * FROM structured_string_search('test', 'test', 'test', 'test', 'ui000123');

SELECT * FROM structured_string_search('', 'see', '', 'Mads miKKelsen', 'ui000123');



-- D.10 Structured String Search
CREATE OR REPLACE FUNCTION structured_string_search(title char(50), plot char(50), characters char(50), name char(50), uconst char(10))

RETURNS TABLE (
  tconst char(10),
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

SELECT * FROM structured_string_search('test', 'test', 'test', 'test', 'ui000123');

SELECT * FROM structured_string_search('', 'see', '', 'Mads miKKelsen', 'ui000123');

-- Trigger function to insert search query in search_history table
CREATE OR REPLACE FUNCTION insert_search_history() RETURNS event_trigger AS $$
BEGIN
	INSERT INTO search_history(uconst, timestamp, search)
	VALUES('1', NOW(), 'search string');
END;
$$ LANGUAGE plpgsql;

CREATE EVENT TRIGGER search_history_trigger ON string_search EXECUTE PROCEDURE insert_search_history();


