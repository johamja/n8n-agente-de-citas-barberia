# 🔐 Variables de Entorno

Archivo: `.env` (en la raíz del proyecto)

## Google Calendar

```bash
# Google Calendar API
GOOGLE_CALENDAR_API_KEY=sk-xxxxxxxxxxxxxx
GOOGLE_CALENDAR_ID=barberia@googlecalendar.com
GOOGLE_PROJECT_ID=proyecto-barberia
GOOGLE_CLIENT_ID=xxxxx.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=xxxxxxxxxxxxx
```

## WhatsApp API

```bash
# Meta / WhatsApp Business API
WHATSAPP_PHONE_NUMBER_ID=1234567890
WHATSAPP_BUSINESS_ACCOUNT_ID=xxxxxxxxxxxxx
WHATSAPP_ACCESS_TOKEN=EAAxxxxxxxxxxxxxx
WHATSAPP_API_URL=https://graph.instagram.com/v18.0
WHATSAPP_WEBHOOK_VERIFY_TOKEN=webhook_verify_token_secreto
```

## Telegram

```bash
# Telegram Bot
TELEGRAM_BOT_TOKEN=123456:ABCDEFGHIJKLMNOPQRSTUVWxyz
TELEGRAM_CHAT_ID=xxxxxxxxxxxxx (opcional)
```

## Base de Datos

```bash
# PostgreSQL (si se usa)
DB_HOST=localhost
DB_PORT=5432
DB_NAME=barberia_db
DB_USER=barberia_user
DB_PASSWORD=contraseña_segura

# O n8n Database
N8N_DB_TYPE=sqlite
N8N_DB_SQLITE_PATH=/data/database.sqlite
```

## n8n Cloud

```bash
# n8n Cloud Configuration
N8N_HOST=tu-instancia.n8n.cloud
N8N_PORT=5678
N8N_PROTOCOL=https
N8N_EDITOR_BASE_URL=https://tu-instancia.n8n.cloud
```

## Configuración General

```bash
# Entorno
NODE_ENV=production
ENVIRONMENT=production

# Timezone
TZ=America/Argentina/Buenos_Aires

# Webhook Base URL
WEBHOOK_BASE_URL=https://tu-dominio.com

# Email (para recordatorios)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=tu-email@gmail.com
SMTP_PASSWORD=contraseña_app
SMTP_FROM=noreply@barberia.com

# SMS (para recordatorios)
TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=xxxxxxxxxxxxx
TWILIO_PHONE_NUMBER=+1234567890
```

## Logging y Debugging

```bash
# Logs
LOG_LEVEL=info
LOG_OUTPUT=console,file
LOG_FILE_PATH=/logs/n8n.log

# Debugging
DEBUG=false
SENTRY_DSN=https://xxxxx@sentry.io/xxxxx (opcional)
```

## Configuración de Negocio

```bash
# Estos también podrían estar en archivos .md, pero incluimos aquí para referencia
BARBERIA_NOMBRE="Mi Barbería"
BARBERIA_TELEFONO="+123456789"
BARBERIA_EMAIL="info@barberia.com"
BARBERIA_DIRECCION="Calle Principal 123"
BARBERIA_TIMEZONE="America/Argentina/Buenos_Aires"
```

## Notas Importantes

⚠️ **NUNCA** commits `.env` a git
⚠️ Usa `.env.example` con valores dummy para documentación
⚠️ Rotación de tokens cada 90 días
⚠️ Almacena en variable de entorno del servicio, no en archivos

## Checklist de Configuración

- [ ] Google Calendar API configurada
- [ ] WhatsApp/Telegram tokens agregados
- [ ] Base de datos configurada y testeada
- [ ] SMTP para emails configurado
- [ ] Timezone correcto
- [ ] Webhook URL correcta
- [ ] Backup de `.env` en lugar seguro
- [ ] Permisos de archivo `.env` restrictivos (600)

---

**Última actualización:** [FECHA]
