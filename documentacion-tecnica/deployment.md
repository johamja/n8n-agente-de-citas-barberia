# 🚀 Deployment y Configuración

## Opciones de Deployment

### Opción 1: n8n Cloud (RECOMENDADO)

**Ventajas:**
- ✅ Sin mantenimiento de servidor
- ✅ Actualización automática
- ✅ SSL automático
- ✅ Backups automáticos
- ✅ Escalado automático

**Pasos:**
1. Crear cuenta en [n8n.io](https://n8n.io)
2. Crear nueva instancia Cloud
3. Importar flujos desde archivos o GitHub
4. Configurar variables de entorno
5. Conectar integraciones (Google, WhatsApp, etc.)
6. Activar workflows

**Costo:** ~$25-100/mes según uso

---

### Opción 2: VPS Propio (Docker)

**Ventajas:**
- ✅ Control total
- ✅ Más económico
- ✅ Datos locales

**Requisitos:**
- VPS Linux (Ubuntu 20.04+)
- Docker y Docker Compose
- Dominio propio con SSL

**Pasos:**

1. **Preparar VPS**
```bash
apt update && apt upgrade -y
curl -fsSL https://get.docker.com | sh
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

2. **Clonar/preparar proyecto**
```bash
git clone <tu-repo> /opt/n8n-barberia
cd /opt/n8n-barberia
```

3. **Configurar .env**
```bash
cp .env.example .env
# Editar .env con valores reales
nano .env
```

4. **Configurar docker-compose.yml**
```yaml
version: '3.8'

services:
  n8n:
    image: n8nio/n8n:latest
    container_name: n8n
    ports:
      - "5678:5678"
    environment:
      - DB_TYPE=sqlite
      - N8N_HOST=tu-dominio.com
      - N8N_PROTOCOL=https
      - WEBHOOK_URL=https://tu-dominio.com/
      - TZ=America/Argentina/Buenos_Aires
    volumes:
      - ./data:/home/node/.n8n
      - ./workflows:/home/node/.n8n/workflows
    restart: unless-stopped
    networks:
      - n8n-net

  postgres:
    image: postgres:15
    container_name: postgres-barberia
    environment:
      POSTGRES_DB: barberia_db
      POSTGRES_USER: barberia_user
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - ./postgres_data:/var/lib/postgresql/data
    restart: unless-stopped
    networks:
      - n8n-net

networks:
  n8n-net:
    driver: bridge
```

5. **Iniciar servicios**
```bash
docker-compose up -d
```

6. **Configurar Nginx como proxy**
```nginx
server {
    listen 80;
    server_name tu-dominio.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;
    server_name tu-dominio.com;
    
    ssl_certificate /etc/letsencrypt/live/tu-dominio.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/tu-dominio.com/privkey.pem;
    
    location / {
        proxy_pass http://localhost:5678;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

---

## Configuración Post-Deployment

### 1. Importar Flujos
```bash
# Desde la UI de n8n
- Settings → Import from File
- Seleccionar archivos de workflows
```

### 2. Conectar Integraciones
**En n8n UI:**
1. Ir a "Credentials"
2. Crear credenciales para cada servicio:
   - Google Calendar
   - WhatsApp Business
   - Telegram
   - PostgreSQL

### 3. Configurar Webhooks
1. Obtener URLs de webhook de cada flujo
2. Actualizar:
   - Meta Webhook URL: https://tu-dominio.com/webhook/whatsapp
   - Telegram Webhook: https://tu-dominio.com/webhook/telegram

### 4. Testing
```bash
# Test de webhook
curl -X POST https://tu-dominio.com/webhook/whatsapp \
  -H "Content-Type: application/json" \
  -d '{"test": true}'
```

---

## Monitoreo y Mantenimiento

### Logs
```bash
# Si usa Docker
docker logs -f n8n

# Si es self-hosted
tail -f logs/n8n.log
```

### Backups
```bash
# Backup diario
0 2 * * * docker exec n8n tar -czf /home/node/.n8n/backup-$(date +\%Y\%m\%d).tar.gz /home/node/.n8n/workflows
```

### Updates
```bash
# Actualizar imagen de n8n
docker pull n8nio/n8n:latest
docker-compose up -d n8n
```

---

## Troubleshooting

### Error: "Cannot connect to Google Calendar"
- Verificar API Key en .env
- Verificar permisos de proyecto GCP
- Reintentar con token refreshed

### Error: "WhatsApp webhook not responding"
- Verificar URL en Meta Business Manager
- Verificar certificado SSL válido
- Revisar logs de n8n

### Performance lento
- Revisar logs de base de datos
- Aumentar CPU/RAM del VPS
- Optimizar queries en workflows

---

## Certificado SSL (Let's Encrypt)

```bash
# Instalar Certbot
apt install certbot python3-certbot-nginx -y

# Obtener certificado
certbot certonly --nginx -d tu-dominio.com

# Renovación automática
systemctl enable certbot.timer
systemctl start certbot.timer
```

---

## Checklist de Deployment

- [ ] Entorno de producción preparado
- [ ] Variables de entorno configuradas
- [ ] Base de datos creada y testeada
- [ ] SSL/HTTPS configurado
- [ ] Backups configurados
- [ ] Monitoreo habilitado
- [ ] Flujos importados y testeados
- [ ] Webhooks configurados en proveedores
- [ ] Pruebas end-to-end completadas

---

**Última actualización:** [FECHA]
**Responsable:** [NOMBRE]
