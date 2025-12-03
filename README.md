# 🎂 Pastelería Real - Sistema Completo (Optimizado para Windows)

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

---

## 📖 Descripción

**Pastelería Real** es un sistema completo de gestión para una pastelería. El proyecto está dividido en dos componentes que se comunican mediante API REST:

- **Backend (API)**: Servidor Spring Boot que expone servicios REST
- **Frontend (Web)**: Aplicación React que consume la API

---

## 📁 Estructura del Proyecto

```
pasteleria-real/
├── api/                    # Backend - Spring Boot
├── web/                    # Frontend - React
├── docs/                   # Documentación
├── start-all.cmd          # ⭐ Iniciar todo (Windows)
├── start-api.cmd          # Iniciar solo backend (Windows)
├── start-web.cmd          # Iniciar solo frontend (Windows)
├── package.json           # Scripts npm del proyecto
└── README.md              # Este archivo
```

---

## ✅ Requisitos Previos

Asegúrate de tener instalado:

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

---

## 🚀 Instalación Rápida

Abre la terminal de VS Code (PowerShell o CMD) en la carpeta raíz del proyecto (`pasteleria-real/`).

### 1. Instalar Dependencias y Compilar

Ejecuta el siguiente comando para instalar las dependencias del Frontend y compilar el Backend (genera el archivo JAR):

```bash
npm run install:all
```

**Nota:** Este comando puede tardar unos minutos.

---

## 🎯 Formas de Iniciar el Proyecto

### ⭐ Opción 1: Iniciar Todo (Recomendado)

Este método inicia automáticamente el backend y el frontend en ventanas separadas de CMD.

```bash
npm start
```

**¿Qué hace este comando?**
1. ✅ Ejecuta `start-all.cmd`.
2. 🚀 Inicia el Backend (API) en una nueva ventana.
3. 🚀 Inicia el Frontend (Web) en otra nueva ventana.
4. ✅ Muestra las URLs de acceso.

**Resultado:**
- 🌐 Backend API: `http://localhost:8080`
- 🌐 Frontend Web: `http://localhost:5173`

**Para detener:** Cierra las ventanas de CMD que se abrieron.

---

### Opción 2: Iniciar por Separado

Si deseas iniciar cada parte en tu terminal actual de VS Code, usa estos comandos:

#### Terminal 1: Iniciar Backend (API)

```bash
npm run start:api
```

#### Terminal 2: Iniciar Frontend (Web)

```bash
npm run start:web
```

**Importante:** Siempre inicia el Backend primero y espera a que esté completamente listo antes de iniciar el Frontend.

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

---

## 👥 Usuarios de Prueba

| Correo | Contraseña | Rol |
|--------|-----------|-----|
| ana.maria@gmail.cl | password123 | **SuperAdmin** |
| luis.felipe@gmail.com | password123 | **Administrador** |
| claudia.isabel@duoc.cl | password123 | **Cliente** |

---

## 🛠️ Tecnologías

### Backend (API)
- **Spring Boot 3.4.0**
- **Spring Security** + **JWT**
- **Spring Data JPA**
- **H2 Database**
- **Swagger/OpenAPI**

### Frontend (Web)
- **React 19**
- **TypeScript**
- **Vite**
- **Axios**
- **Bootstrap 5**

---

## 📚 Documentación

- **`api/README.md`** - Documentación detallada del backend
- **`web/README.md`** - Documentación detallada del frontend
- **`docs/DOCUMENTO_INTEGRACION.md`** - Documentación técnica de integración
- **`docs/MANUAL_USUARIO.md`** - Manual de usuario con pantallazos

---

## 🔧 Comandos Útiles

| Comando | Descripción |
| :--- | :--- |
| `npm start` | Inicia todo el sistema (Backend + Frontend). |
| `npm run install:all` | Instala dependencias y compila el Backend. |
| `npm run build:all` | Compila ambos proyectos para producción. |
| `npm run clean` | Limpia los archivos compilados y dependencias. |

---

## 🐛 Solución de Problemas

### El Backend no inicia

**Problema:** Error al ejecutar `npm run start:api`

**Soluciones:**
1. **Verificar Java:** Asegúrate de que `java -version` muestre Java 17+.
2. **Recompilar:** Ejecuta `npm run build:api` para asegurar que el JAR esté actualizado.
3. **Puerto:** Verifica que el puerto 8080 no esté en uso.

### El Frontend no inicia

**Problema:** Error al ejecutar `npm run start:web`

**Soluciones:**
1. **Verificar Node.js:** Asegúrate de que `node -v` muestre Node.js 18+.
2. **Dependencias:** Ejecuta `npm install` dentro de la carpeta `web/`.

---

## 🎓 Créditos

**Desarrollado para:** Evaluación Parcial 3 - DSY1104 Desarrollo Fullstack II
