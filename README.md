# Ride-Hailing Analytics — Snowflake + dbt

A complete data transformation pipeline for ride-hailing trip data, built with **Snowflake** and **dbt**, following a layered raw to staging to marts architecture with automated testing and documentation.

## Overview

This project takes raw trip, driver, and zone data loaded into Snowflake and transforms it into a clean, tested, business-ready star schema, designed to power analytics dashboards (Power BI).

## Architecture

RAW (Snowflake schema)
  - raw_trips
  - drivers
  - cities
  - zones
  - payment_types

        |
        v  (source())

STAGING (views, cleaned and renamed)
  - stg_trips
  - stg_drivers
  - stg_cities
  - stg_zones
  - stg_payment_types

        |
        v  (ref())

MARTS (tables, business logic, star schema)
  - fct_trips          (fact table)
  - dim_drivers        (joined with cities)
  - dim_zones          (with airport flag)
  - dim_payment_types  (with payment method grouping)
  - dim_dates          (generated date spine)

## Key Design Decisions

- Staging layer: 1:1 with raw sources, handles column renaming, type fixes, and filters out structurally invalid data (e.g. negative durations, null timestamps)
- Marts layer: business logic, joins, and calculated fields (trip duration, distance in km, completion status, payment groupings, airport zone flags)
- dim_dates: generated entirely via SQL (no source table) using Snowflake's GENERATOR function, a full year date spine with day, week, month, and quarter attributes

## Data Quality and Testing

13 automated tests via dbt test, covering:
- Primary key uniqueness and non-null constraints across all dimensions
- Referential integrity between fct_trips and dimension tables
- Business rule validation (accepted_values on status and payment groupings)
- Custom singular test: caught and fixed 4 records with negative trip durations (dropoff timestamp before pickup), resolved with a staging-layer filter

## Tech Stack

- Snowflake - cloud data warehouse
- dbt-core - transformation, testing, documentation
- Python venv - isolated environment

## Project Structure

models/
  staging/      (1:1 cleaned views from raw sources)
    _sources.yml
    stg_*.sql
  marts/         (business-ready star schema)
    _schema.yml  (descriptions and tests)
    fct_*.sql, dim_*.sql

tests/    (custom singular tests)
macros/   (custom schema naming logic)

## Running This Project

dbt run    - build all models (staging then marts)
dbt test   - run all 13 data quality tests
dbt docs generate && dbt docs serve   - view lineage graph