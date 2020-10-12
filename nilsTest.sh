#!/bin/bash
set -euo pipefail

psql -U postgres -c "drop database if exists raw1_large"

psql -U postgres -c "create database raw1_large"

psql -U postgres -d raw1_large -f rawdata_large.backup
