#!/bin/bash

# Create database for mosaic use
psql -c "DROP DATABASE landsat;"
psql -c "CREATE DATABASE landsat;"
psql -c "CREATE EXTENSION postgis;" landsat
psql -c "CREATE SCHEMA landsat;" landsat
