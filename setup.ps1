# GreenGo Logistics - Script de Ayuda
# Para ejecutar: .\setup.ps1

Write-Host "================================" -ForegroundColor Green
Write-Host "  GreenGo Logistics Setup" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
Write-Host ""

# Verificar Flutter
Write-Host "Verificando Flutter..." -ForegroundColor Yellow
$flutterVersion = flutter --version 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Flutter instalado correctamente" -ForegroundColor Green
    flutter --version | Select-String "Flutter"
} else {
    Write-Host "✗ Flutter no encontrado. Por favor instala Flutter primero." -ForegroundColor Red
    Write-Host "  Visita: https://flutter.dev/docs/get-started/install" -ForegroundColor Cyan
    exit 1
    

Write-Host ""

# Verificar dispositivos
Write-Host "Verificando dispositivos disponibles..." -ForegroundColor Yellow
flutter devices
Write-Host ""

# Instalar dependencias
Write-Host "Instalando dependencias..." -ForegroundColor Yellow
flutter pub get

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Dependencias instaladas correctamente" -ForegroundColor Green
} else {
    Write-Host "✗ Error al instalar dependencias" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "================================" -ForegroundColor Green
Write-Host "  Setup completado!" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
Write-Host ""
Write-Host "Comandos disponibles:" -ForegroundColor Cyan
Write-Host "  flutter run          - Ejecutar la app" -ForegroundColor White
Write-Host "  flutter run --release - Ejecutar en modo release (más rápido)" -ForegroundColor White
Write-Host "  flutter clean        - Limpiar cache" -ForegroundColor White
Write-Host "  flutter doctor       - Ver estado del entorno" -ForegroundColor White
Write-Host ""
Write-Host "¿Deseas ejecutar la app ahora? (S/N): " -ForegroundColor Yellow -NoNewline
$respuesta = Read-Host

if ($respuesta -eq "S" -or $respuesta -eq "s") {
    Write-Host ""
    Write-Host "Iniciando app..." -ForegroundColor Green
    flutter run
}
