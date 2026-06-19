# Ping Pong Game

Un juego clásico de Ping Pong desarrollado en Flutter para dispositivos móviles Android e iOS, optimizado para publicación en Play Store.

## Características

- **Juego dinámico**: Juega contra una IA adaptativa
- **Dificultad progresiva**: La IA se vuelve más rápida conforme avanzas
- **Estética moderna**: Interfaz limpia y atractiva con gradientes y sombras
- **Controles intuitivos**: Desliza verticalmente para mover tu paleta
- **Puntuación**: Primera en llegar a 11 puntos gana

## Requisitos de Instalación

- Flutter SDK 3.0 o superior
- Android SDK (API 21 mínimo)
- Xcode (para iOS, opcional)
- Android Studio o Visual Studio Code

## Instalación y Ejecución

1. **Clonar o descargar el proyecto**
   ```bash
   cd PingPong
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Ejecutar en desarrollo**
   ```bash
   flutter run
   ```

4. **Compilar para Android (Release)**
   ```bash
   flutter build apk --release
   ```

5. **Compilar para Play Store (App Bundle)**
   ```bash
   flutter build appbundle --release
   ```

## Empaquetado para Play Store

### Requisitos previos:
- Certificado de firma digital
- Cuenta de Google Play Console
- Activos de aplicación (iconos, capturas de pantalla)

### Pasos para publicar:

1. **Generar firma de aplicación**
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

2. **Crear archivo de propiedades**
   - Crear `android/key.properties` con tus datos de firma

3. **Compilar App Bundle**
   ```bash
   flutter build appbundle --release
   ```

4. **Subir a Google Play Console**
   - Ir a Google Play Console
   - Crear nueva aplicación
   - Subir el AAB (Android App Bundle)
   - Completar datos de aplicación, privacidad, etc.
   - Enviar para revisión

## Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada
├── screens/
│   ├── home_screen.dart     # Pantalla principal
│   └── game_screen.dart     # Pantalla de juego
└── models/
    └── game_state.dart      # Lógica del juego

android/
├── app/
│   ├── AndroidManifest.xml
│   ├── build.gradle
│   └── proguard-rules.pro
└── ...

pubspec.yaml                 # Dependencias y configuración
```

## Dependencias

- **flutter**: Framework base
- **provider**: Gestión de estado

## Configuración de la Aplicación

### Iconos y Splash
Para cambiar el icono de la app, reemplaza los archivos en:
- `android/app/src/main/res/mipmap-*/ic_launcher.png`

### Nombre de la Aplicación
Edita en `android/app/AndroidManifest.xml`:
```xml
<application android:label="Tu Nombre de App" ...>
```

## Gameplay

### Controles
- **Deslizar hacia arriba/abajo**: Mueve tu paleta
- **Evitar la pelota**: No dejes que la pelota pase tu paleta

### Objetivos
- Primera en llegar a 11 puntos gana
- Vencer al AI en múltiples rondas
- Aumentar la dificultad progresivamente

### Mecánicas
- La IA se adapta a tu nivel
- La velocidad de la pelota aumenta cuando golpea
- El efecto de spin añade complejidad

## Solución de Problemas

### Error: "Flutter not found"
```bash
flutter doctor
# Asegúrate de tener Flutter en el PATH
```

### Error de compilación Android
```bash
flutter clean
flutter pub get
flutter run
```

### Problemas de firma
- Verifica que `key.properties` está configurado correctamente
- Asegúrate de tener Java 11+ instalado

## Optimizaciones para Play Store

- ✅ Minificación de código
- ✅ Optimización de recursos
- ✅ Configuración de permisos mínimos
- ✅ Sin actividades no usadas
- ✅ API levels conformes

## Privacidad y Permisos

El juego requiere permisos mínimos:
- Sin acceso a cámara
- Sin acceso a micrófono
- Sin acceso a ubicación
- Sin almacenamiento de datos personales

## Licencia

Este proyecto está disponible bajo licencia MIT.

## Autor

Desarrollado con Flutter y optimizado para Play Store.

## Contacto y Soporte

Para reportar bugs o sugerencias, por favor contacta al desarrollador.

---

¡Diviértete jugando Ping Pong!
