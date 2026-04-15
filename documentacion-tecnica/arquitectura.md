# 🏗️ Arquitectura del Sistema

## Vista General

```
┌─────────────┐
│   Usuario   │
│ (WhatsApp/  │
│  Telegram)  │
└──────┬──────┘
       │
       ▼
┌─────────────────────────┐
│   Webhook de Entrada    │
│      (n8n)              │
└──────┬──────────────────┘
       │
       ▼
┌─────────────────────────────────┐
│   Motor de Intenciones (NLU)    │
│  - Agendar cita                 │
│  - Cancelar cita                │
│  - Consultar info               │
└──────┬──────────────────────────┘
       │
       ├──► [Agendar] ──────────────┐
       │                             │
       ├──► [Cancelar] ────────┐    │
       │                       │    │
       └──► [Información] ─┐   │    │
                           │   │    │
                           ▼   ▼    ▼
                    ┌──────────────────────────┐
                    │   Módulo de Lógica      │
                    │  - Validar disponibilidad│
                    │  - Gestionar citas      │
                    │  - Procesar cancelación │
                    │  - Responder preguntas  │
                    └──────┬───────────────────┘
                           │
            ┌──────────────┼──────────────┐
            │              │              │
            ▼              ▼              ▼
        ┌────────┐   ┌──────────┐   ┌─────────┐
        │Calendar│   │ Database │   │ Respuesta│
        │(Google)│   │(n8n DB)  │   │  (Chat)  │
        └────────┘   └──────────┘   └─────────┘
```

## Componentes Principales

### 1. **Webhook de Entrada**
- Recibe mensajes de usuarios (WhatsApp, Telegram, etc.)
- Valida formato y autenticación
- Enruta al motor de procesamiento

### 2. **Motor de Intenciones (NLU)**
Identifica qué quiere hacer el usuario:
- **Palabras clave para agendar:** cita, quiero agendar, necesito turno, etc.
- **Palabras clave para cancelar:** cancelar, anular, quitar cita, etc.
- **Palabras clave para info:** precio, horarios, dónde, dirección, etc.

### 3. **Módulo de Lógica de Citas**
- **Validación de disponibilidad:** Chequea Google Calendar
- **Creación de citas:** Crea evento en calendar + DB
- **Cancelación:** Elimina evento + libera slot
- **Confirmaciones:** Envía confirmaciones al usuario

### 4. **Base de Datos Local (n8n DB)**
Almacena:
- Historial de citas
- Datos de clientes (nombre, teléfono, preferencias)
- Servicios y precios
- Cancelaciones y no-shows

### 5. **Integración Google Calendar**
- Fuente de verdad para disponibilidad
- Crea/actualiza/elimina eventos
- Sincroniza con el barbero

---

## Flujo de Datos: Agendar Cita

```
Usuario: "Quiero agendar una cita mañana a las 3pm"
    ↓
Webhook recibe mensaje
    ↓
Motor NLU identifica: AGENDAR
    ↓
Extrae: [Servicio: Corte], [Fecha: mañana], [Hora: 15:00]
    ↓
Valida disponibilidad en Google Calendar
    ↓
¿Disponible? 
    → SÍ: Crea evento + registra en DB → Confirma al usuario
    → NO: Ofrece alternativas de horarios
```

---

## Flujo de Datos: Cancelar Cita

```
Usuario: "Necesito cancelar mi cita del viernes"
    ↓
Webhook recibe mensaje
    ↓
Motor NLU identifica: CANCELAR
    ↓
Busca cita del usuario en DB
    ↓
¿Cita existe?
    → SÍ: Verifica política (¿24h?)
         → Cancela evento de Calendar
         → Actualiza DB
         → Notifica usuario
    → NO: Informa que no tiene cita
```

---

## Flujo de Datos: Consulta de Información

```
Usuario: "¿A qué hora cierran?"
    ↓
Webhook recibe mensaje
    ↓
Motor NLU identifica: INFORMACIÓN
    ↓
Determina tipo: HORARIOS
    ↓
Recupera respuesta de preguntas-frecuentes.md
    ↓
Envía respuesta al usuario
```

---

## Tecnologías

| Componente | Tecnología |
|-----------|------------|
| Orquestación | n8n (Cloud) |
| Base de Datos | PostgreSQL / n8n DB |
| Calendar | Google Calendar API |
| Chat | WhatsApp/Telegram API |
| Hosting | n8n Cloud / VPS |

---

## Estado Actual

**Fase:** Diseño arquitectónico
**Próximos pasos:** Implementar flujos en n8n
