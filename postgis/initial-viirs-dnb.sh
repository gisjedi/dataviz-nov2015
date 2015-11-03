#!/bin/bash

# Create database for mosaic use
psql -c "CREATE DATABASE viirs;"
psql -c "CREATE EXTENSION postgis;" viirs