#!/bin/bash
set -euo pipefail

psql -U postgres -c "drop database if exists raw1_large"

psql -U postgres -c "create database raw1_large"

psql -U postgres -d raw1_large -f rawdata_large.backup

psql -U postgres -d raw1_large -f B2_build_movie_db.sql

psql -U postgres -d raw1_large -f C2_build_framework_db.sql

psql -U postgres -d raw1_large -f dummyData.sql

psql -U postgres -d raw1_large -f code_script.sql

psql -U postgres -d raw1_large -a -f test_script.sql > /tmp/test_output.txt
