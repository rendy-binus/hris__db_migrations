CREATE SCHEMA IF NOT EXISTS organization;

GRANT USAGE ON SCHEMA organization
TO organization_service;

GRANT SELECT, INSERT, UPDATE
ON ALL TABLES
IN SCHEMA "organization"
TO organization_service;
