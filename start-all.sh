#!/bin/bash

echo "========================================================"
echo "  Iniciando Pastelería Real - Sistema Completo"
echo "========================================================"
echo ""
echo "Este script iniciará el backend y el frontend"
echo "en terminales separadas."
echo ""

# Verificar que estamos en el directorio correcto
if [ ! -d "api" ] || [ ! -d "web" ]; then
    echo "❌ Error: Debes ejecutar este script desde el directorio raíz del proyecto"
    exit 1
fi

# Verificar Java
if ! command -v java &> /dev/null; then
    echo "❌ Error: Java no está instalado"
    echo "Por favor instala Java 17 o superior"
    exit 1
fi

# Verificar Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Error: Node.js no está instalado"
    echo "Por favor instala Node.js 18 o superior"
    exit 1
fi

echo "✅ Requisitos verificados"
echo ""
echo "📦 Preparando backend..."
cd api
./mvnw clean package -DskipTests > /tmp/api-build.log 2>&1 &
BUILD_PID=$!

echo "⏳ Compilando backend (esto puede tomar un momento)..."
wait $BUILD_PID

if [ $? -ne 0 ]; then
    echo "❌ Error al compilar el backend"
    echo "Ver detalles en: /tmp/api-build.log"
    exit 1
fi

echo "✅ Backend compilado exitosamente"
cd ..

echo ""
echo "📦 Verificando dependencias del frontend..."
cd web
if [ ! -d "node_modules" ]; then
    echo "📥 Instalando dependencias del frontend..."
    npm install
    if [ $? -ne 0 ]; then
        echo "❌ Error al instalar dependencias"
        exit 1
    fi
fi
cd ..

echo ""
echo "🚀 Iniciando servicios..."
echo ""
echo "================================================"
echo ""
echo "📍 Backend API: http://localhost:8080"
echo "📍 Swagger UI: http://localhost:8080/swagger-ui.html"
echo "📍 H2 Console: http://localhost:8080/h2-console"
echo ""
echo "📍 Frontend Web: http://localhost:5173"
echo ""
echo "================================================"
echo ""
echo "👥 Usuarios de prueba:"
echo "   SuperAdmin: ana.maria@gmail.cl / password123"
echo "   Administrador: luis.felipe@gmail.com / password123"
echo "   Cliente: claudia.isabel@duoc.cl / password123"
echo ""
echo "================================================"
echo ""
echo "⚠️  IMPORTANTE:"
echo "   - El backend se iniciará primero (tarda ~30 segundos)"
echo "   - Luego se iniciará el frontend automáticamente"
echo "   - Presiona Ctrl+C para detener ambos servicios"
echo ""
echo "================================================"
echo ""

# Función para limpiar procesos al salir
cleanup() {
    echo ""
    echo "🛑 Deteniendo servicios..."
    kill $API_PID 2>/dev/null
    kill $WEB_PID 2>/dev/null
    echo "✅ Servicios detenidos"
    exit 0
}

trap cleanup SIGINT SIGTERM

# Iniciar backend
echo "🔄 Iniciando backend..."
cd api
./mvnw spring-boot:run > /tmp/api.log 2>&1 &
API_PID=$!
cd ..

# Esperar a que el backend esté listo
echo "⏳ Esperando a que el backend esté listo..."
sleep 30

# Verificar si el backend está corriendo
if ! kill -0 $API_PID 2>/dev/null; then
    echo "❌ Error: El backend no se inició correctamente"
    echo "Ver logs en: /tmp/api.log"
    exit 1
fi

# Verificar si el backend responde
for i in {1..10}; do
    if curl -s http://localhost:8080/actuator/health > /dev/null 2>&1 || curl -s http://localhost:8080 > /dev/null 2>&1; then
        echo "✅ Backend listo"
        break
    fi
    if [ $i -eq 10 ]; then
        echo "⚠️  Backend tardó más de lo esperado, pero continuando..."
    fi
    sleep 2
done

# Iniciar frontend
echo ""
echo "🔄 Iniciando frontend..."
cd web
npm run dev > /tmp/web.log 2>&1 &
WEB_PID=$!
cd ..

sleep 5

# Verificar si el frontend está corriendo
if ! kill -0 $WEB_PID 2>/dev/null; then
    echo "❌ Error: El frontend no se inició correctamente"
    echo "Ver logs en: /tmp/web.log"
    kill $API_PID 2>/dev/null
    exit 1
fi

echo "✅ Frontend listo"
echo ""
echo "================================================"
echo "  ✅ Sistema completo iniciado exitosamente"
echo "================================================"
echo ""
echo "🌐 Abre tu navegador en: http://localhost:5173"
echo ""
echo "📊 Logs disponibles en:"
echo "   Backend: /tmp/api.log"
echo "   Frontend: /tmp/web.log"
echo ""
echo "Presiona Ctrl+C para detener todos los servicios"
echo ""

# Mantener el script corriendo
wait $API_PID $WEB_PID
