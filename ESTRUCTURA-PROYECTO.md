# 📁 Estructura del Proyecto n8n Barbería

```
n8n-barberia/
├── docker-compose.yml          # Configuración Docker (n8n + PostgreSQL)
├── .env                        # Variables de entorno (NO COMMITEAR)
├── .env.example                # Plantilla de variables (COMMITEAR)
├── .gitignore                  # Archivos ignorados por Git
│
├── logica-negocio/             # 💼 INFORMACIÓN DEL NEGOCIO
│   ├── README.md
│   ├── informacion-negocio.md  # Datos principales (ubicación, horarios, servicios)
│   ├── servicios.md            # Catálogo de servicios y precios
│   ├── horarios-disponibilidad.md  # Horarios y duración de servicios
│   ├── politicas.md            # Políticas de cancelación, pago, etc.
│   └── preguntas-frecuentes.md # FAQs y respuestas predefinidas
│
├── documentacion-tecnica/      # 🛠️ DOCUMENTACIÓN TÉCNICA
│   ├── README.md
│   ├── arquitectura.md         # Diseño del sistema completo
│   ├── flujos-n8n.md           # Especificación de workflows
│   ├── integraciones.md        # Google Calendar, WhatsApp, Telegram, BD
│   ├── base-datos.md           # (Crear) Esquema de tablas
│   ├── api-endpoints.md        # (Crear) Webhooks y endpoints
│   ├── variables-ambiente.md   # Variables .env necesarias
│   ├── deployment.md           # Guía de deploy (Cloud vs VPS)
│   └── troubleshooting.md      # Problemas comunes y soluciones
│
├── workflows/                  # 🔄 ARCHIVOS DE WORKFLOWS DE N8N
│   ├── 01-webhook-entrada.json
│   ├── 02-procesar-intencion.json
│   ├── 03-agendar-cita.json
│   ├── 04-cancelar-cita.json
│   └── 05-responder-info.json
│
├── data/                       # 📊 DATOS Y CONFIGURACIÓN
│   ├── calendario/             # (Para exportar disponibilidad)
│   └── respaldos/              # Backups periódicos
│
└── README.md                   # Este archivo + guía general
```

---

## 🎯 Fase Actual del Proyecto

**Estado:** 🟡 Diseño y Planificación

**Completado:**
- ✅ Estructura de carpetas definida
- ✅ Información de negocio documentada
- ✅ Arquitectura diseñada
- ✅ Flujos especificados
- ✅ Integraciones mapeadas

**Por hacer:**
- ⏳ Implementar flujos en n8n
- ⏳ Configurar integraciones
- ⏳ Testing y QA
- ⏳ Deployment

---

## 📋 Convenciones del Proyecto

### Para Información de Negocio
- ✅ Todo en carpeta `logica-negocio/`
- ✅ Actualizaciones sin código
- ✅ Formatos: Markdown (.md) + Tablas

### Para Documentación Técnica
- ✅ Todo en carpeta `documentacion-tecnica/`
- ✅ Incluir ejemplos de código/JSON
- ✅ Links a documentación externa

### Para Workflows de n8n
- ✅ Exportar como JSON
- ✅ Nombrar con prefijo numérico (01-, 02-, etc.)
- ✅ Comentarios internos en nodos

---

## 🚀 Próximos Pasos Recomendados

1. **Llenar información de negocio**
   ```
   Editar archivos en logica-negocio/
   - Reemplazar placeholders [...]
   - Confirmar horarios y servicios
   ```

2. **Configurar ambiente de desarrollo**
   ```
   cp .env.example .env
   docker-compose up -d
   Acceder a http://localhost:5678
   ```

3. **Crear primeros workflows**
   ```
   Empezar por: Webhook entrada → Procesar intención
   ```

4. **Integrar Google Calendar**
   ```
   Configurar credenciales en n8n
   Probar crear evento de prueba
   ```

5. **Testing**
   ```
   Probar flujo completo end-to-end
   Validar respuestas
   ```

---

## 📞 Contacto y Soporte

**Propietario del Proyecto:** [NOMBRE]
**Responsable Técnico:** [NOMBRE]
**Email:** [EMAIL]
**Fecha de Inicio:** 2024-04-14

---

**Última actualización:** 2024-04-14
