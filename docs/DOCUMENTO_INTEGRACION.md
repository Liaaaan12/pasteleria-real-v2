# Documento de Integración - Pastelería Real
## Evaluación Parcial 3 - DSY1104 Desarrollo Fullstack II

---

## 1. Descripción General del Proyecto

El proyecto **Pastelería Real** ha sido separado en dos componentes independientes que se comunican mediante una API REST:

- **Backend (API)**: Aplicación Spring Boot que expone servicios REST
- **Frontend (Web)**: Aplicación React que consume la API

Esta arquitectura permite escalabilidad, mantenibilidad y separación de responsabilidades entre la capa de presentación y la capa de lógica de negocio.

---

## 2. Arquitectura del Sistema

### 2.1 Diagrama de Arquitectura

```
┌─────────────────────────────────────────────────────────────┐
│                     CLIENTE (Navegador)                      │
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │         Frontend - React + TypeScript              │    │
│  │              (Puerto 5173)                          │    │
│  │                                                     │    │
│  │  - Componentes React                               │    │
│  │  - Gestión de estado (Context API)                 │    │
│  │  - Rutas protegidas                                │    │
│  │  - Integración con API (Axios)                     │    │
│  └────────────────────────────────────────────────────┘    │
│                          │                                   │
│                          │ HTTP/HTTPS                        │
│                          │ (JSON)                            │
│                          ▼                                   │
└──────────────────────────────────────────────────────────────┘
                           │
                           │ API REST
                           │
┌──────────────────────────▼───────────────────────────────────┐
│                Backend - Spring Boot                         │
│                   (Puerto 8080)                              │
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │              Capa de Controladores                  │    │
│  │  - AuthController                                   │    │
│  │  - ProductoController                               │    │
│  │  - CategoriaController                              │    │
│  └────────────────────────────────────────────────────┘    │
│                          │                                   │
│  ┌────────────────────────────────────────────────────┐    │
│  │            Capa de Seguridad (JWT)                  │    │
│  │  - JwtAuthenticationFilter                          │    │
│  │  - SecurityConfig                                   │    │
│  │  - CustomUserDetailsService                         │    │
│  └────────────────────────────────────────────────────┘    │
│                          │                                   │
│  ┌────────────────────────────────────────────────────┐    │
│  │              Capa de Servicios                      │    │
│  │  - AuthService                                      │    │
│  │  - ProductoService                                  │    │
│  │  - CategoriaService                                 │    │
│  └────────────────────────────────────────────────────┘    │
│                          │                                   │
│  ┌────────────────────────────────────────────────────┐    │
│  │            Capa de Repositorios (JPA)               │    │
│  │  - UsuarioRepository                                │    │
│  │  - ProductoRepository                               │    │
│  │  - CategoriaRepository                              │    │
│  └────────────────────────────────────────────────────┘    │
│                          │                                   │
│  ┌────────────────────────────────────────────────────┐    │
│  │              Base de Datos (H2/MySQL)               │    │
│  │  - Usuarios                                         │    │
│  │  - Productos                                        │    │
│  │  - Categorías                                       │    │
│  │  - Direcciones                                      │    │
│  └────────────────────────────────────────────────────┘    │
└──────────────────────────────────────────────────────────────┘
```

---

## 3. Implementación del Backend

### 3.1 Conexión a Base de Datos

El backend utiliza **Spring Data JPA** para la persistencia de datos con soporte para H2 (desarrollo) y MySQL (producción).

#### Configuración (application.properties)

```properties
# Base de datos H2 (desarrollo)
spring.datasource.url=jdbc:h2:mem:pasteleriadb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=

# JPA/Hibernate
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.show-sql=true
```

#### Modelos de Datos Implementados

**Usuario**
- Campos: id, run, nombre, apellidos, correo, fechaNacimiento, password, tipoUsuario
- Relación: OneToMany con Direccion
- Validaciones: @NotBlank, @Email, @NotNull

**Producto**
- Campos: id, codigoProducto, nombreProducto, precioProducto, descripcionProducto, imagenProducto, stock, stockCritico
- Relación: ManyToOne con Categoria
- Validaciones: @NotBlank, @DecimalMin, @Min

**Categoria**
- Campos: id, nombreCategoria
- Relación: OneToMany con Producto

**Direccion**
- Campos: id, address, region, comuna
- Relación: ManyToOne con Usuario

### 3.2 Servicios de API REST

#### Endpoints Implementados

**Autenticación**
```
POST /api/auth/login
Body: { "correo": "string", "password": "string" }
Response: { "token": "string", "tipo": "Bearer", "correo": "string", "nombre": "string", "apellidos": "string", "tipoUsuario": "string" }
```

**Productos**
```
GET    /api/productos                    - Listar todos
GET    /api/productos/{id}               - Obtener por ID
GET    /api/productos/codigo/{codigo}    - Obtener por código
GET    /api/productos/categoria/{id}     - Listar por categoría
POST   /api/productos                    - Crear (requiere auth)
PUT    /api/productos/{id}               - Actualizar (requiere auth)
DELETE /api/productos/{id}               - Eliminar (requiere admin)
```

**Categorías**
```
GET    /api/categorias        - Listar todas
GET    /api/categorias/{id}   - Obtener por ID
POST   /api/categorias        - Crear (requiere admin)
DELETE /api/categorias/{id}   - Eliminar (requiere superadmin)
```

#### Documentación Swagger

La API está documentada con **Swagger/OpenAPI 3.0**:

- **URL**: `http://localhost:8080/swagger-ui.html`
- **JSON**: `http://localhost:8080/api-docs`

Características:
- Interfaz interactiva para probar endpoints
- Documentación automática de parámetros y respuestas
- Soporte para autenticación JWT en la UI

### 3.3 Autenticación JWT

#### Flujo de Autenticación

1. **Usuario envía credenciales** → POST /api/auth/login
2. **Backend valida credenciales** → UserDetailsService + PasswordEncoder
3. **Backend genera token JWT** → JwtUtil.generateToken()
4. **Frontend almacena token** → localStorage.setItem('token', token)
5. **Frontend incluye token en requests** → Header: Authorization: Bearer {token}
6. **Backend valida token** → JwtAuthenticationFilter

#### Componentes de Seguridad

**JwtUtil**
- Generación de tokens con algoritmo HS256
- Validación de tokens
- Extracción de claims (username, expiration)
- Clave secreta configurable

**JwtAuthenticationFilter**
- Intercepta todas las peticiones
- Extrae y valida el token JWT
- Establece el contexto de seguridad

**SecurityConfig**
- Configuración de Spring Security
- Endpoints públicos vs protegidos
- Configuración de CORS
- Deshabilitación de CSRF (API REST stateless)

#### Gestión de Roles

Los roles se mapean desde el enum `TipoUsuario`:

- **ROLE_SUPERADMIN**: Acceso total
- **ROLE_ADMINISTRADOR**: Gestión de productos y categorías
- **ROLE_VENDEDOR**: Gestión de productos
- **ROLE_CLIENTE**: Solo lectura

Ejemplo de protección de endpoints:

```java
@PreAuthorize("hasAnyRole('SUPERADMIN', 'ADMINISTRADOR')")
@PostMapping("/categorias")
public ResponseEntity<Categoria> create(@Valid @RequestBody Categoria categoria) {
    return ResponseEntity.status(HttpStatus.CREATED).body(categoriaService.save(categoria));
}
```

---

## 4. Implementación del Frontend

### 4.1 Integración con API REST

#### Configuración de Axios

Se creó un cliente Axios centralizado en `src/services/api.ts`:

```typescript
const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL || 'http://localhost:8080/api',
  headers: {
    'Content-Type': 'application/json',
  },
});

// Interceptor para agregar token JWT
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});
```

#### Servicios Implementados

**authService**
- `login(correo, password)`: Autenticación y almacenamiento de token
- `logout()`: Limpieza de sesión
- `getCurrentUser()`: Obtener usuario actual
- `isAuthenticated()`: Verificar autenticación

**productService**
- `getAll()`: Obtener todos los productos
- `getById(id)`: Obtener producto por ID
- `getByCodigo(codigo)`: Obtener producto por código
- `getByCategoria(categoriaId)`: Filtrar por categoría
- `create(producto)`: Crear producto
- `update(id, producto)`: Actualizar producto
- `delete(id)`: Eliminar producto

**categoriaService**
- `getAll()`: Obtener todas las categorías
- `getById(id)`: Obtener categoría por ID
- `create(categoria)`: Crear categoría
- `delete(id)`: Eliminar categoría

### 4.2 Flujo de Datos

#### Ejemplo: Login y Autenticación

```typescript
// 1. Usuario ingresa credenciales en el formulario
const handleLogin = async (e: React.FormEvent) => {
  e.preventDefault();
  
  try {
    // 2. Llamada a la API
    const response = await authService.login(correo, password);
    
    // 3. Token almacenado automáticamente en localStorage
    // 4. Actualizar contexto de autenticación
    setUser({
      correo: response.correo,
      nombre: response.nombre,
      apellidos: response.apellidos,
      tipoUsuario: response.tipoUsuario,
    });
    
    // 5. Redireccionar al usuario
    navigate('/');
  } catch (error) {
    console.error('Error de autenticación:', error);
    setError('Credenciales inválidas');
  }
};
```

#### Ejemplo: Obtener y Mostrar Productos

```typescript
// 1. Componente se monta
useEffect(() => {
  const fetchProductos = async () => {
    try {
      // 2. Llamada a la API (token incluido automáticamente)
      const data = await productService.getAll();
      
      // 3. Actualizar estado con los datos
      setProductos(data);
    } catch (error) {
      console.error('Error al cargar productos:', error);
    }
  };
  
  fetchProductos();
}, []);

// 4. Renderizar productos
return (
  <div className="productos-grid">
    {productos.map(producto => (
      <ProductCard key={producto.id} producto={producto} />
    ))}
  </div>
);
```

### 4.3 Gestión de Sesiones

#### Persistencia de Sesión

El token JWT y la información del usuario se almacenan en `localStorage`:

```typescript
// Al hacer login
localStorage.setItem('token', response.data.token);
localStorage.setItem('user', JSON.stringify(userInfo));

// Al verificar autenticación
const token = localStorage.getItem('token');
const user = JSON.parse(localStorage.getItem('user') || 'null');

// Al hacer logout
localStorage.removeItem('token');
localStorage.removeItem('user');
```

#### Contexto de Autenticación

Se utiliza React Context API para gestionar el estado de autenticación globalmente:

```typescript
interface AuthContextType {
  user: User | null;
  login: (correo: string, password: string) => Promise<void>;
  logout: () => void;
  isAuthenticated: boolean;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(() => {
    // Recuperar usuario de localStorage al iniciar
    const savedUser = localStorage.getItem('user');
    return savedUser ? JSON.parse(savedUser) : null;
  });

  const login = async (correo: string, password: string) => {
    const response = await authService.login(correo, password);
    setUser(response);
  };

  const logout = () => {
    authService.logout();
    setUser(null);
  };

  return (
    <AuthContext.Provider value={{ user, login, logout, isAuthenticated: !!user }}>
      {children}
    </AuthContext.Provider>
  );
};
```

#### Manejo de Expiración de Token

El interceptor de Axios maneja automáticamente tokens expirados:

```typescript
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // Token expirado o inválido
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      window.location.href = '/login';
    }
    return Promise.reject(error);
  }
);
```

### 4.4 Restricciones de Acceso

#### Rutas Protegidas

**ProtectedRoute**: Requiere autenticación

```typescript
const ProtectedRoute: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const { isAuthenticated } = useAuth();
  
  if (!isAuthenticated) {
    return <Navigate to="/login" replace />;
  }
  
  return <>{children}</>;
};
```

**RequireAdmin**: Requiere rol de administrador

```typescript
const RequireAdmin: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const { user } = useAuth();
  
  if (!user || !['SuperAdmin', 'Administrador'].includes(user.tipoUsuario)) {
    return <Navigate to="/" replace />;
  }
  
  return <>{children}</>;
};
```

#### Uso en Rutas

```typescript
<Routes>
  <Route path="/" element={<Home />} />
  <Route path="/productos" element={<Productos />} />
  <Route path="/login" element={<Login />} />
  
  <Route 
    path="/perfil" 
    element={
      <ProtectedRoute>
        <Perfil />
      </ProtectedRoute>
    } 
  />
  
  <Route 
    path="/admin" 
    element={
      <ProtectedRoute>
        <RequireAdmin>
          <Admin />
        </RequireAdmin>
      </ProtectedRoute>
    } 
  />
</Routes>
```

#### Control de Acceso en Componentes

```typescript
const ProductCard: React.FC<{ producto: Producto }> = ({ producto }) => {
  const { user } = useAuth();
  
  const canEdit = user && ['SuperAdmin', 'Administrador', 'Vendedor'].includes(user.tipoUsuario);
  const canDelete = user && ['SuperAdmin', 'Administrador'].includes(user.tipoUsuario);
  
  return (
    <div className="product-card">
      <h3>{producto.nombreProducto}</h3>
      <p>{producto.precioProducto}</p>
      
      {canEdit && (
        <button onClick={() => handleEdit(producto.id)}>Editar</button>
      )}
      
      {canDelete && (
        <button onClick={() => handleDelete(producto.id)}>Eliminar</button>
      )}
    </div>
  );
};
```

---

## 5. Comunicación Frontend-Backend

### 5.1 Configuración de CORS

El backend está configurado para aceptar peticiones del frontend:

```java
@Configuration
public class CorsConfig {
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList(
            "http://localhost:5173",
            "http://localhost:3000"
        ));
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(List.of("*"));
        configuration.setAllowCredentials(true);
        
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
```

### 5.2 Formato de Comunicación

Todas las peticiones y respuestas utilizan formato **JSON**.

#### Ejemplo: Crear Producto

**Request**
```http
POST /api/productos HTTP/1.1
Host: localhost:8080
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

{
  "codigoProducto": "TC003",
  "nombreProducto": "Torta de Frutilla",
  "precioProducto": 48000,
  "descripcionProducto": "Deliciosa torta con frutillas frescas",
  "imagenProducto": "/images/torta-frutilla.jpg",
  "stock": 15,
  "stockCritico": 5,
  "categoria": {
    "id": 1
  }
}
```

**Response**
```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 10,
  "codigoProducto": "TC003",
  "nombreProducto": "Torta de Frutilla",
  "precioProducto": 48000.00,
  "descripcionProducto": "Deliciosa torta con frutillas frescas",
  "imagenProducto": "/images/torta-frutilla.jpg",
  "stock": 15,
  "stockCritico": 5
}
```

### 5.3 Manejo de Errores

#### Backend

```java
@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<ErrorResponse> handleRuntimeException(RuntimeException ex) {
        ErrorResponse error = new ErrorResponse(
            HttpStatus.BAD_REQUEST.value(),
            ex.getMessage(),
            LocalDateTime.now()
        );
        return ResponseEntity.badRequest().body(error);
    }
}
```

#### Frontend

```typescript
try {
  const response = await productService.create(producto);
  showSuccessMessage('Producto creado exitosamente');
} catch (error) {
  if (axios.isAxiosError(error)) {
    const message = error.response?.data?.message || 'Error al crear producto';
    showErrorMessage(message);
  }
}
```

---

## 6. Seguridad

### 6.1 Autenticación y Autorización

- **Autenticación**: JWT (JSON Web Tokens)
- **Autorización**: Basada en roles (RBAC)
- **Almacenamiento de contraseñas**: SHA-256 (desarrollo), BCrypt (producción recomendado)

### 6.2 Protección de Endpoints

| Endpoint | Público | Cliente | Vendedor | Admin | SuperAdmin |
|----------|---------|---------|----------|-------|------------|
| POST /api/auth/login | ✅ | ✅ | ✅ | ✅ | ✅ |
| GET /api/productos | ✅ | ✅ | ✅ | ✅ | ✅ |
| POST /api/productos | ❌ | ❌ | ✅ | ✅ | ✅ |
| PUT /api/productos/{id} | ❌ | ❌ | ✅ | ✅ | ✅ |
| DELETE /api/productos/{id} | ❌ | ❌ | ❌ | ✅ | ✅ |
| POST /api/categorias | ❌ | ❌ | ❌ | ✅ | ✅ |
| DELETE /api/categorias/{id} | ❌ | ❌ | ❌ | ❌ | ✅ |

### 6.3 Validaciones

#### Backend (Bean Validation)

```java
@Entity
public class Producto {
    @NotBlank(message = "El nombre es obligatorio")
    private String nombreProducto;
    
    @DecimalMin(value = "0.0", inclusive = false, message = "El precio debe ser mayor a 0")
    private BigDecimal precioProducto;
    
    @Min(value = 0, message = "El stock no puede ser negativo")
    private Integer stock;
}
```

#### Frontend (Validación de formularios)

```typescript
const validateProducto = (producto: Producto): string[] => {
  const errors: string[] = [];
  
  if (!producto.nombreProducto?.trim()) {
    errors.push('El nombre es obligatorio');
  }
  
  if (producto.precioProducto <= 0) {
    errors.push('El precio debe ser mayor a 0');
  }
  
  if (producto.stock < 0) {
    errors.push('El stock no puede ser negativo');
  }
  
  return errors;
};
```

---

## 7. Testing

### 7.1 Backend

```bash
cd pasteleria-api
./mvnw test
```

### 7.2 Frontend

```bash
cd pasteleria-web
npm run test
npm run test:coverage
```

---

## 8. Despliegue

### 8.1 Backend

#### Desarrollo
```bash
cd pasteleria-api
./mvnw spring-boot:run
```

#### Producción
```bash
./mvnw clean package -DskipTests
java -jar target/pasteleria-api-0.0.1-SNAPSHOT.jar
```

### 8.2 Frontend

#### Desarrollo
```bash
cd pasteleria-web
npm install
npm run dev
```

#### Producción
```bash
npm run build
# Los archivos compilados estarán en dist/
```

---

## 9. Conclusiones

### 9.1 Logros Alcanzados

✅ **Backend con Spring Boot**
- API REST completa con operaciones CRUD
- Autenticación JWT implementada
- Documentación Swagger funcional
- Gestión de roles y permisos
- Conexión a base de datos con JPA

✅ **Frontend con React**
- Integración completa con la API
- Gestión de sesiones persistente
- Rutas protegidas por roles
- Interfaz de usuario responsive

✅ **Integración Frontend-Backend**
- Comunicación eficiente vía API REST
- Flujo de datos optimizado
- Manejo de errores robusto
- CORS configurado correctamente

### 9.2 Mejoras Futuras

- Implementar refresh tokens para mayor seguridad
- Migrar a BCrypt para hashing de contraseñas
- Agregar paginación en listados
- Implementar caché en el frontend
- Agregar tests de integración
- Configurar CI/CD para despliegue automático

---

## 10. Referencias

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Spring Security](https://spring.io/projects/spring-security)
- [JWT.io](https://jwt.io/)
- [React Documentation](https://react.dev/)
- [Axios Documentation](https://axios-http.com/)
- [Swagger/OpenAPI](https://swagger.io/)

---

**Documento preparado para Evaluación Parcial 3 - DSY1104**  
**Fecha**: Diciembre 2024
