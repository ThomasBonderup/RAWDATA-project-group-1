#!/bin/bash
set -euo pipefail

psql -U postgres -c "drop database if exists raw1_xlarge"

psql -U postgres -c "create database raw1_xlarge"

psql -U postgres -d raw1_xlarge -f rawdata_xlarge.backup

psql -U postgres -d raw1_xlarge -f B2_build_movie_db.sql

psql -U postgres -d raw1_xlarge -f C2_build_framework_db.sql

psql -U postgres -d raw1_xlarge -f dummyData.sql
