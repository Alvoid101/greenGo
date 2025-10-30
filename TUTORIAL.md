# 🎓 Tutorial - GreenGo Logistics App

## Introducción

Este tutorial te guiará paso a paso en el uso de la aplicación GreenGo Logistics.

## 📱 Capturas de Pantalla y Uso

### 1️⃣ Pantalla de Inicio

```
┌─────────────────────────────┐
│      🚴 GreenGo Logo        │
│   GreenGo Logistics         │
│  Entregas sostenibles       │
│                             │
│  ┌───────────────────────┐  │
│  │ 🚚 Repartidor        →│  │
│  │ Gestiona tus entregas │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │ 👨‍💼 Supervisor       →│  │
│  │ Monitorea el progreso │  │
│  └───────────────────────┘  │
└─────────────────────────────┘
```

**¿Qué hacer?**
- Toca "Repartidor" si eres un repartidor
- Toca "Supervisor" si eres un supervisor

---

### 2️⃣ Panel del Repartidor

#### Paso 1: Seleccionar tu perfil

```
┌─────────────────────────────┐
│ ← Panel del Repartidor   🔄 │
├─────────────────────────────┤
│ Selecciona tu perfil        │
│ ┌─────────────────────────┐ │
│ │ 👤 Carlos Ruiz        ▼│ │
│ └─────────────────────────┘ │
└─────────────────────────────┘
```

**Opciones disponibles:**
- Carlos Ruiz
- Laura Sánchez
- Miguel Torres

#### Paso 2: Ver tus estadísticas

```
┌─────────────────────────────┐
│  ⏳ Pendientes │ ✅ Completadas │ 🚚 Total
│      2         │       1        │   3
└─────────────────────────────┘
```

#### Paso 3: Gestionar entregas

**Entrega Pendiente:**
```
┌─────────────────────────────┐
│ ⏰ María González       ✓   │
│ Pedido #001                 │
│ 📍 Calle Mayor 123, Apto 4B │
│ ⏰ 10:00 - 11:00            │
└─────────────────────────────┘
```

**Después de marcar como entregada:**
```
┌─────────────────────────────┐
│ ✅ María González       ↻   │
│ Pedido #001                 │
│ 📍 Calle Mayor 123, Apto 4B │
│ ⏰ 10:00 - 11:00            │
│ ✓ Entregado a las 10:35    │
└─────────────────────────────┘
```

**Acciones:**
- Toca ✓ para marcar como entregada
- Toca ↻ para desmarcar (deshacer)
- Toca la tarjeta para ver detalles

---

### 3️⃣ Panel del Supervisor

#### Pestaña 1: Resumen

```
┌─────────────────────────────┐
│ ← Supervisor  📊 👥 📅 🔄 ⋮│
├─────────────────────────────┤
│    Progreso General         │
│                             │
│        ╱───────╲            │
│       │   75%   │           │
│       │  6 de 8 │           │
│        ╲───────╱            │
│                             │
│ ⏳ Pendientes │ ✅ Completadas│
│      2        │      6       │
│                             │
│ 🚴 Repartidores │ 📦 Total  │
│       3         │     8      │
└─────────────────────────────┘
```

**Características:**
- Círculo de progreso animado
- Actualización en tiempo real
- Estadísticas generales

#### Pestaña 2: Repartidores

```
┌─────────────────────────────┐
│ Carlos Ruiz              ▼  │
│ ✅ 2 completadas │ ⏳ 1 pendiente
│ [████████░░] 67%            │
│                             │
│   Entregas asignadas:       │
│   ✅ María González         │
│   ✅ Juan Pérez            │
│   ⏰ Elena Castro          │
└─────────────────────────────┘
```

**Funciones:**
- Ver rendimiento por repartidor
- Expandir para ver detalles
- Porcentaje de completitud

#### Pestaña 3: Timeline

```
┌─────────────────────────────┐
│  ●───10:00-11:00            │
│  │   ✅ María González      │
│  │   Calle Mayor 123        │
│  │                          │
│  ●───11:00-12:00            │
│  │   ✅ Juan Pérez          │
│  │   Av. Libertador 456     │
│  │                          │
│  ●───12:00-13:00            │
│  │   ⏰ Ana Martínez        │
│      Plaza Central 789      │
└─────────────────────────────┘
```

**Información:**
- Vista cronológica
- Estados visuales
- Conexión entre entregas

---

## 🎯 Casos de Uso Comunes

### Caso 1: Completar una entrega

1. Abre la app como **Repartidor**
2. Selecciona tu nombre del dropdown
3. Encuentra la entrega en la lista
4. Toca el botón **✓** 
5. ¡Verás un mensaje de confirmación!

### Caso 2: Ver progreso del equipo

1. Abre la app como **Supervisor**
2. Ve el círculo de progreso en la pestaña "Resumen"
3. Cambia a "Repartidores" para ver detalles individuales
4. Explora la "Timeline" para vista cronológica

### Caso 3: Verificar una entrega específica

1. En cualquier pantalla con entregas
2. Toca la **tarjeta de entrega**
3. Se abrirá un modal con todos los detalles:
   - Cliente
   - Dirección completa
   - Hora de entrega
   - Repartidor asignado
   - Estado actual

---

## 💡 Consejos y Trucos

### Para Repartidores

✅ **Organización:**
- Las entregas aparecen ordenadas por estado
- Primero las pendientes, luego las completadas
- Usa el refresh (🔄) para actualizar

✅ **Velocidad:**
- Un solo toque completa la entrega
- No necesitas confirmar
- La app guarda automáticamente

### Para Supervisores

📊 **Monitoreo:**
- El progreso se actualiza en tiempo real
- Usa las pestañas para diferentes vistas
- Puedes expandir las tarjetas de repartidores

🔄 **Gestión:**
- Usa el menú (⋮) para resetear datos de prueba
- El refresh (🔄) recarga desde el almacenamiento
- Las estadísticas se calculan automáticamente

---

## 🔧 Resolución de Problemas

### La app no muestra mis cambios

**Solución:**
1. Toca el botón de refresh (🔄)
2. Si persiste, cierra y reabre la app

### Quiero empezar de nuevo

**Solución:**
1. Ve al panel del Supervisor
2. Toca el menú (⋮) arriba a la derecha
3. Selecciona "Resetear entregas"
4. Confirma la acción

### No veo mis entregas

**Solución:**
1. Verifica que hayas seleccionado tu nombre
2. Si la lista está vacía, puede que ya completaste todas
3. Revisa la sección "Entregas Completadas" más abajo

---

## 📊 Entender las Estadísticas

### Repartidor

| Métrica | Significado |
|---------|-------------|
| Pendientes | Entregas que aún no has completado |
| Completadas | Entregas que ya entregaste |
| Total | Todas tus entregas asignadas |

### Supervisor

| Métrica | Significado |
|---------|-------------|
| Porcentaje | % de entregas completadas del total |
| Repartidores | Número de repartidores activos |
| Total | Total de entregas del día |

### Código de Colores

- 🟢 **Verde**: Entrega completada
- 🟠 **Naranja**: Entrega pendiente
- 🔵 **Azul**: Información general

---

## 🎨 Personalización

### Datos de Prueba

La app viene con datos de ejemplo:
- 8 entregas
- 3 repartidores
- Horarios de 10:00 a 18:00

Para cambiar estos datos, edita el archivo:
```
lib/providers/delivery_provider.dart
```

Busca la función `_getInitialDeliveries()`

---

## 🚀 Siguientes Pasos

Una vez que domines la app básica, puedes:

1. ✨ Personalizar los colores en `lib/theme/app_theme.dart`
2. 📝 Agregar más campos al modelo de `Delivery`
3. 🔔 Implementar notificaciones
4. 🌐 Conectar a un backend real (Firebase)
5. 📱 Agregar más funcionalidades

---

## 📞 Ayuda Adicional

¿Tienes preguntas? Consulta:
- **README.md**: Documentación técnica completa
- **DEMO_GUIDE.md**: Guía para demostración
- Código fuente: Todos los archivos están comentados

---

<div align="center">
  <strong>¡Disfruta usando GreenGo Logistics! 🚴‍♂️💚</strong>
</div>
