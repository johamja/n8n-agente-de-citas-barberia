# 🔄 Flujos n8n (Versión Slim)

## Flujo 1: Webhook Entrada
**Input:** Mensaje WhatsApp/Telegram
**Output:** Message object + userId
**Nodos:** Webhook → Validar → Siguiente

```javascript
{
  "userId": "123456",
  "mensaje": "Quiero agendar",
  "canal": "whatsapp"
}
```

---

## Flujo 2: Procesar Intención
**Input:** Mensaje del Flujo 1
**Output:** Intención + Entidades

```javascript
// Lógica NLU simple
const msg = input.toLowerCase();
const intenciones = {
  "agendar": ["agendar", "cita", "turno", "reservar"],
  "cancelar": ["cancelar", "anular", "quitar"],
  "horarios": ["horario", "abre", "cierra"],
  "precio": ["precio", "cuánto", "cuesta"],
  "ubicacion": ["dónde", "dirección", "ubicación"]
};

// Retornar intención + confiance score
```

---

## Flujo 3: Agendar Cita

**Validaciones:**
1. Usuario registrado → Guardar en DB si no
2. Servicio válido (en config.json)
3. Hora en horario operativo (config.horarios)
4. Disponibilidad en Calendar

**Acciones:**
- Crear evento en Google Calendar
- Registrar en PostgreSQL
- Enviar confirmación WhatsApp

**Response:**
```json
{
  "exito": true,
  "mensaje": "Cita confirmada para 15 de abril 15:00",
  "citaId": "CITA_12345"
}
```

---

## Flujo 4: Cancelar Cita

**Búsqueda:** Usuario + Citas pendientes
**Validación:** ¿Faltan 2+ horas? (ver config.politicas.cancelacion)
**Acción:** Eliminar de Calendar + Actualizar DB
**Respuesta:** Confirmación + Espacio liberado

---

## Flujo 5: Responder Información

**Lógica:** 
```javascript
const tipo = intension; // horarios, precio, ubicacion, etc
const respuesta = config.faq[tipo];
return respuesta;
```

---

## Variables Globales en n8n

```javascript
// Cargar al iniciar
const config = require('./config.json');

// Disponibles en todos los flujos
$config = config;
$horarios = config.horarios;
$servicios = config.servicios;
$politicas = config.politicas;
```

---

## Testing Rápido

**Webhook entrada:**
```bash
curl -X POST http://localhost:5678/webhook/whatsapp \
  -H "Content-Type: application/json" \
  -d '{"mensaje": "Quiero agendar", "userId": "123"}'
```

---

**Ver:** `config.json` para datos específicos.
