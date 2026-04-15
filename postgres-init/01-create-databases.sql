-- Crea la base de datos de Evolution API si no existe
SELECT 'CREATE DATABASE evolution' WHERE NOT EXISTS (
  SELECT FROM pg_database WHERE datname = 'evolution'
)\gexec
