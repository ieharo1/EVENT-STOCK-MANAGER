# GESTOR DE ALIMENTOS HOGAR

---

## Descripcion

**Gestor de Alimentos Hogar** es una aplicación Android desarrollada en Flutter que permite gestionar alimentos almacenados en:

- **Refrigeración**: Alimentos refrigerados y congelados
- **Alacena**: Artículos almacenados en despensa

La aplicación funciona 100% offline, sin necesidad de conexión a internet.

---

## Características

- ✅ Agregar artículos a Refrigeración o Alacena
- ✅ Buscar artículos en tiempo real
- ✅ Editar artículos existentes
- ✅ Eliminar artículos
- ✅ Persistencia local con Hive Database
- ✅ Diseño Material Design 3 moderno
- ✅ Soporte modo claro/oscuro
- ✅ Validaciones completas
- ✅ UI responsiva y animada

---

## Arquitectura del Sistema

```
┌────────────────────────────────────────────────────────────────────────────────────┐
│                        GESTOR DE ALIMENTOS HOGAR                                  │
├────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                    │
│  ┌───────────────────────┐                                                        │
│  │   Pantalla Principal   │                                                        │
│  │  Refrigeración / Alacena │                                                      │
│  └──────────────┬────────┘                                                        │
│                 │                                                                 │
│                 ▼                                                                 │
│  ┌──────────────────────────────────────────────────────────────────────────────┐  │
│  │ Presentación (Screens, Widgets, Providers)                                   │  │
│  │ - HomeScreen                                                                  │  │
│  │ - RefrigeracionScreen                                                          │  │
│  │ - AlacenaScreen                                                               │  │
│  │ - AboutScreen                                                                 │  │
│  └──────────────────────────────────────────────────────────────────────────────┘  │
│                 │                                                                 │
│                 ▼                                                                 │
│  ┌──────────────────────────────────────────────────────────────────────────────┐  │
│  │ Datos (Repository, Database)                                                  │  │
│  │ - FoodRepository                                                              │  │
│  │ - Hive Database (Offline)                                                     │  │
│  └──────────────────────────────────────────────────────────────────────────────┘  │
│                                                                                    │
│  + Persistencia 100% Local - Sin conexión a internet                               │
└────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Stack Tecnologico

| Componente | Version | Descripcion |
|------------|---------|-------------|
| Flutter | 3.41.x | Framework principal |
| Dart | 3.11.x | Lenguaje de programación |
| Provider | 6.1.x | Gestión de estado |
| Hive | 2.2.x | Base de datos local |
| Material Design 3 | - | Diseño UI |

---

## Estructura del Proyecto

```
gestor_alimentos_hogar/
│
├── lib/
│   ├── core/
│   │   └── constants/
│   │       └── app_constants.dart
│   │
│   ├── data/
│   │   ├── database/
│   │   │   └── database_service.dart
│   │   ├── models/
│   │   │   └── food_item.dart
│   │   └── repositories/
│   │       └── food_repository.dart
│   │
│   ├── presentation/
│   │   ├── providers/
│   │   │   └── food_provider.dart
│   │   ├── screens/
│   │   │   ├── home_screen.dart
│   │   │   ├── refrigeracion_screen.dart
│   │   │   ├── alacena_screen.dart
│   │   │   └── about_screen.dart
│   │   └── widgets/
│   │       ├── food_item_card.dart
│   │       └── add_food_item_form.dart
│   │
│   └── main.dart
│
├── android/
├── ios/
├── pubspec.yaml
└── README.md
```

---

## Requisitos Previos

- Flutter SDK 3.x
- Android SDK
- Android Studio o VS Code

---

## Instalacion

### 1. Clonar el repositorio
```bash
git clone https://github.com/ieharo1/EVENT-STOCK-MANAGER.git
cd EVENT-STOCK-MANAGER
```

### 2. Instalar dependencias
```bash
flutter pub get
```

### 3. Ejecutar en emulador
```bash
flutter run
```

### 4. Compilar APK debug
```bash
flutter build apk --debug
```

### 5. Compilar APK release
```bash
flutter build apk --release
```

---

## Uso de la App

### Pantalla Principal
- Selecciona **Refrigeración** o **Alacena** para gestionar tus alimentos

### Agregar Artículo
1. Toca el botón **"+ Agregar"**
2. Completa el formulario:
   - Nombre del artículo
   - Cantidad
   - Fecha de ingreso
   - Tipo (Refrigerado/Congelado - solo para Refrigeración)
3. Toca **"Guardar"**

### Editar Artículo
1. Toca el botón de **editar** (lápiz) en la tarjeta del artículo
2. Modifica los datos
3. Toca **"Actualizar"**

### Eliminar Artículo
1. Toca el botón de **eliminar** (basura) en la tarjeta
2. Confirma la eliminación

### Buscar Artículo
- Usa la barra de búsqueda en cada pantalla para filtrar artículos

---

## Base de Datos

La aplicación usa **Hive** para persistencia local:

- **Entidad**: FoodItem
  - id: String (UUID)
  - category: String (Refrigeracion/Alacena)
  - type: String? (Refrigerado/Congelado)
  - name: String
  - quantity: int
  - entryDate: DateTime

---

## Desarrollado por Isaac Esteban Haro Torres

**Ingeniero en Sistemas · Full Stack Developer · Automatizacion · Data**

- Email: zackharo1@gmail.com
- WhatsApp: 098805517
- GitHub: https://github.com/ieharo1
- Portafolio: https://ieharo1.github.io/portafolio-isaac.haro/

---

## Licencia

© 2026 Isaac Esteban Haro Torres - Todos los derechos reservados.
