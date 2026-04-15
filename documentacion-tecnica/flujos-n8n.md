# 🔄 Flujos de n8n

## Índice de Flujos

- [Flujo 1: Webhook Entrada](#flujo-1-webhook-entrada)
- [Flujo 2: Procesar Intención](#flujo-2-procesar-intencion)
- [Flujo 3: Agendar Cita](#flujo-3-agendar-cita)
- [Flujo 4: Cancelar Cita](#flujo-4-cancelar-cita)
- [Flujo 5: Responder Información](#flujo-5-responder-informacion)

---

## Flujo 1: Webhook Entrada

**Descripción:** Recibe mensajes del usuario desde WhatsApp/Telegram y los enruta al procesamiento.

**ID en n8n:** [A DEFINIR]

**Entrada:**
```json
{
  "message": "Quiero agendar una cita",
  "userId": "123456789",
  "channel": "whatsapp",
  "timestamp": "2024-04-14T10:30:00"
}
```

**Salida:** Pasa el mensaje al Flujo 2

**Nodos incluidos:**
- Webhook (recibir)
- Validación básica
- Enrute al siguiente flujo

---

## Flujo 2: Procesar Intención

**Descripción:** Analiza el mensaje y determina la intención del usuario.

**ID en n8n:** [A DEFINIR]

**Entrada:** Mensaje del Flujo 1

**Lógica NLU:**
```
SI "agendar" O "cita" O "turno" → Intención: AGENDAR
SI "cancelar" O "anular" O "quitar" → Intención: CANCELAR
SI "precio" O "cuánto" O "cuesta" → Intención: CONSULTA_PRECIO
SI "horario" O "abre" O "cierra" → Intención: CONSULTA_HORARIOS
SI "dónde" O "ubicación" O "dirección" → Intención: CONSULTA_UBICACION
SI "servicios" O "qué ofrecen" → Intención: CONSULTA_SERVICIOS
SINO → Intención: SIN_RESOLVER
```

**Salida:** 
```json
{
  "intención": "AGENDAR",
  "confianza": 0.95,
  "entidades": {
    "servicio": "corte",
    "fecha": "2024-04-15",
    "hora": "15:00"
  }
}
```

**Nodos incluidos:**
- Condicional por intención
- Extracción de entidades (fechas, horas, servicios)
- Enrute a flujos específicos

---

## Flujo 3: Agendar Cita

**Descripción:** Valida disponibilidad y crea la cita en Google Calendar y DB.

**ID en n8n:** [A DEFINIR]

**Entrada:** Intención AGENDAR + entidades

**Validaciones:**
1. ¿Usuario registrado? Si no, solicitar nombre/teléfono
2. ¿Servicio válido? Si no, listar servicios
3. ¿Hora en horario de operación? Si no, sugerir horas
4. ¿Disponibilidad en Calendar? Si no, sugerir alternativas

**Salida:**
```json
{
  "exito": true,
  "citaId": "CITA_12345",
  "confirmacion": "Tu cita está confirmada para el 15 de abril a las 15:00",
  "recordatorio": "Te enviaremos un recordatorio 24 horas antes"
}
```

**Nodos incluidos:**
- Consultar DB por usuario
- Validar horarios contra `informacion-negocio.md`
- Consultar disponibilidad Google Calendar
- Crear evento en Calendar
- Registrar en DB
- Enviar confirmación

---

## Flujo 4: Cancelar Cita

**Descripción:** Valida que la cita exista y puede cancelarse, luego procede con la cancelación.

**ID en n8n:** [A DEFINIR]

**Entrada:** Intención CANCELAR + identificación de cita

**Validaciones:**
1. ¿Usuario tiene cita pendiente?
2. ¿Faltan más de 24 horas? (según políticas.md)
3. ¿Cita puede cancelarse?

**Salida:**
```json
{
  "exito": true,
  "mensajeConfirmacion": "Tu cita ha sido cancelada. El slot está disponible para otros clientes.",
  "puedeReservar": true
}
```

**Nodos incluidos:**
- Buscar cita en DB
- Validar tiempo restante
- Eliminar evento de Calendar
- Actualizar estado en DB
- Enviar confirmación

---

## Flujo 5: Responder Información

**Descripción:** Responde preguntas frecuentes del usuario.

**ID en n8n:** [A DEFINIR]

**Entrada:** Intención CONSULTA_* + tipo de consulta

**Fuente de Datos:** `preguntas-frecuentes.md`

**Salida:** Respuesta predefinida

**Nodos incluidos:**
- Búsqueda en preguntas-frecuentes.md
- Formateo de respuesta
- Envío al usuario

---

## Variables Compartidas Globales

```javascript
// Horarios operación
businessHours = {
  "monday": { "open": "09:00", "close": "18:00" },
  "tuesday": { "open": "09:00", "close": "18:00" },
  "wednesday": { "open": "09:00", "close": "18:00" },
  "thursday": { "open": "09:00", "close": "18:00" },
  "friday": { "open": "09:00", "close": "20:00" },
  "saturday": { "open": "10:00", "close": "19:00" },
  "sunday": { "open": null, "close": null } // CERRADO
}

// Duración por servicio (minutos)
serviceDuration = {
  "corte": 30,
  "corte+barba": 45,
  "corte_niños": 25,
  "afeitado": 20,
  "diseño_barba": 20
}
```

---

## Testing

Para cada flujo, se deben realizar tests de:
- Entrada válida
- Entrada inválida
- Casos edge
- Tiempos límite

---

**Última actualización:** [FECHA]
**Responsable:** [NOMBRE]
