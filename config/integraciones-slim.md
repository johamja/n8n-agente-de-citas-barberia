# 🔗 Integraciones (Versión Slim)

## Google Calendar

**Variables .env necesarias:**
```bash
GOOGLE_CALENDAR_API_KEY=sk-xxx
GOOGLE_CALENDAR_ID=barberia@googlecalendar.com
```

**Operaciones:**
- POST /events → Crear cita
- GET /events → Consultar disponibilidad
- DELETE /events/{id} → Cancelar cita

**Payload crear evento:**
```json
{
  "summary": "Cita: Corte - Cliente Juan",
  "start": {"dateTime": "2024-04-15T15:00:00"},
  "end": {"dateTime": "2024-04-15T15:30:00"}
}
```

---

## WhatsApp API

**Variables .env:**
```bash
WHATSAPP_PHONE_NUMBER_ID=1234567890
WHATSAPP_ACCESS_TOKEN=EAA...
WHATSAPP_WEBHOOK_VERIFY_TOKEN=secret_token
```

**Webhook:** `POST /webhook/whatsapp`
**Enviar:** `POST https://graph.instagram.com/v18.0/{PHONE_ID}/messages`

---

## Telegram Bot

**Variables .env:**
```bash
TELEGRAM_BOT_TOKEN=123456:ABCDEF...
```

**Webhook:** `POST /webhook/telegram`

---

## PostgreSQL

**Variables .env:**
```bash
DB_HOST=localhost
DB_PORT=5432
DB_NAME=barberia_db
DB_USER=barberia_user
DB_PASSWORD=secure_pass
```

**Tablas:**
- `usuarios` - Clientes registrados
- `citas` - Registro de citas
- `historial` - Log de acciones

---

## Conectar en n8n

1. **Credenciales → Crear nueva**
2. **Para cada servicio:** Ingresar API keys desde `.env`
3. **Test Connection** → Verificar conectividad
4. **Usar en nodos** → Seleccionar credencial

---

**Ver:** `config.json` para estado de integraciones (habilitada: true/false).
