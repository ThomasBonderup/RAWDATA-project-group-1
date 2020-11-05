#!/bin/bash
set -euo pipefail

PGPASSWORD=postgres psql -U postgres -c "drop database if exists raw1"

PGPASSWORD=postgres psql -U postgres -c "create database raw1"

PGPASSWORD=postgres psql -U postgres -d raw1 -f rawdata_small.backup

PGPASSWORD=postgres psql -U postgres -d raw1 -f B2_build_movie_db.sql

PGPASSWORD=postgres psql -U postgres -d raw1 -f C2_build_framework_db.sql

PGPASSWORD=postgres psql -U postgres -d raw1 -f dummyData.sql

PGPASSWORD=postgres psql -U postgres -d raw1 -f code_script.sql

PGPASSWORD=postgres psql -U postgres -d raw1 -a -f test_script.sql > test_output.txt
