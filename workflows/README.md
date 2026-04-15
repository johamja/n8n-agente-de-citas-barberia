# 📦 Workflows n8n - Barberia Alex

## Orden de Importación (IMPORTANTE)

1. Importar primero: `02-herramienta-citas.json`
2. Copiar el ID que le asignó n8n al workflow 02
3. Abrir `01-agente-whatsapp.json` y reemplazar `REEMPLAZAR_CON_ID_WORKFLOW_02`
4. Importar: `01-agente-whatsapp.json`

## Variables de Entorno Necesarias en n8n

Ir a: Settings → Variables

| Variable | Descripción |
|----------|-------------|
| `EVOLUTION_API_URL` | URL base de Evolution API (ej: http://localhost:8080) |
| `EVOLUTION_INSTANCE` | Nombre de tu instancia en Evolution |
| `EVOLUTION_API_KEY` | API Key de Evolution |
| `GOOGLE_CALENDAR_ID` | ID del calendario de citas |

## Credenciales Necesarias en n8n

Ir a: Credentials → New

- **Anthropic API** → API Key de Anthropic
- **Google Calendar OAuth2** → Cuenta de Google del barbero

## Webhook de Evolution API

URL a configurar en Evolution:
```
http://TU_N8N_URL/webhook/whatsapp-barberia
```
