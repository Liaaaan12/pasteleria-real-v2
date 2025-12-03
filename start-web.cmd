@echo off
echo ================================================
echo   Iniciando Frontend - Pastelería Real Web
echo ================================================

cd web

REM Verificar si Node.js está instalado
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Error: Node.js no está instalado.
    echo Por favor instala Node.js 18 o superior.
    goto :eof
)

echo ✅ Node.js versión:
node -v

echo.

REM Verificar si node_modules existe
if not exist "node_modules" (
    echo 📦 Instalando dependencias...
    echo Esto puede tomar algunos minutos...
    echo.
    npm install
    
    if %errorlevel% neq 0 (
        echo.
        echo ❌ Error al instalar dependencias.
        goto :eof
    )
    echo.
    echo ✅ Dependencias instaladas correctamente.
)

echo.
echo 🚀 Iniciando servidor de desarrollo...
echo.
echo 📍 Aplicación disponible en: http://localhost:5173
echo.
echo ⚠️  Asegúrate de que el backend esté ejecutándose en http://localhost:8080
echo.
echo Presiona Ctrl+C para detener el servidor
echo.
echo ================================================
echo.

npm run dev
