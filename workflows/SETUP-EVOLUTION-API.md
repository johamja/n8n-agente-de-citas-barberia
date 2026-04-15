# ⚡ Setup Evolution API + n8n

## Paso 1: Variables de Entorno en n8n

**Settings → Variables → Add Variable**

| Nombre | Valor |
|--------|-------|
| `EVOLUTION_API_URL` | `http://localhost:8080` (o tu URL de Evolution) |
| `EVOLUTION_INSTANCE` | nombre de tu instancia (ej: `barberia`) |
| `EVOLUTION_API_KEY` | tu API key de Evolution |
| `GOOGLE_CALENDAR_ID` | email del calendario (ej: `tu@gmail.com`) |

---

## Paso 2: Credenciales en n8n

**Credentials → Add Credential**

**Anthropic API:**
- Tipo: Anthropic
- API Key: tu key de Anthropic

**Google Calendar:**
- Tipo: Google Calendar OAuth2
- Seguir flujo de autenticación con tu cuenta Google

---

## Paso 3: Importar Workflows

**ORDEN IMPORTANTE:**

1. **Importar primero** `02-herramienta-citas.json`
   - Workflows → Import from File
   - Guardar y **copiar el ID** de la URL (ej: `https://n8n.../workflow/14` → ID es `14`)

2. **Editar** `01-agente-whatsapp.json` en un editor de texto
   - Buscar: `REEMPLAZAR_CON_ID_WORKFLOW_02`
   - Reemplazar con el ID del paso anterior (ej: `14`)
   - También reemplazar `ANTHROPIC_CREDENTIAL_ID` y `GOOGLE_CALENDAR_CREDENTIAL_ID` con los IDs de tus credenciales

3. **Importar** `01-agente-whatsapp.json`

---

## Paso 4: Configurar Evolution API

### Crear instancia y conectar QR

```bash
# Crear instancia
curl -X POST http://localhost:8080/instance/create \
  -H "Content-Type: application/json" \
  -H "apikey: TU_API_KEY" \
  -d '{
    "instanceName": "barberia",
    "qrcode": true
  }'
```

### Escanear QR

```bash
# Ver el QR
curl http://localhost:8080/instance/connect/barberia \
  -H "apikey: TU_API_KEY"
```

El QR se muestra en la respuesta como imagen base64 o en el panel de Evolution.

### Configurar Webhook

```bash
# Apuntar a n8n
curl -X POST http://localhost:8080/webhook/set/barberia \
  -H "Content-Type: application/json" \
  -H "apikey: TU_API_KEY" \
  -d '{
    "url": "http://TU_N8N_URL/webhook/whatsapp-barberia",
    "webhook_by_events": false,
    "webhook_base64": false,
    "events": ["MESSAGES_UPSERT"]
  }'
```

---

## Paso 5: Activar Workflows

1. Abrir workflow `02 - Herramienta Citas` → Toggle ON
2. Abrir workflow `01 - Agente WhatsApp` → Toggle ON

---

## Paso 6: Probar

Envía un WhatsApp al número conectado:
- `"Hola, ¿cuánto cuesta un corte?"`
- `"Quiero agendar una cita"`
- `"¿A qué hora abren?"`

---

## Notas

- Para credenciales: cópialas de **Settings → Credentials** haciendo hover sobre cada una para ver su ID numérico
- Si usas n8n Cloud, la URL del webhook es `https://TU_INSTANCIA.n8n.cloud/webhook/whatsapp-barberia`
- Evolution API puede correr en Docker; usa el `docker-compose.yml` del repositorio de Evolution
