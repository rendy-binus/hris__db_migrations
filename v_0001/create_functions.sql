CREATE OR REPLACE FUNCTION public.auto_updated_date()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_date = now();
   RETURN NEW;
END;
$$ language 'plpgsql';