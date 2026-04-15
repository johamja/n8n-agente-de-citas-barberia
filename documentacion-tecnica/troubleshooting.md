# 🔧 Guía de Troubleshooting

## Problemas Comunes y Soluciones

### 🔴 Problema: Webhook no recibe mensajes de WhatsApp

**Síntomas:**
- No llegan mensajes a n8n
- Logs muestran errores 404

**Soluciones:**

1. **Verificar URL de webhook en Meta Business Manager**
```
Settings → Configuration → Webhooks → Callback URL
```
- Debe ser `https://tu-dominio.com/webhook/whatsapp`
- URL debe ser HTTPS (no HTTP)

2. **Verificar token de verificación**
```bash
# Meta envía GET request con verify_token
# n8n debe responder correctamente
curl -X GET "https://tu-dominio.com/webhook/whatsapp?hub.verify_token=TOKEN&hub.challenge=CHALLENGE"
```

3. **Revisar certificado SSL**
```bash
openssl s_client -connect tu-dominio.com:443
# Verificar que no esté expirado o auto-firmado
```

4. **Ver logs de n8n**
```bash
docker logs -f n8n | grep webhook
```

---

### 🔴 Problema: Las citas no aparecen en Google Calendar

**Síntomas:**
- Usuario recibe confirmación pero evento no se crea
- Error en logs de Google Calendar

**Soluciones:**

1. **Verificar credenciales de Google**
```
n8n UI → Credentials → Google Calendar
- Token debe estar válido
- Probar "Test Connection"
```

2. **Verificar calendario correcto**
```
- En settings.md, confirmar GOOGLE_CALENDAR_ID
- El ID debe ser el del calendario donde se crean citas
```

3. **Revisar permisos de API**
```
Google Cloud Console → APIs & Services
- Calendar API debe estar habilitada
- Scopes deben incluir: calendar.events.create, calendar.events.read
```

4. **Ver logs de flujo**
```
n8n UI → Workflows → [Flujo Agendar] → Execution History
- Revisar el paso de Google Calendar Node
```

---

### 🔴 Problema: Base de datos llena o corrupta

**Síntomas:**
- Errores de conexión a BD
- Queries lentas
- Logs muestran "disk full"

**Soluciones:**

1. **Limpiar datos antiguos**
```sql
DELETE FROM citas WHERE estado = 'cancelada' AND fecha_cancelacion < NOW() - INTERVAL '6 months';
VACUUM; -- PostgreSQL
```

2. **Expandir volumen Docker**
```bash
docker volume ls
docker volume inspect postgres_data

# Si está en disco lleno, expandir partición
df -h
# Agregar espacio al VPS
```

3. **Hacer backup y restaurar**
```bash
docker exec postgres-barberia pg_dump barberia_db > backup.sql
# Restaurar si es necesario
docker exec postgres-barberia psql barberia_db < backup.sql
```

---

### 🔴 Problema: Alto latency en respuestas

**Síntomas:**
- Usuario espera mucho para respuesta
- Timeouts en webhooks

**Soluciones:**

1. **Revisar recursos del VPS**
```bash
top
free -h
iostat 1 5
```

2. **Optimizar flujos de n8n**
- Evitar bucles innecesarios
- Usar batch operations
- Limitar consultas a BD

3. **Aumentar timeouts en n8n**
```
Workflow Settings → Timeout
- Aumentar a 60+ segundos
```

4. **Escalabilidad**
- Si VPS tiene pocos recursos, aumentar CPU/RAM
- O migrar a n8n Cloud (auto-escalable)

---

### 🔴 Problema: Usuario no recibe confirmación de cita

**Síntomas:**
- Cita se crea correctamente
- Mensaje de confirmación no llega

**Soluciones:**

1. **Verificar número de WhatsApp**
```
- Número debe tener formato: +[CÓDIGO_PAÍS][NÚMERO]
- Ejemplo: +541234567890
```

2. **Revisar límites de WhatsApp**
```
- 30 mensajes en 24h (después debe activar "conversation"
- Phone number debe estar verificado
```

3. **Ver logs de flujo de confirmación**
```
n8n UI → Workflows → [Flujo Confirmación] → Execution History
```

4. **Probar manualmente**
```bash
curl -X POST https://graph.instagram.com/v18.0/[PHONE_ID]/messages \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer [ACCESS_TOKEN]" \
  -d '{
    "messaging_product": "whatsapp",
    "to": "1234567890",
    "type": "text",
    "text": {"body": "Prueba"}
  }'
```

---

### 🔴 Problema: Motor NLU no entiende intención

**Síntomas:**
- Usuario dice "Agendar cita" pero sistema dice "No entendí"
- Muchos false negatives

**Soluciones:**

1. **Revisar palabras clave**
```
documentacion-tecnica/flujos-n8n.md → Flujo 2
Agregar más palabras sinónimas
```

2. **Usar regex más flexible**
```javascript
// En lugar de match exacto
const mensaje = input.toLowerCase();
const keywords = ["agendar", "agendar", "reservar", "turno", "cita"];
const encontrado = keywords.some(kw => mensaje.includes(kw));
```

3. **Agregar logging**
```javascript
console.log("Mensaje original:", input);
console.log("Intención detectada:", intención);
console.log("Confianza:", confianza);
```

4. **Crear tabla de ejemplos**
```
logica-negocio/ejemplos-usuarios.md
- Guardar consultas reales de usuarios
- Usar para entrenar NLU
```

---

### 🔴 Problema: Errores 429 (Rate Limit) de APIs

**Síntomas:**
- Mensajes de "Too many requests"
- APIs no responden temporalmente

**Soluciones:**

1. **Google Calendar API**
- Límite: 1000 req/min
- Solución: Cachear disponibilidad por 5 min

2. **WhatsApp API**
- Límite: Según plan
- Solución: Queue de mensajes con delay

3. **Implementar retry logic**
```javascript
async function retryWithBackoff(fn, maxRetries = 3) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fn();
    } catch (error) {
      if (error.status === 429) {
        const delay = Math.pow(2, i) * 1000; // exponential backoff
        await new Promise(resolve => setTimeout(resolve, delay));
      } else {
        throw error;
      }
    }
  }
}
```

---

## Checklist de Debugging

- [ ] Revisar logs de n8n: `docker logs -f n8n`
- [ ] Revisar logs de base de datos
- [ ] Verificar credenciales en `.env`
- [ ] Probar webhooks manualmente con curl
- [ ] Revisar ejecución de workflow en n8n UI
- [ ] Revisar consola de desarrollador (en browser si es UI)
- [ ] Verificar conectividad de red
- [ ] Verificar certificados SSL válidos
- [ ] Revisar rate limits de APIs
- [ ] Comprobar permisos de archivos/carpetas

---

## Recursos Útiles

- [Documentación de n8n](https://docs.n8n.io/)
- [API de Google Calendar](https://developers.google.com/calendar/api)
- [API de WhatsApp](https://www.whatsapp.com/business/developers/)
- [Documentación de Telegram Bot](https://core.telegram.org/bots/api)

---

## Contacto y Escalación

Si el problema no se resuelve:
1. Documentar pasos reproducidos
2. Incluir logs relevantes
3. Contactar al equipo de soporte
4. Email: [SUPPORT_EMAIL]
5. Slack: [SUPPORT_CHANNEL]

---

**Última actualización:** [FECHA]
