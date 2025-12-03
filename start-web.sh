#!/bin/bash

echo "================================================"
echo "  Iniciando Frontend - Pastelería Real Web"
echo "================================================"
echo ""

cd web

# Verificar si Node.js está instalado
if ! command -v node &> /dev/null; then
    echo "❌ Error: Node.js no está instalado"
    echo "Por favor instala Node.js 18 o superior"
    exit 1
fi

# Verificar versión de Node.js
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "❌ Error: Se requiere Node.js 18 o superior"
    echo "Versión actual: $(node -v)"
    exit 1
fi

echo "✅ Node.js versión: $(node -v)"
echo "✅ npm versión: $(npm -v)"
echo ""

# Verificar si node_modules existe
if [ ! -d "node_modules" ]; then
    echo "📦 Instalando dependencias..."
    echo "Esto puede tomar algunos minutos..."
    echo ""
    npm install
    
    if [ $? -ne 0 ]; then
        echo ""
        echo "❌ Error al instalar dependencias"
        exit 1
    fi
    echo ""
    echo "✅ Dependencias instaladas correctamente"
fi

echo ""
echo "🚀 Iniciando servidor de desarrollo..."
echo ""
echo "📍 Aplicación disponible en: http://localhost:5173"
echo ""
echo "⚠️  Asegúrate de que el backend esté ejecutándose en http://localhost:8080"
echo ""
echo "Presiona Ctrl+C para detener el servidor"
echo ""
echo "================================================"
echo ""

npm run dev
