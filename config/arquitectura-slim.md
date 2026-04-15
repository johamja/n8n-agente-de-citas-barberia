# 🏗️ Arquitectura (Versión Comprimida)

## Flujo Principal

```
Usuario → WhatsApp/Telegram → n8n Webhook → Procesar (NLU)
                                    ↓
                    ┌───────────────┼───────────────┐
                    ↓               ↓               ↓
                 AGENDAR       CANCELAR      INFORMACIÓN
                    ↓               ↓               ↓
                  Calendar  ←  Validar  →     FAQ/Config
                    ↓               ↓               ↓
                 Confirmar ←────────┴──────────────→ Responder
```

## 5 Workflows Principales

1. **Webhook Entrada** - Recibe mensajes (WhatsApp/Telegram)
2. **Procesar Intención** - Identifica: AGENDAR | CANCELAR | INFO
3. **Agendar Cita** - Valida disponibilidad → Calendar + DB → Confirma
4. **Cancelar Cita** - Busca cita → Validar política → Libera slot
5. **Responder Info** - Busca en config.json → Envía respuesta

## Integraciones

| Servicio | Uso | Config |
|----------|-----|--------|
| **Google Calendar** | Fuente de disponibilidad | API Key |
| **WhatsApp** | Canal principal entrada/salida | Phone ID + Token |
| **Telegram** | Canal alternativo | Bot Token |
| **PostgreSQL** | Almacenar citas/usuarios | DB credentials |

## Base de Datos (3 Tablas Mínimas)

```sql
usuarios (id, telefono, nombre, fecha_registro)
citas (id, usuario_id, servicio, fecha_hora, estado)
historial (id, usuario_id, tipo, fecha)
```

## Palabras Clave NLU

```
AGENDAR: "agendar", "cita", "turno", "quiero", "reservar"
CANCELAR: "cancelar", "anular", "quitar", "no puedo"
HORARIOS: "horario", "abre", "cierra", "cuándo"
PRECIO: "precio", "cuánto", "cuesta", "valor"
UBICACION: "dónde", "dirección", "ubicación"
```

---

**Ver:** `config.json` para datos específicos, `flujos-slim.md` para detalles técnicos.
