# Manual de Usuario - Pastelería Real
## Sistema de Gestión de Pastelería con API REST

---

## Tabla de Contenidos

1. [Introducción](#1-introducción)
2. [Requisitos del Sistema](#2-requisitos-del-sistema)
3. [Instalación](#3-instalación)
4. [Inicio de Sesión](#4-inicio-de-sesión)
5. [Navegación del Sistema](#5-navegación-del-sistema)
6. [Funcionalidades por Rol](#6-funcionalidades-por-rol)
7. [Gestión de Productos](#7-gestión-de-productos)
8. [Gestión de Categorías](#8-gestión-de-categorías)
9. [Compras y Carrito](#9-compras-y-carrito)
10. [Perfil de Usuario](#10-perfil-de-usuario)
11. [Documentación API (Swagger)](#11-documentación-api-swagger)
12. [Solución de Problemas](#12-solución-de-problemas)

---

## 1. Introducción

Bienvenido al sistema de gestión de **Pastelería Real**. Este sistema está compuesto por dos aplicaciones:

- **Backend (API)**: Servidor que gestiona la lógica de negocio y la base de datos
- **Frontend (Web)**: Interfaz de usuario para interactuar con el sistema

El sistema permite:
- Visualizar y comprar productos de pastelería
- Gestionar inventario de productos (según rol)
- Administrar categorías de productos
- Gestionar usuarios y permisos
- Realizar pedidos y seguimiento

---

## 2. Requisitos del Sistema

### Para Usuarios Finales

- **Navegador web moderno**: Chrome, Firefox, Safari o Edge (última versión)
- **Conexión a internet**: Para acceder al sistema
- **Resolución mínima**: 1024x768 píxeles

### Para Administradores del Sistema

**Backend (API)**
- Java 17 o superior
- Maven 3.6+
- 512 MB de RAM mínimo

**Frontend (Web)**
- Node.js 18+
- npm o pnpm
- 256 MB de RAM mínimo

---

## 3. Instalación

### 3.1 Instalación del Backend

1. **Descomprimir el archivo**
   ```bash
   tar -xzf pasteleria-api.tar.gz
   cd pasteleria-api
   ```

2. **Ejecutar la aplicación**
   ```bash
   ./mvnw spring-boot:run
   ```

3. **Verificar que está funcionando**
   - Abrir navegador en: `http://localhost:8080/swagger-ui.html`
   - Deberías ver la documentación de la API

![Swagger UI](pantallazos/swagger-ui.png)

### 3.2 Instalación del Frontend

1. **Descomprimir el archivo**
   ```bash
   tar -xzf pasteleria-web.tar.gz
   cd pasteleria-web
   ```

2. **Instalar dependencias**
   ```bash
   npm install
   ```

3. **Ejecutar la aplicación**
   ```bash
   npm run dev
   ```

4. **Acceder al sistema**
   - Abrir navegador en: `http://localhost:5173`

![Página de inicio](pantallazos/home.png)

---

## 4. Inicio de Sesión

### 4.1 Acceder a la Página de Login

1. En la página principal, hacer clic en el botón **"Iniciar Sesión"** en la esquina superior derecha

![Botón de login](pantallazos/login-button.png)

2. Se mostrará el formulario de inicio de sesión

![Formulario de login](pantallazos/login-form.png)

### 4.2 Ingresar Credenciales

**Usuarios de Prueba Disponibles:**

| Correo | Contraseña | Rol | Permisos |
|--------|------------|-----|----------|
| ana.maria@gmail.cl | password123 | SuperAdmin | Acceso total |
| luis.felipe@gmail.com | password123 | Administrador | Gestión de productos y categorías |
| claudia.isabel@duoc.cl | password123 | Cliente | Solo compras |

### 4.3 Proceso de Login

1. Ingresar correo electrónico
2. Ingresar contraseña
3. Hacer clic en **"Iniciar Sesión"**

![Login exitoso](pantallazos/login-success.png)

4. Si las credenciales son correctas, serás redirigido a la página principal
5. Tu nombre aparecerá en la esquina superior derecha

![Usuario logueado](pantallazos/user-logged.png)

### 4.4 Cerrar Sesión

1. Hacer clic en tu nombre en la esquina superior derecha
2. Seleccionar **"Cerrar Sesión"**

![Cerrar sesión](pantallazos/logout.png)

---

## 5. Navegación del Sistema

### 5.1 Menú Principal

El menú de navegación está siempre visible en la parte superior:

![Menú principal](pantallazos/main-menu.png)

**Opciones del menú:**
- **Inicio**: Página principal con productos destacados
- **Productos**: Catálogo completo de productos
- **Nosotros**: Información sobre la pastelería
- **Blog**: Recetas y noticias
- **Contacto**: Formulario de contacto

### 5.2 Menú de Usuario (Autenticado)

Cuando inicias sesión, aparecen opciones adicionales:

![Menú de usuario](pantallazos/user-menu.png)

- **Mi Perfil**: Ver y editar información personal
- **Mis Pedidos**: Historial de compras
- **Carrito**: Ver productos en el carrito
- **Admin** (solo administradores): Panel de administración

---

## 6. Funcionalidades por Rol

### 6.1 Cliente

**Permisos:**
- ✅ Ver productos
- ✅ Agregar productos al carrito
- ✅ Realizar compras
- ✅ Ver historial de pedidos
- ✅ Editar perfil
- ❌ Crear/editar/eliminar productos
- ❌ Gestionar categorías

![Vista de cliente](pantallazos/client-view.png)

### 6.2 Vendedor

**Permisos:**
- ✅ Todo lo que puede hacer un Cliente
- ✅ Crear productos
- ✅ Editar productos
- ❌ Eliminar productos
- ❌ Gestionar categorías

![Vista de vendedor](pantallazos/vendor-view.png)

### 6.3 Administrador

**Permisos:**
- ✅ Todo lo que puede hacer un Vendedor
- ✅ Eliminar productos
- ✅ Crear categorías
- ✅ Eliminar categorías
- ❌ Gestionar usuarios

![Vista de administrador](pantallazos/admin-view.png)

### 6.4 SuperAdmin

**Permisos:**
- ✅ Acceso total al sistema
- ✅ Gestionar usuarios
- ✅ Todas las funcionalidades anteriores

![Vista de superadmin](pantallazos/superadmin-view.png)

---

## 7. Gestión de Productos

### 7.1 Ver Productos

1. Hacer clic en **"Productos"** en el menú principal
2. Se mostrará el catálogo completo

![Catálogo de productos](pantallazos/products-catalog.png)

3. Puedes filtrar por categoría usando el menú lateral

![Filtro de categorías](pantallazos/category-filter.png)

### 7.2 Ver Detalle de Producto

1. Hacer clic en cualquier producto
2. Se mostrará la información completa

![Detalle de producto](pantallazos/product-detail.png)

**Información mostrada:**
- Nombre del producto
- Precio
- Descripción
- Imagen
- Stock disponible
- Categoría

### 7.3 Crear Producto (Vendedor/Admin)

1. Ir a **"Admin"** → **"Productos"**
2. Hacer clic en **"Nuevo Producto"**

![Botón nuevo producto](pantallazos/new-product-button.png)

3. Completar el formulario:

![Formulario de producto](pantallazos/product-form.png)

**Campos requeridos:**
- Código del producto (único)
- Nombre del producto
- Precio
- Descripción
- URL de la imagen
- Stock inicial
- Stock crítico
- Categoría

4. Hacer clic en **"Guardar"**

![Producto creado](pantallazos/product-created.png)

### 7.4 Editar Producto (Vendedor/Admin)

1. En el listado de productos, hacer clic en el botón **"Editar"**

![Botón editar producto](pantallazos/edit-product-button.png)

2. Modificar los campos necesarios
3. Hacer clic en **"Actualizar"**

![Producto actualizado](pantallazos/product-updated.png)

### 7.5 Eliminar Producto (Solo Admin)

1. En el listado de productos, hacer clic en el botón **"Eliminar"**

![Botón eliminar producto](pantallazos/delete-product-button.png)

2. Confirmar la eliminación

![Confirmar eliminación](pantallazos/confirm-delete.png)

3. El producto será eliminado permanentemente

![Producto eliminado](pantallazos/product-deleted.png)

---

## 8. Gestión de Categorías

### 8.1 Ver Categorías

1. Ir a **"Admin"** → **"Categorías"**

![Listado de categorías](pantallazos/categories-list.png)

### 8.2 Crear Categoría (Admin)

1. Hacer clic en **"Nueva Categoría"**

![Botón nueva categoría](pantallazos/new-category-button.png)

2. Ingresar el nombre de la categoría

![Formulario de categoría](pantallazos/category-form.png)

3. Hacer clic en **"Guardar"**

![Categoría creada](pantallazos/category-created.png)

### 8.3 Eliminar Categoría (SuperAdmin)

1. Hacer clic en el botón **"Eliminar"** junto a la categoría

![Botón eliminar categoría](pantallazos/delete-category-button.png)

2. Confirmar la eliminación

**⚠️ Advertencia**: No se puede eliminar una categoría que tenga productos asociados.

![Error al eliminar categoría](pantallazos/category-delete-error.png)

---

## 9. Compras y Carrito

### 9.1 Agregar Producto al Carrito

1. En la página de detalle del producto, seleccionar cantidad

![Seleccionar cantidad](pantallazos/select-quantity.png)

2. Hacer clic en **"Agregar al Carrito"**

![Agregar al carrito](pantallazos/add-to-cart.png)

3. Aparecerá una confirmación

![Producto agregado](pantallazos/product-added-cart.png)

### 9.2 Ver Carrito

1. Hacer clic en el icono del carrito en la esquina superior derecha

![Icono del carrito](pantallazos/cart-icon.png)

2. Se mostrará el contenido del carrito

![Vista del carrito](pantallazos/cart-view.png)

**Acciones disponibles:**
- Modificar cantidad
- Eliminar producto
- Ver subtotal
- Proceder al pago

### 9.3 Modificar Cantidad en el Carrito

1. Usar los botones **+** y **-** para ajustar la cantidad

![Modificar cantidad](pantallazos/modify-quantity.png)

2. El subtotal se actualizará automáticamente

### 9.4 Eliminar Producto del Carrito

1. Hacer clic en el botón **"Eliminar"** o en el icono de basura

![Eliminar del carrito](pantallazos/remove-from-cart.png)

### 9.5 Proceder al Pago

1. Hacer clic en **"Proceder al Pago"**

![Botón proceder al pago](pantallazos/proceed-checkout.png)

2. Completar información de envío

![Formulario de envío](pantallazos/shipping-form.png)

**Información requerida:**
- Dirección de envío
- Región
- Comuna
- Teléfono de contacto

3. Revisar resumen del pedido

![Resumen del pedido](pantallazos/order-summary.png)

4. Hacer clic en **"Confirmar Pedido"**

![Pedido confirmado](pantallazos/order-confirmed.png)

---

## 10. Perfil de Usuario

### 10.1 Ver Perfil

1. Hacer clic en tu nombre en la esquina superior derecha
2. Seleccionar **"Mi Perfil"**

![Menú de perfil](pantallazos/profile-menu.png)

3. Se mostrará tu información personal

![Vista de perfil](pantallazos/profile-view.png)

**Información mostrada:**
- RUN
- Nombre completo
- Correo electrónico
- Fecha de nacimiento
- Tipo de usuario
- Direcciones registradas

### 10.2 Editar Perfil

1. Hacer clic en **"Editar Perfil"**

![Botón editar perfil](pantallazos/edit-profile-button.png)

2. Modificar los campos deseados

![Formulario de edición](pantallazos/edit-profile-form.png)

3. Hacer clic en **"Guardar Cambios"**

![Perfil actualizado](pantallazos/profile-updated.png)

### 10.3 Agregar Dirección

1. En la sección de direcciones, hacer clic en **"Agregar Dirección"**

![Botón agregar dirección](pantallazos/add-address-button.png)

2. Completar el formulario

![Formulario de dirección](pantallazos/address-form.png)

**Campos requeridos:**
- Dirección completa
- Región
- Comuna

3. Hacer clic en **"Guardar"**

![Dirección agregada](pantallazos/address-added.png)

---

## 11. Documentación API (Swagger)

### 11.1 Acceder a Swagger UI

1. Abrir navegador en: `http://localhost:8080/swagger-ui.html`

![Swagger UI principal](pantallazos/swagger-main.png)

### 11.2 Explorar Endpoints

1. Los endpoints están organizados por categorías:
   - **Autenticación**: Login
   - **Productos**: CRUD de productos
   - **Categorías**: CRUD de categorías

![Endpoints de Swagger](pantallazos/swagger-endpoints.png)

### 11.3 Probar un Endpoint

1. Hacer clic en el endpoint que deseas probar

![Seleccionar endpoint](pantallazos/swagger-select-endpoint.png)

2. Hacer clic en **"Try it out"**

![Try it out](pantallazos/swagger-try-it-out.png)

3. Completar los parámetros necesarios

![Parámetros del endpoint](pantallazos/swagger-parameters.png)

4. Hacer clic en **"Execute"**

![Ejecutar endpoint](pantallazos/swagger-execute.png)

5. Ver la respuesta

![Respuesta del endpoint](pantallazos/swagger-response.png)

### 11.4 Autenticación en Swagger

Para probar endpoints protegidos:

1. Primero, obtener un token usando `/api/auth/login`

![Login en Swagger](pantallazos/swagger-login.png)

2. Copiar el token de la respuesta

![Copiar token](pantallazos/swagger-copy-token.png)

3. Hacer clic en el botón **"Authorize"** en la parte superior

![Botón Authorize](pantallazos/swagger-authorize-button.png)

4. Pegar el token en el formato: `Bearer {token}`

![Ingresar token](pantallazos/swagger-enter-token.png)

5. Hacer clic en **"Authorize"**

![Token autorizado](pantallazos/swagger-authorized.png)

6. Ahora puedes probar endpoints protegidos

---

## 12. Solución de Problemas

### 12.1 No puedo iniciar sesión

**Problema**: "Credenciales inválidas"

**Soluciones:**
1. Verificar que el correo esté escrito correctamente
2. Verificar que la contraseña sea correcta (sensible a mayúsculas)
3. Asegurarse de que el backend esté ejecutándose
4. Verificar en la consola del navegador si hay errores de conexión

![Error de login](pantallazos/login-error.png)

### 12.2 Los productos no se cargan

**Problema**: La página de productos está vacía

**Soluciones:**
1. Verificar que el backend esté ejecutándose en `http://localhost:8080`
2. Abrir la consola del navegador (F12) y buscar errores
3. Verificar la configuración de CORS en el backend
4. Reiniciar ambas aplicaciones (backend y frontend)

![Error de carga de productos](pantallazos/products-error.png)

### 12.3 Error 401 - No autorizado

**Problema**: "Token expirado o inválido"

**Soluciones:**
1. Cerrar sesión y volver a iniciar sesión
2. El token JWT expira después de 24 horas
3. Borrar el localStorage del navegador

![Error 401](pantallazos/error-401.png)

### 12.4 Error 403 - Acceso denegado

**Problema**: "No tienes permisos para realizar esta acción"

**Soluciones:**
1. Verificar que tu rol de usuario tenga los permisos necesarios
2. Contactar al administrador para solicitar permisos

![Error 403](pantallazos/error-403.png)

### 12.5 El backend no inicia

**Problema**: Error al ejecutar `./mvnw spring-boot:run`

**Soluciones:**
1. Verificar que Java 17 esté instalado: `java -version`
2. Verificar que el puerto 8080 no esté en uso
3. Revisar los logs de error en la consola

### 12.6 El frontend no inicia

**Problema**: Error al ejecutar `npm run dev`

**Soluciones:**
1. Verificar que Node.js 18+ esté instalado: `node -v`
2. Eliminar `node_modules` y ejecutar `npm install` nuevamente
3. Verificar que el puerto 5173 no esté en uso

### 12.7 Error de CORS

**Problema**: "Access to fetch at... has been blocked by CORS policy"

**Soluciones:**
1. Verificar que el backend tenga configurado CORS para `http://localhost:5173`
2. Revisar el archivo `application.properties` del backend
3. Reiniciar el backend después de cambiar la configuración

![Error CORS](pantallazos/cors-error.png)

---

## Contacto y Soporte

Para asistencia técnica o reportar problemas:

- **Email**: soporte@pasteleriareal.cl
- **Teléfono**: +56 9 1234 5678
- **Horario de atención**: Lunes a Viernes, 9:00 - 18:00

---

## Glosario

- **API**: Interfaz de Programación de Aplicaciones
- **Backend**: Servidor que gestiona la lógica de negocio
- **Frontend**: Interfaz de usuario
- **JWT**: JSON Web Token, método de autenticación
- **CRUD**: Create, Read, Update, Delete (Crear, Leer, Actualizar, Eliminar)
- **Swagger**: Herramienta de documentación de APIs
- **CORS**: Cross-Origin Resource Sharing, política de seguridad del navegador

---

**Manual de Usuario - Pastelería Real**  
**Versión**: 1.0  
**Fecha**: Diciembre 2024  
**Desarrollado para**: Evaluación Parcial 3 - DSY1104
