# 🏗️ Arquitectura - GreenGo Logistics

## 📐 Diagrama de Arquitectura

```
┌─────────────────────────────────────────────────────────────┐
│                     GREENGO LOGISTICS APP                    │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                        PRESENTATION LAYER                    │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐         │
│  │    Home     │  │   Rider     │  │ Supervisor  │         │
│  │   Screen    │  │   Screen    │  │   Screen    │         │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘         │
│         │                │                │                  │
│         └────────────────┼────────────────┘                  │
│                          │                                   │
│                          ▼                                   │
│                  ┌───────────────┐                          │
│                  │    Widgets    │                          │
│                  ├───────────────┤                          │
│                  │ DeliveryCard  │                          │
│                  │ ProgressCard  │                          │
│                  │ TimelineView  │                          │
│                  │ RiderCard     │                          │
│                  └───────────────┘                          │
└───────────────────────────┬─────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                       BUSINESS LOGIC LAYER                   │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│                  ┌───────────────────┐                       │
│                  │ DeliveryProvider  │                       │
│                  │  (ChangeNotifier) │                       │
│                  ├───────────────────┤                       │
│                  │ • loadDeliveries  │                       │
│                  │ • markAsDelivered │                       │
│                  │ • markAsPending   │                       │
│                  │ • resetDeliveries │                       │
│                  │ • getByRider      │                       │
│                  └─────────┬─────────┘                       │
│                            │                                 │
└────────────────────────────┼─────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────┐
│                         DATA LAYER                           │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────┐              ┌──────────────────┐         │
│  │    Models    │              │   Persistence    │         │
│  ├──────────────┤              ├──────────────────┤         │
│  │  Delivery    │◄────────────►│ SharedPreferences│         │
│  │   • id       │              │   (JSON Store)   │         │
│  │   • customer │              └──────────────────┘         │
│  │   • address  │                                            │
│  │   • time     │                                            │
│  │   • rider    │                                            │
│  │   • status   │                                            │
│  └──────────────┘                                            │
└─────────────────────────────────────────────────────────────┘
```

## 🔄 Flujo de Datos

### Escenario 1: Marcar Entrega como Completada

```
┌────────┐     ┌────────┐     ┌──────────┐     ┌──────────┐
│  User  │────►│   UI   │────►│ Provider │────►│ Storage  │
│        │     │ Widget │     │          │     │  (SP)    │
└────────┘     └───┬────┘     └────┬─────┘     └────┬─────┘
                   │               │                 │
                   │◄──────────────┘                 │
                   │     notifyListeners()           │
                   │                                 │
                   │◄────────────────────────────────┘
                   │         Data saved
                   │
                   ▼
            UI actualizado
```

### Escenario 2: Cargar Entregas al Inicio

```
┌────────┐     ┌──────────┐     ┌──────────┐     ┌────────┐
│  App   │────►│ Provider │────►│ Storage  │────►│   UI   │
│ Start  │     │  load()  │     │  (SP)    │     │Refresh │
└────────┘     └──────────┘     └──────────┘     └────────┘
                    │                  │
                    ▼                  ▼
              Get saved data    Return JSON
                    │                  │
                    └──────►Parse◄─────┘
                            │
                            ▼
                      Update State
                            │
                            ▼
                    notifyListeners()
```

## 📦 Estructura de Componentes

### Jerarquía de Widgets

```
MyApp (MaterialApp)
│
└─── ChangeNotifierProvider
     │
     └─── HomeScreen
          ├─── RoleCard (Repartidor)
          │    └─► Navigator → RiderScreen
          │                    ├─── Dropdown (Selección)
          │                    ├─── StatsCard
          │                    └─── ListView
          │                         └─── DeliveryCard (múltiples)
          │                              ├─── AnimatedContainer
          │                              └─── BottomSheet (detalles)
          │
          └─── RoleCard (Supervisor)
               └─► Navigator → SupervisorScreen
                                └─── TabBar
                                     ├─── Tab 1: Resumen
                                     │    ├─── ProgressCard
                                     │    │    └─── CustomPainter
                                     │    └─── StatCards
                                     │
                                     ├─── Tab 2: Repartidores
                                     │    └─── RiderPerformanceCard
                                     │         └─── ExpansionTile
                                     │
                                     └─── Tab 3: Timeline
                                          └─── DeliveryTimeline
                                               └─── CustomTimeline
```

## 🎨 Patrón de Diseño

### Provider Pattern (State Management)

```dart
// 1. DEFINIR PROVIDER
class DeliveryProvider extends ChangeNotifier {
  List<Delivery> _deliveries = [];
  
  Future<void> markAsDelivered(String id) async {
    // Actualizar estado
    _deliveries[index] = updatedDelivery;
    // Guardar
    await _saveDeliveries();
    // Notificar
    notifyListeners();
  }
}

// 2. PROVEER EN LA RAÍZ
ChangeNotifierProvider(
  create: (_) => DeliveryProvider(),
  child: MaterialApp(...)
)

// 3. CONSUMIR EN WIDGETS
Consumer<DeliveryProvider>(
  builder: (context, provider, child) {
    return ListView(
      children: provider.deliveries.map(...)
    );
  }
)
```

## 🔐 Gestión de Estado

### Estados de la Aplicación

```
┌─────────────────────────────────────┐
│       GLOBAL STATE (Provider)       │
├─────────────────────────────────────┤
│ • Lista de entregas                 │
│ • Estado de cada entrega            │
│ • Estadísticas calculadas           │
│ • Filtros y agrupaciones           │
└─────────────────────────────────────┘
            │
            ├──► LOCAL STATE (StatefulWidget)
            │    • Animaciones
            │    • Formularios
            │    • UI temporales
            │
            └──► PERSISTENT STATE (SharedPreferences)
                 • Entregas guardadas
                 • Timestamps
                 • Configuraciones
```

## 📱 Navegación

### Stack de Navegación

```
┌──────────────┐
│ HomeScreen   │  ← Inicio
└──────┬───────┘
       │
       ├─► Push ─► ┌──────────────┐
       │           │ RiderScreen  │
       │           └──────────────┘
       │
       └─► Push ─► ┌────────────────────┐
                   │ SupervisorScreen   │
                   │  ┌──────────────┐  │
                   │  │ TabController│  │
                   │  ├──────────────┤  │
                   │  │ Tab 1        │  │
                   │  │ Tab 2        │  │
                   │  │ Tab 3        │  │
                   │  └──────────────┘  │
                   └────────────────────┘
```

## 💾 Persistencia de Datos

### Ciclo de Vida de Datos

```
┌──────────────────────────────────────────┐
│            App Lifecycle                 │
├──────────────────────────────────────────┤
│                                          │
│  App Start                               │
│      │                                   │
│      ▼                                   │
│  Load from SharedPreferences             │
│      │                                   │
│      ├─► Data exists? ──Yes──► Parse    │
│      │                          │        │
│      └─► No? ──► Use defaults   │        │
│                        │         │        │
│                        └─────────┘        │
│                              │            │
│                              ▼            │
│                        Update State       │
│                              │            │
│                              ▼            │
│                         Render UI         │
│                                          │
│  User Action (Mark Delivered)            │
│      │                                   │
│      ▼                                   │
│  Update State                            │
│      │                                   │
│      ▼                                   │
│  Save to SharedPreferences               │
│      │                                   │
│      ▼                                   │
│  notifyListeners()                       │
│      │                                   │
│      ▼                                   │
│  UI Rebuilds                             │
│                                          │
└──────────────────────────────────────────┘
```

## 🎭 Manejo de Eventos

### Flujo de Eventos de Usuario

```
User Tap on ✓ Button
        │
        ▼
    onPressed()
        │
        ▼
provider.markAsDelivered(id)
        │
        ├─► Update local state
        │
        ├─► Save to SharedPreferences
        │
        ├─► notifyListeners()
        │
        └─► UI rebuilds
                │
                ├─► Show SnackBar
                │
                ├─► Animate card
                │
                └─► Move to completed section
```

## 🏭 Factory Pattern en Models

```dart
class Delivery {
  // Constructor normal
  Delivery({...});
  
  // Factory para crear desde JSON
  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      id: json['id'],
      customer: json['customerName'],
      ...
    );
  }
  
  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      ...
    };
  }
  
  // Copy with para inmutabilidad
  Delivery copyWith({...}) {
    return Delivery(
      id: id ?? this.id,
      ...
    );
  }
}
```

## 🎨 Theming Architecture

```
AppTheme (Static Class)
    │
    ├─── Colors (Static Constants)
    │    ├─── primaryGreen
    │    ├─── darkGreen
    │    ├─── accentOrange
    │    └─── ...
    │
    └─── lightTheme (ThemeData)
         ├─── ColorScheme
         ├─── AppBarTheme
         ├─── CardTheme
         ├─── ButtonTheme
         └─── TextTheme
              ├─── headlineLarge
              ├─── titleLarge
              ├─── bodyMedium
              └─── ...
```

## 🔄 Ciclo de Vida Completo

```
1. main() ejecutado
   ↓
2. MyApp widget creado
   ↓
3. ChangeNotifierProvider inicializado
   ↓
4. DeliveryProvider creado
   ↓
5. loadDeliveries() llamado
   ↓
6. SharedPreferences leído
   ↓
7. Estado inicial establecido
   ↓
8. HomeScreen renderizado
   ↓
9. Usuario navega → RiderScreen
   ↓
10. Consumer escucha cambios
    ↓
11. Usuario marca entrega
    ↓
12. Provider actualiza estado
    ↓
13. Datos guardados en SharedPreferences
    ↓
14. notifyListeners() disparado
    ↓
15. Consumer reconstruye UI
    ↓
16. Animaciones ejecutadas
    ↓
17. Usuario ve feedback
```

## 📊 Separación de Responsabilidades

```
┌──────────────────────────────────────┐
│            SCREENS                   │
│ Responsabilidad: Estructura y layout │
└──────────────────────────────────────┘
                │
                ▼
┌──────────────────────────────────────┐
│            WIDGETS                   │
│ Responsabilidad: UI components       │
└──────────────────────────────────────┘
                │
                ▼
┌──────────────────────────────────────┐
│            PROVIDERS                 │
│ Responsabilidad: Business logic      │
└──────────────────────────────────────┘
                │
                ▼
┌──────────────────────────────────────┐
│            MODELS                    │
│ Responsabilidad: Data structure      │
└──────────────────────────────────────┘
                │
                ▼
┌──────────────────────────────────────┐
│            THEME                     │
│ Responsabilidad: Visual styling      │
└──────────────────────────────────────┘
```

---

<div align="center">
  <strong>Arquitectura Limpia · Escalable · Mantenible</strong>
</div>
