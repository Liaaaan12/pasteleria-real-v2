@echo off
echo ================================================
echo   Iniciando Backend - Pastelería Real API
echo ================================================

cd api

REM Verificar si Java está instalado
where java >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Error: Java no está instalado.
    echo Por favor instala Java 17 o superior.
    goto :eof
)

echo ✅ Java versión:
java -version

echo.
echo 📦 Compilando el proyecto...
echo.

REM Compilar el proyecto y generar el JAR
call .\mvnw.cmd clean package -DskipTests

if %errorlevel% neq 0 (
    echo.
    echo ❌ Error en la compilación.
    goto :eof
)

echo.
echo ✅ Compilación exitosa.
echo.
echo 🚀 Iniciando servidor backend...
echo.
echo 📍 API disponible en: http://localhost:8080
echo 📍 Swagger UI: http://localhost:8080/swagger-ui.html
echo 📍 H2 Console: http://localhost:8080/h2-console
echo.
echo Presiona Ctrl+C para detener el servidor
echo.
echo ================================================
echo.

REM Iniciar el JAR generado
java -jar target\pasteleria-api-0.0.1-SNAPSHOT.jar
