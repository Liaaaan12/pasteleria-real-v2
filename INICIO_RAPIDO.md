# 🚀 Guía de Inicio Rápido - Pastelería Real

Esta guía te ayudará a poner en marcha el sistema en **menos de 5 minutos**.

---

## ✅ Paso 1: Verificar Requisitos

Abre una terminal y ejecuta:

```bash
java -version
node -v
```

**Debes ver:**
- Java 17 o superior
- Node.js 18 o superior

**Si no los tienes instalados:**
- Java: https://www.oracle.com/java/technologies/downloads/
- Node.js: https://nodejs.org/

---

## 📂 Paso 2: Ubicarte en el Proyecto

```bash
cd pasteleria-real
```

---

## 🔑 Paso 3: Dar Permisos (Solo la primera vez)

```bash
chmod +x start-all.sh start-api.sh start-web.sh
```

---

## 🎯 Paso 4: Iniciar el Sistema

### Opción A: Iniciar Todo (Recomendado)

```bash
./start-all.sh
```

Este comando:
- ✅ Compila el backend
- ✅ Instala dependencias del frontend
- ✅ Inicia ambos servicios automáticamente

**Tiempo estimado:** 1-2 minutos

### Opción B: Iniciar por Separado

**Terminal 1 - Backend:**
```bash
./start-api.sh
```

**Terminal 2 - Frontend:**
```bash
./start-web.sh
```

---

## 🌐 Paso 5: Abrir el Navegador

Una vez que veas el mensaje "Sistema completo iniciado exitosamente", abre:

```
http://localhost:5173
```

---

## 👤 Paso 6: Iniciar Sesión

Usa uno de estos usuarios:

**SuperAdmin (acceso total):**
- Correo: `ana.maria@gmail.cl`
- Contraseña: `password123`

**Administrador:**
- Correo: `luis.felipe@gmail.com`
- Contraseña: `password123`

**Cliente:**
- Correo: `claudia.isabel@duoc.cl`
- Contraseña: `password123`

---

## 🎉 ¡Listo!

Ya puedes usar el sistema completo de Pastelería Real.

---

## 📍 URLs Importantes

| Servicio | URL | Descripción |
|----------|-----|-------------|
| **Frontend** | http://localhost:5173 | Interfaz de usuario |
| **Backend API** | http://localhost:8080 | API REST |
| **Swagger UI** | http://localhost:8080/swagger-ui.html | Documentación API |
| **H2 Console** | http://localhost:8080/h2-console | Base de datos |

---

## 🛑 Detener el Sistema

Presiona `Ctrl+C` en la terminal donde ejecutaste el script.

---

## ❓ Problemas Comunes

### "Java no está instalado"
**Solución:** Instala Java 17 desde https://www.oracle.com/java/technologies/downloads/

### "Node.js no está instalado"
**Solución:** Instala Node.js desde https://nodejs.org/

### "Puerto 8080 ya está en uso"
**Solución:** 
```bash
# En Linux/Mac
lsof -ti:8080 | xargs kill -9

# En Windows
netstat -ano | findstr :8080
taskkill /PID <PID> /F
```

### "No se puede conectar al backend"
**Solución:** Asegúrate de que el backend esté ejecutándose en http://localhost:8080

---

## 📚 Más Información

- **README completo:** `README.md`
- **Documentación del backend:** `api/README.md`
- **Documentación del frontend:** `web/README.md`
- **Manual de usuario:** `docs/MANUAL_USUARIO.md`
- **Documentación técnica:** `docs/DOCUMENTO_INTEGRACION.md`

---

## 💡 Comandos Alternativos

Si prefieres usar npm:

```bash
# Iniciar todo
npm start

# Iniciar solo backend
npm run start:api

# Iniciar solo frontend
npm run start:web
```

---

**¿Necesitas ayuda?** Revisa el archivo `README.md` para más detalles.
