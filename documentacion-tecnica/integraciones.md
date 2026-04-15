# 🔗 Integraciones Externas

## Google Calendar API

**Estado:** [PENDIENTE/CONFIGURADO/ACTIVO]

### Configuración
- **Proyecto:** [NOMBRE DEL PROYECTO]
- **API Key:** Almacenada en `.env`
- **Scope:** Ver/crear/editar/eliminar eventos

### Funcionalidades
- ✅ Crear evento de cita
- ✅ Consultar disponibilidad
- ✅ Actualizar evento (cambio de cita)
- ✅ Eliminar evento (cancelación)

### Endpoints Utilizados
- `POST /events` - Crear evento
- `GET /events` - Listar eventos
- `PATCH /events/{id}` - Actualizar evento
- `DELETE /events/{id}` - Eliminar evento

### Payload Ejemplo
```json
{
  "summary": "Cita: Corte - Cliente: Juan",
  "description": "Servicio: Corte básico\nCliente: Juan\nTeléfono: 123456789",
  "start": {
    "dateTime": "2024-04-15T15:00:00",
    "timeZone": "America/Argentina/Buenos_Aires"
  },
  "end": {
    "dateTime": "2024-04-15T15:30:00",
    "timeZone": "America/Argentina/Buenos_Aires"
  }
}
```

---

## WhatsApp API

**Estado:** [PENDIENTE/CONFIGURADO/ACTIVO]

### Configuración
- **Proveedor:** [Meta/Twilio/Otra]
- **Phone ID:** [ID DEL TELÉFONO]
- **Token:** Almacenado en `.env`

### Funcionalidades
- ✅ Recibir mensajes
- ✅ Enviar mensajes
- ✅ Enviar plantillas
- ✅ Enviar recordatorios

### Webhook
- **URL:** `[SERVIDOR]/webhook/whatsapp`
- **Método:** POST

### Payload Recibido
```json
{
  "messaging_product": "whatsapp",
  "entry": [{
    "changes": [{
      "messages": [{
        "from": "123456789",
        "text": {
          "body": "Quiero agendar una cita"
        },
        "timestamp": "1234567890"
      }]
    }]
  }]
}
```

---

## Telegram Bot API

**Estado:** [PENDIENTE/CONFIGURADO/ACTIVO]

### Configuración
- **Bot Token:** Almacenado en `.env`
- **Bot Name:** @[BOT_NAME]

### Funcionalidades
- ✅ Recibir mensajes
- ✅ Enviar mensajes
- ✅ Mensajes con botones
- ✅ Notificaciones

### Webhook
- **URL:** `[SERVIDOR]/webhook/telegram`
- **Método:** POST

---

## Base de Datos

**Tipo:** PostgreSQL / n8n DB

### Tablas Principales

#### `usuarios`
```sql
- id (UUID)
- telefono (VARCHAR)
- nombre (VARCHAR)
- email (VARCHAR)
- fecha_registro (TIMESTAMP)
- canal (VARCHAR) -- whatsapp/telegram
```

#### `citas`
```sql
- id (UUID)
- usuario_id (UUID FOREIGN KEY)
- servicio (VARCHAR)
- fecha_hora (TIMESTAMP)
- duracion (INT) -- minutos
- estado (ENUM) -- confirmada/cancelada/completada
- barbero_id (VARCHAR NULLABLE)
- fecha_creacion (TIMESTAMP)
- fecha_cancelacion (TIMESTAMP NULLABLE)
```

#### `servicios`
```sql
- id (UUID)
- nombre (VARCHAR)
- descripcion (TEXT)
- precio (DECIMAL)
- duracion (INT) -- minutos
- activo (BOOLEAN)
```

#### `historial_no_show`
```sql
- id (UUID)
- usuario_id (UUID FOREIGN KEY)
- fecha_evento (TIMESTAMP)
- fecha_registro (TIMESTAMP)
```

---

## Notificaciones

### Email Reminders
**Estado:** [PENDIENTE/CONFIGURADO/ACTIVO]

- Proveedor: [SendGrid/Mailgun/Otra]
- Tipo: Recordatorio 24h antes
- Template: [NOMBRE DEL TEMPLATE]

### SMS Reminders
**Estado:** [PENDIENTE/CONFIGURADO/ACTIVO]

- Proveedor: [Twilio/Nexmo/Otra]
- Tipo: Recordatorio 2h antes
- Máx. 1 SMS por cliente

---

## Variables de Entorno Requeridas

Ver `variables-ambiente.md`

---

**Última actualización:** [FECHA]
