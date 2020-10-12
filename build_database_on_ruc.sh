psql -h rawdata.ruc.dk -p 5432 -U raw1 -d raw1 -W -f rawdata_small.backup
psql -h rawdata.ruc.dk -p 5432 -U raw1 -d raw1 -W -f B2_build_movie_db_raw1.sql
psql -h rawdata.ruc.dk -p 5432 -U raw1 -d raw1 -W -f C2_build_framework_db_raw1.sql
psql -h rawdata.ruc.dk -p 5432 -U raw1 -d raw1 -W -f dummyData.sql
psql -h rawdata.ruc.dk -p 5432 -U raw1 -d raw1 -W -f code_script.sql
psql -h rawdata.ruc.dk -p 5432 -U raw1 -d raw1 -W -a -f test_script.sql > test_output.txt
