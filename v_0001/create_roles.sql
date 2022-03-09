DO
$do$
BEGIN
   IF NOT EXISTS (
      SELECT FROM pg_catalog.pg_roles  -- SELECT list can be empty for this
      WHERE  rolname = 'organization_service') THEN

      CREATE ROLE organization_service
          LOGIN
          PASSWORD 'organization_service';
   END IF;
END
$do$;