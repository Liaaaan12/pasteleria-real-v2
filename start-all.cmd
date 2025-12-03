@echo off
echo ========================================================
echo   Iniciando Pastelería Real - Sistema Completo
echo ========================================================
echo.
echo Este script iniciará el backend y el frontend en ventanas separadas.
echo.

REM Verificar que estamos en el directorio correcto
if not exist "api" (
    echo ❌ Error: Debes ejecutar este script desde el directorio raíz del proyecto.
    goto :eof
)

REM Iniciar Backend (API) en una nueva ventana
start "Backend API" cmd /c "start-api.cmd"

echo 🚀 Backend API iniciado en una nueva ventana.
echo.

REM Iniciar Frontend (Web) en una nueva ventana
start "Frontend Web" cmd /c "start-web.cmd"

echo 🚀 Frontend Web iniciado en una nueva ventana.
echo.
echo ========================================================
echo.
echo 📍 Backend API: http://localhost:8080
echo 📍 Frontend Web: http://localhost:5173
echo.
echo ⚠️  El backend tardará un momento en compilar e iniciar.
echo    El frontend esperará al backend.
echo.
echo Presiona cualquier tecla para salir de esta ventana.
pause >nul
