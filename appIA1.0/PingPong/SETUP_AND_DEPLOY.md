# Guía Completa de Desarrollo y Publicación - Ping Pong Game

## 📱 Descripción del Proyecto

**Ping Pong** es un juego móvil clásico desarrollado con Flutter, optimizado para publicación en Google Play Store. Features:

- Juego de Ping Pong vs IA adaptativa
- Dificultad progresiva
- Interfaz moderna con gradientes y sombras
- Controles táctiles intuitivos
- Totalmente optimizado para Play Store

---

## 🚀 Inicio Rápido

### Requisitos Previos

- **Flutter SDK**: 3.0 o superior
  ```bash
  flutter --version
  ```
- **Android SDK**: API 21 mínimo
- **Dart**: Incluido con Flutter
- **Git**: Para control de versiones (opcional)

### Instalación y Ejecución

1. **Navega a la carpeta del proyecto**
   ```bash
   cd PingPong
   ```

2. **Obtén las dependencias**
   ```bash
   flutter pub get
   ```

3. **Ejecuta en modo debug**
   ```bash
   flutter run
   ```

4. **O conecta un dispositivo Android**
   ```bash
   adb devices
   flutter run
   ```

---

## 📁 Estructura del Proyecto

```
PingPong/
├── lib/
│   ├── main.dart                          # Punto de entrada
│   ├── screens/
│   │   ├── home_screen.dart              # Pantalla principal con menu
│   │   └── game_screen.dart              # Pantalla del juego
│   └── models/
│       └── game_state.dart               # Lógica del juego
│
├── android/
│   ├── app/
│   │   ├── AndroidManifest.xml           # Configuración de la app
│   │   ├── build.gradle                  # Build del app
│   │   ├── proguard-rules.pro            # Reglas de ofuscación
│   │   └── src/main/kotlin/com/pingpong/game/
│   │       └── MainActivity.kt           # Actividad principal
│   ├── build.gradle                      # Build del proyecto
│   ├── gradle.properties                 # Propiedades de Gradle
│   └── settings.gradle                   # Configuración de módulos
│
├── pubspec.yaml                          # Dependencias y metadata
├── analysis_options.yaml                 # Reglas de análisis
├── README.md                             # Documentación principal
├── PLAY_STORE_GUIDE.md                  # Guía de publicación
├── SETUP_AND_DEPLOY.md                  # Este archivo
└── .gitignore                           # Archivos a ignorar en Git
```

---

## 🎮 Características del Juego

### Mecánicas Principales

1. **Controles**
   - Desliza verticalmente para mover la paleta
   - Muévete arriba/abajo para interceptar la pelota

2. **Sistema de Puntuación**
   - Primera en llegar a 11 puntos gana
   - IA aumenta dificultad cada 3 puntos

3. **Física del Juego**
   - Colisiones realistas
   - Efecto de spin según impacto
   - Velocidad progresiva

4. **Dificultad de IA**
   - Nivel 1 (puntos 0-2): Velocidad moderada
   - Nivel 2 (puntos 3-5): Velocidad aumentada
   - Nivel 3+ (puntos 6+): Velocidad muy alta

---

## 🔧 Compilación y Empaquetado

### Compilación para Desarrollo

```bash
# Build debug
flutter build apk

# Run debug
flutter run

# Build release local
flutter build apk --release
```

### Compilación para Play Store

#### Paso 1: Generar Certificado de Firma

```bash
# En Windows PowerShell
keytool -genkey -v -keystore "$env:USERPROFILE\upload-keystore.jks" `
  -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 `
  -alias upload
```

**Información necesaria:**
- Contraseña keystore: (anótala seguro)
- Contraseña clave: (anótala seguro)
- Nombre y apellido: Tu nombre
- Nombre de unidad organizativa: Compañía
- Nombre de organización: Compañía
- Nombre de ciudad: Ciudad
- Nombre de estado/provincia: Estado
- Código de país: ES (o tu código)

#### Paso 2: Crear Archivo de Propiedades

Crea `android/key.properties`:

```properties
storePassword=TU_CONTRASEÑA_KEYSTORE
keyPassword=TU_CONTRASEÑA_CLAVE
keyAlias=upload
storeFile=C:\\Users\\TU_USUARIO\\upload-keystore.jks
```

**⚠️ Seguridad:**
- NO compartas este archivo
- Agrega a `.gitignore`
- Guarda contraseñas en lugar seguro

#### Paso 3: Compilar App Bundle

```bash
# App Bundle (recomendado para Play Store)
flutter build appbundle --release

# Ubicación: build/app/outputs/bundle/release/app-release.aab
```

O si prefieres APK:

```bash
# APK
flutter build apk --release

# Ubicación: build/app/outputs/apk/release/app-release.apk
```

---

## 📤 Publicación en Google Play Store

### Requisitos Previos

1. **Cuenta de Google Play**
   - Crear cuenta en https://play.google.com/console
   - Pagar tarifa de registración ($25 USD)

2. **Datos necesarios:**
   - Título: "Ping Pong"
   - Descripción corta: "Juego de reflejos clásico"
   - Descripción completa: Ver PLAY_STORE_GUIDE.md
   - Categoría: Games > Arcade
   - Calificación de contenido: Sin restricciones

3. **Activos visuales (recomendado):**
   - Icono: 512x512 PNG
   - Captura de pantalla: 1080x1920 (mínimo 2-5)
   - Gráfico característico: 1024x500

### Pasos para Publicar

1. **Accede a Google Play Console**
   ```
   https://play.google.com/console
   ```

2. **Crea una nueva aplicación**
   - Click en "Crear app"
   - Nombre: "Ping Pong"
   - Idioma predeterminado: Español
   - Tipo: App (no juego inicialmente)
   - Categoría: Games

3. **Completa información de la app**
   - Descripción breve (80 caracteres)
   - Descripción completa (4000 caracteres)
   - URL de soporte
   - URL de política de privacidad
   - Email de contacto

4. **Sube el archivo**
   - Ve a "Lanzamiento" → "Producción"
   - Click en "Crear lanzamiento"
   - Sube `app-release.aab`

5. **Revisa contenido**
   - Rellena cuestionario de privacidad
   - Selecciona calificación de contenido
   - Confirma permisos solicitados

6. **Envía para revisión**
   - Revisa todo antes de enviar
   - Click en "Enviar para revisión"
   - Google revisará en 1-3 horas típicamente

### Después de Publicar

- Monitora descargas y comentarios
- Responde a reseñas de usuarios
- Planifica actualizaciones
- Incrementa versionCode para nuevas versiones

---

## 🐛 Solución de Problemas

### Error: "Flutter not found"
```bash
# Agrega Flutter al PATH de Windows
# O ejecuta desde la carpeta de Flutter:
C:\path\to\flutter\bin\flutter run
```

### Error en compilación Android
```bash
flutter clean
flutter pub get
flutter pub upgrade
flutter build apk --release
```

### Error de firma
```bash
# Verifica que key.properties existe
# Verifica rutas en key.properties
# Comprueba contraseña
```

### Juego lento o con lag
```bash
# Ejecuta en modo release
flutter run --release

# Verifica dispositivo: adb devices
```

### APK/AAB muy grande
```bash
# Ya está optimizado con:
# - minifyEnabled = true
# - shrinkResources = true
# - proguard rules
```

---

## 📊 Monitoreo y Estadísticas

Después de publicar, puedes ver:

- **Descargas y usuarios activos**: Android Studio
- **Comentarios y calificaciones**: Play Console
- **Crashes y errores**: Firebase Crashlytics (opcional)
- **Retención de usuarios**: Play Console Analytics

---

## 🔄 Actualizar la Aplicación

Para publicar una nueva versión:

1. **Incrementa versionCode** en `pubspec.yaml`
   ```yaml
   version: 1.1.0+2  # versionCode = 2
   ```

2. **Compila nuevo AAB**
   ```bash
   flutter build appbundle --release
   ```

3. **Sube a Play Console**
   - Crea nuevo lanzamiento
   - Sube AAB
   - Actualiza notas de lanzamiento
   - Envía para revisión

---

## 📝 Código de Conducta y Políticas

### Requisitos de Google Play

- ✅ Sin violencia extrema
- ✅ Sin contenido sexual
- ✅ Sin engaños
- ✅ Sin privacidad de datos
- ✅ Cumple leyes locales

### Privacidad

El juego NO recopila:
- Datos personales
- Ubicación
- Contactos
- Información de dispositivo

---

## 📚 Recursos Útiles

- **Flutter Documentation**: https://flutter.dev/docs
- **Google Play Console**: https://play.google.com/console
- **Android Documentation**: https://developer.android.com
- **Dart Language**: https://dart.dev

---

## 🎯 Próximos Pasos

1. ✅ Instala Flutter
2. ✅ Ejecuta flutter run
3. ✅ Prueba el juego
4. ✅ Genera certificado de firma
5. ✅ Compila AAB
6. ✅ Crea cuenta Play Console
7. ✅ Publica aplicación
8. ✅ Monitorea estadísticas

---

## 📞 Soporte

Para problemas:
- Revisa logs: `flutter logs`
- Limpialimpiar caché: `flutter clean`
- Actualiza dependencias: `flutter pub upgrade`

---

**¡Felicidades! Tu juego Ping Pong está listo para las masas.**
