-- Tabla de clientes de la barberia
-- Se consulta por numero al inicio de cada conversacion para personalizar el saludo
CREATE TABLE IF NOT EXISTS clientes (
  id                    SERIAL PRIMARY KEY,
  numero                VARCHAR(20) UNIQUE NOT NULL,
  nombre                VARCHAR(120),
  primera_interaccion   TIMESTAMPTZ DEFAULT NOW(),
  ultima_interaccion    TIMESTAMPTZ DEFAULT NOW(),
  total_citas           INTEGER DEFAULT 0,
  preferencias          JSONB DEFAULT '{}'::jsonb
);

CREATE INDEX IF NOT EXISTS idx_clientes_numero ON clientes(numero);
