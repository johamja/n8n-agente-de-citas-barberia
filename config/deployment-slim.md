# 🚀 Deployment (Versión Slim)

## Opción Recomendada: n8n Cloud

```bash
1. Crear cuenta: https://n8n.io
2. Crear instancia Cloud
3. Subir archivo: config/config.json
4. Importar workflows
5. Configurar credenciales (APIs)
6. Activar workflows
```

**Ventajas:** Auto-SSL, backups, sin mantenimiento

---

## Opción Local: Docker

**Iniciar servicios:**
```bash
docker-compose up -d
# Acceder: http://localhost:5678
```

**Variables .env requeridas:**
```bash
N8N_PORT=5678
N8N_HOST=localhost
N8N_PROTOCOL=http
WEBHOOK_URL=http://localhost:5678
POSTGRES_USER=n8n_user
POSTGRES_PASSWORD=secure_pass
POSTGRES_DB=n8n_db
```

---

## Post-Deployment

1. **Importar config.json** → Nodo Code en n8n
2. **Conectar APIs** → Credenciales → Test
3. **Activar workflows** → Cambiar a ON
4. **Probar webhook** → Enviar mensaje test

---

## Monitoreo Básico

```bash
# Ver logs
docker logs -f n8n

# Verificar status
curl http://localhost:5678/healthz
```

---

**Ver:** `integraciones-slim.md` para setup de APIs específicas.
