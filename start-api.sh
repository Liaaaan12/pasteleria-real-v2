#!/bin/bash

echo "================================================"
echo "  Iniciando Backend - Pastelería Real API"
echo "================================================"
echo ""

cd api

# Verificar si Java está instalado
if ! command -v java &> /dev/null; then
    echo "❌ Error: Java no está instalado"
    echo "Por favor instala Java 17 o superior"
    exit 1
fi

# Verificar versión de Java
JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
if [ "$JAVA_VERSION" -lt 17 ]; then
    echo "❌ Error: Se requiere Java 17 o superior"
    echo "Versión actual: $JAVA_VERSION"
    exit 1
fi

echo "✅ Java versión: $(java -version 2>&1 | head -n 1)"
echo ""
echo "📦 Compilando el proyecto..."
echo ""

./mvnw clean package -DskipTests

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Compilación exitosa"
    echo ""
    echo "🚀 Iniciando servidor backend..."
    echo ""
    echo "📍 API disponible en: http://localhost:8080"
    echo "📍 Swagger UI: http://localhost:8080/swagger-ui.html"
    echo "📍 H2 Console: http://localhost:8080/h2-console"
    echo ""
    echo "Presiona Ctrl+C para detener el servidor"
    echo ""
    echo "================================================"
    echo ""
    
    ./mvnw spring-boot:run
else
    echo ""
    echo "❌ Error en la compilación"
    exit 1
fi
