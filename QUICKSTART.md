# ⚡ Inicio Rápido - GreenGo Logistics

## 🚀 En 3 Pasos

### 1️⃣ Instalar Dependencias
```powershell
flutter pub get
```

### 2️⃣ Verificar Dispositivo
```powershell
flutter devices
```

### 3️⃣ Ejecutar App
```powershell
flutter run
```

## 📱 Primera Vez

### Opción 1: Usar el Script (Recomendado)
```powershell
.\setup.ps1
```

### Opción 2: Manual
```powershell
# Verificar Flutter
flutter doctor

# Instalar dependencias
flutter pub get

# Ver dispositivos disponibles
flutter devices

# Ejecutar
flutter run
```

## 🎯 Probar la App

### Como Repartidor:
1. Toca **"Repartidor"**
2. Selecciona **"Carlos Ruiz"**
3. Toca el botón **✓** en una entrega
4. ¡Listo! Verás la confirmación

### Como Supervisor:
1. Toca **"Supervisor"**
2. Explora las **3 pestañas**:
   - 📊 Resumen
   - 👥 Repartidores
   - 📅 Timeline
3. Expande las tarjetas para más detalles

## 📚 Documentación

- **README.md**: Documentación completa
- **DEMO_GUIDE.md**: Guía para demostrar la app
- **TUTORIAL.md**: Tutorial paso a paso
- **PROJECT_SUMMARY.md**: Resumen del proyecto

## 🆘 Problemas Comunes

### Error: "Unable to locate package"
```powershell
flutter clean
flutter pub get
```

### Error: "No devices found"
- **Móvil**: Conecta tu dispositivo y habilita USB debugging
- **Emulador**: Abre Android Studio o Xcode
- **Web**: Usa `flutter run -d chrome`

### Error al ejecutar
```powershell
# Limpiar cache
flutter clean

# Reinstalar dependencias
flutter pub get

# Intentar de nuevo
flutter run
```

## ⚙️ Comandos Útiles

```powershell
# Modo debug (con hot reload)
flutter run

# Modo release (más rápido)
flutter run --release

# En web
flutter run -d chrome

# Ver logs
flutter logs

# Limpiar proyecto
flutter clean
```

## 🎨 Personalizar

### Cambiar colores:
Edita: `lib/theme/app_theme.dart`

### Cambiar datos:
Edita: `lib/providers/delivery_provider.dart`

### Agregar pantallas:
Crea en: `lib/screens/`

## 💡 Tips

- **Hot Reload**: Presiona `r` en la terminal
- **Hot Restart**: Presiona `R` en la terminal
- **Refresh**: Usa el botón 🔄 en la app
- **Reset**: Menú ⋮ → Resetear entregas

## 📞 Ayuda

Si tienes problemas:
1. Revisa **README.md** para más detalles
2. Consulta **TUTORIAL.md** para uso de la app
3. Lee **DEMO_GUIDE.md** para demostración

## ✅ Checklist de Inicio

- [ ] Flutter instalado (`flutter --version`)
- [ ] Dispositivo/emulador disponible (`flutter devices`)
- [ ] Dependencias instaladas (`flutter pub get`)
- [ ] App ejecutándose (`flutter run`)
- [ ] Probado como Repartidor
- [ ] Probado como Supervisor

## 🎯 ¿Listo?

```powershell
# Todo en uno
flutter pub get; flutter run
```

---

<div align="center">
  <strong>¡Disfruta desarrollando con Flutter! 🚀</strong>
</div>
