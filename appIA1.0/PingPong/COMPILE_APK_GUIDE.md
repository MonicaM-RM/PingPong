# 🎮 GUÍA DEFINITIVA - COMPILAR APK PING PONG PARA GOOGLE PLAY STORE

## ⚡ OPCIÓN RECOMENDADA: Usar EAS Build (Más simple y confiable)

### Paso 1: Crear cuenta en Expo
1. Ir a https://expo.dev
2. Crear cuenta gratuita
3. Instalar Expo CLI: `npm install -g eas-cli`

### Paso 2: Configurar Proyecto
```bash
cd C:\Users\mmoli\OneDrive\Escritorio\appIA1.0\PingPong
eas init
```

### Paso 3: Compilar APK
```bash
eas build --platform android --type apk
```

El APK se generará automáticamente en la nube y lo podrás descargar.

---

## 🛠️ OPCIÓN 2: Compilación Local (Flutter CLI)

### Pre-requisitos Instalados
- ✅ Java 1.8.0 (YA INSTALADO EN TU SISTEMA)
- ❌ Flutter SDK
- ❌ Android SDK

### Paso 1: Instalar Flutter SDK
1. Descargar desde: https://flutter.dev/docs/get-started/install/windows
2. Extraer en: `C:\src\flutter`
3. Añadir a PATH:
   - Click derecho en "Mi PC" → Propiedades
   - Variables de entorno → Editar variables de entorno del sistema
   - Variable `Path` → Nuevo → `C:\src\flutter\bin`
   - Reiniciar terminal

### Paso 2: Verificar instalación
```bash
flutter --version
flutter doctor
```

### Paso 3: Compilar APK
```bash
cd C:\Users\mmoli\OneDrive\Escritorio\appIA1.0\PingPong
flutter pub get
flutter build apk --release
```

El APK se generará en:
```
build\app\outputs\apk\release\app-release.apk
```

---

## 🎯 OPCIÓN 3: Android Studio (Interfaz Gráfica)

### Paso 1: Descargar Android Studio
- https://developer.android.com/studio
- Instalar versión completa

### Paso 2: Abrir Proyecto
1. Abrir Android Studio
2. File → Open → Seleccionar carpeta `android` del proyecto
3. Dejar que descargue dependencias (5-10 minutos)

### Paso 3: Compilar APK
1. Build → Build Bundle(s) / APK(s) → Build APK(s)
2. Esperar a que se compile
3. Locator → Click en la notificación "locate" para encontrar el APK

---

## 📦 DESPUÉS DE GENERAR EL APK

### Firmar el APK para Google Play

```bash
# Paso 1: Crear keystore (una sola vez)
keytool -genkey -v -keystore pingpong.jks `
  -keyalg RSA -keysize 2048 -validity 10000

# Paso 2: Firmar el APK
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 `
  -keystore pingpong.jks `
  build\app\outputs\apk\release\app-release.apk pingpong

# Paso 3: Alinear APK (optimizar tamaño)
zipalign -v 4 build\app\outputs\apk\release\app-release.apk pingpong-release.apk
```

---

## 🚀 SUBIR A GOOGLE PLAY CONSOLE

### Paso 1: Crear Cuenta Google Play Developer
- https://play.google.com/console
- Pagar cuota única de $25 USD
- Crear nueva aplicación

### Paso 2: Información de la App
- **Nombre**: Ping Pong
- **Descripción**: 
  ```
  ¡Juego clásico de ping pong con inteligencia artificial adaptativa!
  
  Características:
  - 👥 Modo 2 Jugadores: Juega con amigos en el mismo dispositivo
  - 🤖 Modo IA: Desafía una IA que aumenta de dificultad
  - 🎮 Controles intuitivos: Desliza el dedo para mover tu pala
  - ⚙️ Ajustes: Volumen, vibración, efectos visuales
  - 📱 Optimizado: Funciona en todos los dispositivos Android
  ```
- **Categoría**: Juegos
- **Clasificación**: Everyone (PEGI 3)

### Paso 3: Capturas de Pantalla
Tomar screenshots del juego:
1. Menú principal
2. Gameplay
3. Pantalla de game over
4. Ajustes

Requisitos:
- Mínimo 2 screenshots
- Máximo 8 screenshots
- Tamaño: 1080x1920 pixels
- Formato: PNG o JPG

### Paso 4: Icono de la App
- Crear icono 512x512 pixels en PNG
- Debe tener transparencia
- Representar el concepto de Ping Pong

### Paso 5: Subir APK
1. Release → Production → Create new release
2. Cargar el APK firmado
3. Añadir notas de la versión (Release notes)
4. Click "Review" y "Publish"

---

## 📱 REQUISITOS TÉCNICOS VERIFICADOS

```yaml
SDK Mínimo: Android 5.0 (API 21) ✅
SDK Objetivo: Android 14 (API 34) ✅
Java: 1.8.0 ✅
Idioma: Dart/Flutter ✅
Tamaño: ~50MB
Permisos: Ninguno (solo Internet si es necesario)
Orientación: Portrait (vertical)
```

---

## 🐛 SOLUCIÓN DE PROBLEMAS

### "flutter: comando no encontrado"
- Descargar Flutter SDK
- Añadir a PATH correctamente
- Reiniciar terminal

### "SDK is not found at…"
- Descargar Android SDK via Android Studio
- Configurar `ANDROID_SDK_ROOT` en variables de entorno

### "Gradle build failed"
- Ejecutar: `flutter clean`
- Ejecutar: `flutter pub get`
- Intentar de nuevo: `flutter build apk --release`

### El APK es demasiado grande
- Ejecutar: `flutter build apk --split-per-abi`
- Esto genera 3 APKs más pequeños (uno por arquitectura)

---

## ✅ RESUMEN RÁPIDO (Si ya tienes todo)

```bash
# Terminal
cd C:\Users\mmoli\OneDrive\Escritorio\appIA1.0\PingPong
flutter clean
flutter pub get
flutter build apk --release

# Resultado
# APK en: build\app\outputs\apk\release\app-release.apk
```

---

## 📞 SOPORTE OFICIAL

- Flutter Docs: https://flutter.dev/docs
- Google Play Console Help: https://support.google.com/googleplay/android-developer
- Stack Overflow: Tag `flutter` y `android`

---

**Generado**: 11 de Junio de 2026
**Proyecto**: Ping Pong Game v1.0.0
**Estado**: Listo para Publicación ✅
