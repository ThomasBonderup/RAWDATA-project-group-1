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
