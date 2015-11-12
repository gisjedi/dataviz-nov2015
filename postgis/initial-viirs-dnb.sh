#!/bin/bash

# Create database for mosaic use
psql -c "DROP DATABASE viirs;"
psql -c "CREATE DATABASE viirs;"
psql -c "CREATE EXTENSION postgis;" viirs
psql -c "CREATE SCHEMA viirs;" viirs
