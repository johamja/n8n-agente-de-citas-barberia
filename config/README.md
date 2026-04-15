# ⚙️ Carpeta de Configuración - config/

Esta carpeta contiene la información estructurada del negocio en formato JSON, optimizada para consumo mínimo de tokens y máxima eficiencia.

## 📋 Archivos

### `config.json` (Principal)
Archivo maestro con TODA la información del negocio en formato JSON:
- Datos generales (nombre, ubicación, teléfono)
- Horarios de operación
- Servicios y precios
- Políticas de cancelación y pago
- Personal disponible
- FAQs básicas
- Integraciones

**Ventaja:** Un solo archivo que n8n puede cargar y parsear rápidamente.

---

## 🚀 Cómo Usarlo en n8n

### Opción 1: Cargar en Memoria (Recomendado)
```javascript
// En n8n, usar un nodo HTTP o de lectura de archivo
const config = require('./config.json');

// Acceder a datos
const horarios = config.horarios;
const servicios = config.servicios;
const politicas = config.politicas;
```

### Opción 2: Vía REST API
```bash
curl http://localhost:5678/config.json
```

### Opción 3: Variable de Entorno
```bash
export CONFIG_PATH="/config/config.json"
# n8n carga el archivo al iniciar
```

---

## 📝 Estructura JSON

```json
{
  "negocio": {...},      // Datos básicos
  "horarios": {...},     // Horarios por día
  "servicios": [...],    // Array de servicios
  "politicas": {...},    // Todas las políticas
  "metodos_pago": [...], // Métodos de pago
  "personal": [...],     // Disponibilidad del personal
  "faq": {...},          // Respuestas rápidas
  "integraciones": {...} // Config de APIs
}
```

---

## ✏️ Actualizar Información

**Para cambios rápidos:**
- Editar directamente `config.json`
- No requiere recargar n8n

**Para cambios complejos:**
- Mantener también `logica-negocio/` archivos `.md` para referencia humana
- Sincronizar automáticamente si es posible

---

## 📊 Comparativa de Tokens

| Método | Archivos | Tokens Aprox | Costo |
|--------|----------|-------------|-------|
| Original | 13 MD + 1 JSON | ~25,000 | Alto |
| **Este (config)** | 1 JSON + 3 MD slim | ~8,000 | **Bajo** |
| Solo config.json | 1 JSON | ~3,000 | **Mínimo** |

**Ahorro:** 68-88% en consumo de tokens

---

## 🔄 Sincronización

Si actualizas `logica-negocio/*.md`, sincroniza con:
```bash
# Script para convertir MD a JSON (crear si es necesario)
npm run sync-config
```

---

## 🛠️ Cómo Cargar en n8n

### Método 1: Nodo de Código
```javascript
// Usar en un nodo Code de n8n
const fs = require('fs');
const config = JSON.parse(fs.readFileSync('./config/config.json', 'utf8'));

return {
  config: config,
  horarios: config.horarios,
  servicios: config.servicios
};
```

### Método 2: Nodo HTTP
```
GET http://tu-servidor/config/config.json
```

### Método 3: Variable Global
```javascript
// En n8n, crear variable global
$configs = JSON.parse(configJson);
```

---

**Última actualización:** 2026-04-14
