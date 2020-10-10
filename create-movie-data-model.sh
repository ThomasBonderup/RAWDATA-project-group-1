#!/bin/bash
set -euo pipefail

psql -U postgres -c "drop database if exists raw1"

psql -U postgres -c "create database raw1"

psql -U postgres -d raw1 -f rawdata_small.backup

psql -U postgres -d raw1 -f B2_build_movie_db.sql

psql -U postgres -d raw1 -f C2_build_framework_db.sql

psql -U postgres -d raw1 -f dummyData.sql
