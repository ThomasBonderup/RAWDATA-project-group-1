Notes on script creation 

Private github repo created for code and script. 

Alex, Emilie and Nils create a github account and send me your account email, so I can invite you to the private github repo. Link to github: http://github.com/ 

# RAWDATA-project-group-1 
 
Step 1  
  
Download rawdata_small.backup  

Step 2  

Create or re-create imdb database  

psql -U postgres -C "create database imdb"  

psql -U postgres -d imdb -f rawdata_small.backup 

Step 3 + Step 4 

Create tables for The Movie Data Model 

 Insert / distribute data from imdb database into new tables 

DO loop to split values to complied 

CREATE tables 

ALTER new tables and give right to owner postgres 

Primary keys & foreigns keys 

Not null or other rules 

Delete on cascade, what happens when a title is deleted. Alex and Thomas talked about using delete on cascade effect to delete records from tables that depend on title. 

create table course 

    (course_id        varchar(8),  

     title            varchar(50) not null,  

     dept_name        varchar(20), 

     credits        numeric(2,0) check (credits > 0), 

     primary key (course_id), 

     foreign key (dept_name) references department (dept_name) 

        on delete set null 

    ); 

Insert 

insert into course values ('CS-347', 'Database System Concepts', 'Comp. Sci.', '3');  

psql -U postgres -C "create database movie_data"  

psql -U postgres -d movie_data -f B2_build_movie_db.sql 

Thomas and Alex have broken the process of table creation and data-migration into 4 steps,  