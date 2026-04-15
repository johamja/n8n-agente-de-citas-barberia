# 🔗 Cómo Integrar en n8n

## Paso 1: Cargar Archivos

En n8n, crear un nodo **Code** con:

```javascript
const fs = require('fs');

// Cargar prompt
const prompt = fs.readFileSync('./agent-context/prompt.md', 'utf8');

// Cargar config (JSON)
const config = JSON.parse(
  fs.readFileSync('./config/config.json', 'utf8')
);

return {
  prompt: prompt,
  config: config
};
```

---

## Paso 2: Pasar al Modelo de IA

```javascript
// En nodo que llame a Claude/OpenAI/etc

const systemPrompt = `${files.prompt}\n\nCONTEXTO:\n${JSON.stringify(files.config, null, 2)}`;

const response = await llamarModeloIA({
  system: systemPrompt,
  user: $input.first().json.mensaje
});

return response;
```

---

## Paso 3: Procesar Respuesta

```javascript
// Extraer intención de respuesta
const respuesta = response.text;

if (respuesta.includes("cita confirmada")) {
  // Guardar en BD
  // Crear evento en Calendar
}

return respuesta;
```

---

**Total de tokens:** ~5,000 (prompt.md + config.json)
