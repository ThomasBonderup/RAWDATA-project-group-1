#!/bin/bash
set -euo pipefail

psql -U postgres -c "drop database if exists raw1_small"

psql -U postgres -c "create database raw1_small"

psql -U postgres -d raw1_small -f rawdata_small.backup

psql -U postgres -d raw1_small -f B2_build_movie_db.sql

psql -U postgres -d raw1_small -f C2_build_framework_db.sql

psql -U postgres -d raw1_small -f dummyData.sql
