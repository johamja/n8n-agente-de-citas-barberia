# 🤖 Contexto para Agente IA

Carpeta con lo MÍNIMO necesario para que el agente IA funcione.

## Archivos

- **`prompt.md`** - Prompt inicial optimizado para el agente
- **`config.json`** - Datos del negocio (proporcionar externamente)

## Cómo Usar

En n8n o tu servicio de IA:

```javascript
const prompt = fs.readFileSync('./agent-context/prompt.md', 'utf8');
const config = fs.readFileSync('./config/config.json', 'utf8');

const mensaje_sistema = prompt + "\n\nCONTEXTO DEL NEGOCIO:\n" + config;
```

Luego pasar `mensaje_sistema` al modelo de IA.

---

**Consumo:** ~5,000 tokens (prompt.md + config.json)
