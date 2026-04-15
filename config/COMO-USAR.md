# 📖 Cómo Usar la Estructura Optimizada

## ⚡ Resumen Rápido

Tienes dos carpetas ahora:

| Carpeta | Uso | Tokens |
|---------|-----|--------|
| `logica-negocio/` | Referencia humana (archivos completos) | Alto |
| `config/` | Para n8n (optimizado) | **Bajo** ✅ |

**Recomendación:** Usa `config/` para n8n, `logica-negocio/` como documentación.

---

## 🚀 Empezar Rápido

### 1. Configurar Ambiente
```bash
cd /tu-carpeta/n8n-barberia
cp config/.env.example .env
# Editar .env con tus credenciales
```

### 2. Iniciar Docker
```bash
docker-compose up -d
# Esperar ~30 segundos
# Acceder a http://localhost:5678
```

### 3. Cargar config.json en n8n

**Opción A: Vía Nodo Code**
```javascript
// En un nodo Code de n8n
const fs = require('fs');
const config = JSON.parse(
  fs.readFileSync('./config/config.json', 'utf8')
);
return config;
```

**Opción B: Vía Variable Global**
```javascript
// En Settings de n8n
const config = require('./config/config.json');
$config = config;
```

---

## 📝 Flujo de Actualización

### Si Cambias Información del Negocio:

**OPCIÓN 1 (Fácil):** Editar directamente `config/config.json`
```json
{
  "servicios": [
    {"nombre": "Nuevo Servicio", "precio": 50000}
  ]
}
```

**OPCION 2 (Documentado):** Editar `logica-negocio/*.md` + Sincronizar a JSON
```bash
# (Crear un script para auto-sincronizar si lo necesitas)
npm run sync-config
```

---

## 🎯 Estructura de Carpetas (Nuevo)

```
n8n-barberia/
├── config/                      ← 🆕 NUEVA CARPETA (OPTIMIZADA)
│   ├── config.json             ← Archivo maestro (TODO)
│   ├── README.md               ← Cómo usar
│   ├── COMO-USAR.md            ← Este archivo
│   ├── arquitectura-slim.md    ← Diseño resumido
│   ├── flujos-slim.md          ← Workflows resumidos
│   ├── integraciones-slim.md   ← APIs resumidas
│   ├── deployment-slim.md      ← Deploy resumido
│   └── .env.example            ← Template variables
│
├── logica-negocio/              ← Referencia (ORIGINAL)
│   ├── informacion-negocio.md
│   ├── servicios.md
│   ├── horarios-disponibilidad.md
│   └── preguntas-frecuentes.md
│
└── documentacion-tecnica/       ← Completa (OPCIONAL)
    ├── arquitectura.md
    ├── flujos-n8n.md
    └── ...
```

---

## 💡 Tips Importantes

### Tip 1: Config.json es Dinámico
```javascript
// En n8n, puedes acceder a config en runtime
const horarios = $config.horarios;
const servicios = $config.servicios.filter(s => s.disponible);
```

### Tip 2: Mantén .env Seguro
```bash
# En .gitignore
.env
config/.env

# Commitear solo ejemplo
config/.env.example
```

### Tip 3: Sincroniza si Cambias Ambas
```bash
# Si editas logica-negocio/servicios.md
# Actualiza también config/config.json
# Así n8n siempre tiene datos al día
```

---

## 📊 Ahorro de Tokens

**Antes (Original):**
- 13 archivos .md de documentación
- Aprox. 25,000 tokens por carga

**Ahora (Optimizado):**
- 1 archivo config.json + 4 archivos slim
- Aprox. 8,000 tokens por carga

**Ahorro: 68%** 🎉

---

## 🔧 Troubleshooting

**Problema:** n8n no encuentra config.json
```
Solución: Verificar ruta en nodo Code
const config = require('./config/config.json');
// o usar ruta absoluta
```

**Problema:** Cambios en config.json no se reflejan
```
Solución: Recargar el workflow o reiniciar n8n
docker restart n8n
```

---

## ✅ Checklist de Configuración

- [ ] Copiar `config/.env.example` a `.env`
- [ ] Llenar credenciales en `.env`
- [ ] Iniciar Docker: `docker-compose up -d`
- [ ] Acceder a n8n en `http://localhost:5678`
- [ ] Cargar `config.json` en nodo Code
- [ ] Crear primer workflow
- [ ] Conectar APIs (Google Calendar, WhatsApp)
- [ ] Hacer prueba end-to-end

---

## 📞 Próximos Pasos

1. **Crear primer workflow** → Ver `flujos-slim.md`
2. **Configurar APIs** → Ver `integraciones-slim.md`
3. **Hacer deploy** → Ver `deployment-slim.md`

---

**Última actualización:** 2026-04-14
