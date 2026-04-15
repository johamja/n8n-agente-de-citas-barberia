# Configurar OAuth para Google Calendar y otras APIs

## Requisitos

- Cuenta de Google
- Acceso a [Google Cloud Console](https://console.cloud.google.com)

---

## Paso 1: Crear proyecto en Google Cloud

1. Abre [console.cloud.google.com](https://console.cloud.google.com)
2. En la barra superior, haz clic en el selector de proyectos
3. Clic en **Nuevo proyecto**
4. Asigna un nombre y clic en **Crear**

---

## Paso 2: Habilitar la API requerida

1. Ve a **APIs y servicios > Biblioteca**
2. Busca la API que necesitas (ej. `Google Calendar API`)
3. Clic en el resultado y luego en **Habilitar**

---

## Paso 3: Configurar la pantalla de consentimiento OAuth

1. Ve a **APIs y servicios > Pantalla de consentimiento de OAuth**
2. Selecciona el tipo de usuario:
   - **Interno**: solo usuarios de tu organización Google Workspace
   - **Externo**: cualquier cuenta de Google (requiere verificacion si publicas la app)
3. Completa los campos obligatorios:
   - Nombre de la aplicacion
   - Correo de soporte
   - Correo de contacto del desarrollador
4. Clic en **Guardar y continuar**
5. En la seccion **Permisos (Scopes)**, agrega los scopes necesarios (ej. `https://www.googleapis.com/auth/calendar`)
6. Clic en **Guardar y continuar**
7. En **Usuarios de prueba**, agrega los correos que podran usar la app mientras este en modo de prueba
8. Clic en **Guardar y continuar**

---

## Paso 4: Crear credenciales OAuth

1. Ve a **APIs y servicios > Credenciales**
2. Clic en **Crear credenciales > ID de cliente de OAuth**
3. Selecciona el tipo de aplicacion:
   - **Aplicacion web**: para apps con servidor backend o n8n con webhook
   - **Aplicacion de escritorio**: para scripts locales o flujos simples
4. Agrega los **URIs de redireccionamiento autorizados**
   - Para n8n local: `http://localhost:5678/rest/oauth2-credential/callback`
   - Para n8n en produccion: `https://tu-dominio.com/rest/oauth2-credential/callback`
5. Clic en **Crear**
6. Descarga el archivo JSON con las credenciales o copia el **Client ID** y el **Client Secret**

---

## Paso 5: Usar las credenciales en n8n

1. En n8n, ve a **Credenciales > Nueva credencial**
2. Busca el servicio (ej. `Google Calendar OAuth2 API`)
3. Pega el **Client ID** y el **Client Secret**
4. Clic en **Conectar con Google** y autoriza el acceso

---

## Modo de prueba vs. Verificacion de Google

Mientras la app este en modo **Prueba**, solo los correos agregados como usuarios de prueba pueden autenticar.

Si necesitas que cualquier usuario pueda autenticar (app publica), debes solicitar la verificacion de Google:

1. Ve a **Pantalla de consentimiento de OAuth > Publicar aplicacion**
2. Google revisara el uso de los scopes y puede pedir documentacion adicional
3. Para scopes sensibles (acceso a calendario, correo, drive) el proceso puede tardar dias o semanas

Para uso interno o proyectos propios, quedarse en modo prueba es suficiente y no requiere verificacion.

---

## Scopes comunes

| Servicio          | Scope                                                    | Acceso             |
|-------------------|----------------------------------------------------------|--------------------|
| Google Calendar   | `.../auth/calendar`                                      | Lectura y escritura |
| Google Calendar   | `.../auth/calendar.readonly`                             | Solo lectura        |
| Gmail             | `.../auth/gmail.send`                                    | Enviar correos      |
| Google Sheets     | `.../auth/spreadsheets`                                  | Lectura y escritura |
| Google Drive      | `.../auth/drive.file`                                    | Archivos creados por la app |

Los scopes completos tienen el prefijo `https://www.googleapis.com/auth/`.

---

## Solucion de problemas frecuentes

**Error: redirect_uri_mismatch**
El URI de redireccionamiento en las credenciales no coincide con el que usa la aplicacion. Verifica que el URI en Google Cloud sea exactamente igual al que n8n envia.

**Error: Access blocked - app not verified**
La app esta en modo externo y el usuario que intenta autenticar no esta en la lista de usuarios de prueba. Agrega su correo en la pantalla de consentimiento.

**Token expirado**
Los tokens de acceso expiran en 1 hora. n8n renueva el token automaticamente usando el refresh token, siempre que el scope `offline_access` este habilitado o que la app solicite acceso de tipo `offline`.
