# 🎂 Pastelería Real - Sistema Completo

Sistema de gestión completo para Pastelería Real, que incluye Backend API (Spring Boot) y Frontend Web (React + TypeScript) en un solo repositorio.

---

## 📋 Tabla de Contenidos

- [Descripción](#-descripción)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Requisitos Previos](#-requisitos-previos)
- [Instalación Rápida](#-instalación-rápida)
- [Formas de Iniciar el Proyecto](#-formas-de-iniciar-el-proyecto)
- [Usuarios de Prueba](#-usuarios-de-prueba)
- [Tecnologías](#-tecnologías)
- [Documentación](#-documentación)
- [Características](#-características)

---

## 📖 Descripción

**Pastelería Real** es un sistema completo de gestión para una pastelería que permite:

- 🛒 Catálogo de productos con carrito de compras
- 👥 Gestión de usuarios con diferentes roles
- 🔐 Autenticación segura con JWT
- 📦 Administración de inventario
- 🏷️ Gestión de categorías
- 📊 Panel de administración

El sistema está dividido en dos componentes que trabajan juntos:

- **Backend (API)**: Servidor Spring Boot que expone servicios REST
- **Frontend (Web)**: Aplicación React que consume la API

---

## 📁 Estructura del Proyecto

```
pasteleria-real/
├── api/                    # Backend - Spring Boot
│   ├── src/
│   │   └── main/
│   │       ├── java/       # Código fuente Java
│   │       └── resources/  # Configuración
│   ├── pom.xml            # Dependencias Maven
│   └── README.md          # Documentación del backend
│
├── web/                    # Frontend - React
│   ├── src/
│   │   ├── components/    # Componentes React
│   │   ├── pages/         # Páginas
│   │   ├── services/      # Servicios API
│   │   └── context/       # Contextos (Auth, Cart)
│   ├── package.json       # Dependencias npm
│   └── README.md          # Documentación del frontend
│
├── docs/                   # Documentación
│   ├── DOCUMENTO_INTEGRACION.md
│   └── MANUAL_USUARIO.md
│
├── start-all.sh           # ⭐ Iniciar todo (recomendado)
├── start-api.sh           # Iniciar solo backend
├── start-web.sh           # Iniciar solo frontend
├── package.json           # Scripts npm del proyecto
└── README.md              # Este archivo
```

---

## ✅ Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

### Para el Backend
- **Java 17 o superior** ([Descargar](https://www.oracle.com/java/technologies/downloads/))
  ```bash
  java -version
  # Debe mostrar: java version "17" o superior
  ```

### Para el Frontend
- **Node.js 18 o superior** ([Descargar](https://nodejs.org/))
  ```bash
  node -v
  # Debe mostrar: v18.x.x o superior
  ```

### Verificación Rápida
```bash
# Verificar Java
java -version

# Verificar Node.js
node -v

# Verificar npm
npm -v
```

---

## 🚀 Instalación Rápida

### Opción 1: Clonar desde GitHub

```bash
# Clonar el repositorio
git clone https://github.com/Liaaaan12/Pasteleria-real-.git
cd Pasteleria-real-

# Dar permisos de ejecución a los scripts
chmod +x start-all.sh start-api.sh start-web.sh
```

### Opción 2: Descomprimir archivo

```bash
# Si tienes el archivo comprimido
tar -xzf pasteleria-real.tar.gz
cd pasteleria-real

# Dar permisos de ejecución a los scripts
chmod +x start-all.sh start-api.sh start-web.sh
```

---

## 🎯 Formas de Iniciar el Proyecto

### ⭐ Método 1: Iniciar Todo (Recomendado)

Este método inicia automáticamente el backend y el frontend en un solo comando:

```bash
./start-all.sh
```

**¿Qué hace este script?**
1. ✅ Verifica que Java y Node.js estén instalados
2. 📦 Compila el backend
3. 📥 Instala dependencias del frontend (si es necesario)
4. 🚀 Inicia el backend en segundo plano
5. ⏳ Espera a que el backend esté listo
6. 🚀 Inicia el frontend
7. ✅ Muestra las URLs de acceso

**Resultado:**
- 🌐 Backend API: `http://localhost:8080`
- 🌐 Frontend Web: `http://localhost:5173`

**Para detener:** Presiona `Ctrl+C`

---

### Método 2: Usando npm

Si tienes npm instalado, puedes usar comandos más cortos:

```bash
# Iniciar todo
npm start

# O iniciar cada parte por separado
npm run start:api    # Solo backend
npm run start:web    # Solo frontend
```

---

### Método 3: Iniciar por Separado

#### Opción A: Dos terminales

**Terminal 1 - Backend:**
```bash
./start-api.sh
```

**Terminal 2 - Frontend:**
```bash
./start-web.sh
```

#### Opción B: Manualmente

**Backend:**
```bash
cd api
./mvnw spring-boot:run
```

**Frontend:**
```bash
cd web
npm install  # Solo la primera vez
npm run dev
```

---

## 🌐 Acceder al Sistema

Una vez iniciado, abre tu navegador en:

### Frontend (Interfaz de Usuario)
```
http://localhost:5173
```

### Backend (API y Documentación)

**Swagger UI** (Documentación interactiva de la API):
```
http://localhost:8080/swagger-ui.html
```

**H2 Console** (Base de datos):
```
http://localhost:8080/h2-console
```
- JDBC URL: `jdbc:h2:mem:pasteleriadb`
- Usuario: `sa`
- Password: (dejar vacío)

---

## 👥 Usuarios de Prueba

El sistema viene con usuarios precargados para probar diferentes roles:

| Correo | Contraseña | Rol | Permisos |
|--------|-----------|-----|----------|
| ana.maria@gmail.cl | password123 | **SuperAdmin** | Acceso total al sistema |
| luis.felipe@gmail.com | password123 | **Administrador** | Gestión de productos y categorías |
| claudia.isabel@duoc.cl | password123 | **Cliente** | Comprar productos |

### Cómo iniciar sesión:

1. Abre `http://localhost:5173`
2. Haz clic en **"Iniciar Sesión"**
3. Ingresa uno de los correos y contraseña de arriba
4. ¡Listo! Ya puedes usar el sistema

---

## 🛠️ Tecnologías

### Backend (API)
- **Spring Boot 3.4.0** - Framework principal
- **Spring Security** - Autenticación y autorización
- **JWT** - Tokens de autenticación
- **Spring Data JPA** - Persistencia de datos
- **H2 Database** - Base de datos en memoria
- **Swagger/OpenAPI** - Documentación de API
- **Lombok** - Reducción de código boilerplate
- **Maven** - Gestión de dependencias

### Frontend (Web)
- **React 19** - Biblioteca de UI
- **TypeScript** - Tipado estático
- **Vite** - Build tool y dev server
- **React Router** - Enrutamiento
- **Axios** - Cliente HTTP
- **Bootstrap 5** - Framework CSS
- **Vitest** - Testing

---

## 📚 Documentación

### Documentación Incluida

- **`api/README.md`** - Documentación detallada del backend
- **`web/README.md`** - Documentación detallada del frontend
- **`docs/DOCUMENTO_INTEGRACION.md`** - Documentación técnica de integración
- **`docs/MANUAL_USUARIO.md`** - Manual de usuario con pantallazos

### Documentación Interactiva

**Swagger UI** - Prueba todos los endpoints de la API:
```
http://localhost:8080/swagger-ui.html
```

---

## ✨ Características

### 🔐 Seguridad
- Autenticación JWT con expiración de 24 horas
- Control de acceso basado en roles (RBAC)
- 4 niveles de usuarios: SuperAdmin, Administrador, Vendedor, Cliente
- Validación de datos en backend y frontend
- CORS configurado

### 📦 Gestión de Productos
- CRUD completo de productos
- Filtrado por categorías
- Control de stock
- Imágenes de productos
- Búsqueda y filtros

### 🛒 Carrito de Compras
- Agregar/eliminar productos
- Modificar cantidades
- Cálculo automático de totales
- Persistencia en localStorage

### 👥 Gestión de Usuarios
- Registro de nuevos usuarios
- Perfiles de usuario
- Múltiples direcciones
- Roles y permisos

### 📊 Panel de Administración
- Gestión de productos (según rol)
- Gestión de categorías (admin)
- Estadísticas (futuro)
- Gestión de usuarios (superadmin)

---

## 🔧 Comandos Útiles

### Scripts Disponibles

```bash
# Iniciar todo el sistema
npm start
./start-all.sh

# Iniciar solo backend
npm run start:api
./start-api.sh

# Iniciar solo frontend
npm run start:web
./start-web.sh

# Instalar todas las dependencias
npm run install:all

# Compilar todo
npm run build:all

# Compilar solo backend
npm run build:api

# Compilar solo frontend
npm run build:web

# Ejecutar tests del backend
npm run test:api

# Ejecutar tests del frontend
npm run test:web

# Limpiar todo
npm run clean
```

---

## 🐛 Solución de Problemas

### El backend no inicia

**Problema:** Error al ejecutar `./start-api.sh`

**Soluciones:**
1. Verificar que Java 17+ esté instalado: `java -version`
2. Verificar que el puerto 8080 no esté en uso
3. Revisar los logs en `/tmp/api.log`

### El frontend no inicia

**Problema:** Error al ejecutar `./start-web.sh`

**Soluciones:**
1. Verificar que Node.js 18+ esté instalado: `node -v`
2. Eliminar `web/node_modules` y ejecutar `npm install`
3. Verificar que el puerto 5173 no esté en uso
4. Revisar los logs en `/tmp/web.log`

### Error de conexión entre frontend y backend

**Problema:** "Network Error" o "CORS Error"

**Soluciones:**
1. Asegurarse de que el backend esté ejecutándose en `http://localhost:8080`
2. Verificar el archivo `web/.env` tenga: `VITE_API_URL=http://localhost:8080/api`
3. Reiniciar ambos servicios

### Token expirado

**Problema:** "401 Unauthorized"

**Solución:**
- Cerrar sesión y volver a iniciar sesión
- El token JWT expira después de 24 horas

---

## 📞 Soporte

Para consultas o problemas:

- **Documentación**: Ver carpeta `docs/`
- **Issues**: Crear un issue en GitHub
- **Email**: soporte@pasteleriareal.cl

---

## 📄 Licencia

Este proyecto fue desarrollado con fines educativos para la Evaluación Parcial 3 de la asignatura DSY1104 - Desarrollo Fullstack II.

---

## 🎓 Créditos

**Desarrollado para:**
- Asignatura: DSY1104 - Desarrollo Fullstack II
- Institución: DUOC UC
- Evaluación: Parcial 3
- Fecha: Diciembre 2024

---

## 🚀 Inicio Rápido (Resumen)

```bash
# 1. Clonar o descomprimir el proyecto
cd pasteleria-real

# 2. Dar permisos a los scripts
chmod +x *.sh

# 3. Iniciar todo
./start-all.sh

# 4. Abrir navegador en:
# http://localhost:5173

# 5. Iniciar sesión con:
# ana.maria@gmail.cl / password123
```

---

**¡Disfruta usando Pastelería Real! 🎂**
