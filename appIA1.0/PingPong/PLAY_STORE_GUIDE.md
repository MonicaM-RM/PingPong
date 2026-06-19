# Información sobre compilación y publicación en Play Store

## Pasos para publicar el juego en Google Play Store

### 1. Preparación de la firma digital

Necesitas crear un keystore (certificado de firma):

```bash
# En Windows (desde Android Studio SDK tools o desde comando)
keytool -genkey -v -keystore %USERPROFILE%\upload-keystore.jks ^
  -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 ^
  -alias upload
```

Responde las preguntas cuando se te solicite.

### 2. Configurar Flutter para usar la firma

Crea el archivo `android/key.properties`:

```properties
storePassword=TU_CONTRASEÑA_KEYSTORE
keyPassword=TU_CONTRASEÑA_KEY
keyAlias=upload
storeFile=PATH_COMPLETO_AL_KEYSTORE.jks
```

### 3. Configurar la compilación (android/app/build.gradle)

Ya está incluido en el proyecto, pero verifica que tenga:

```gradle
android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
        }
    }
}
```

### 4. Compilar para Play Store

```bash
# Generar App Bundle (recomendado para Play Store)
flutter build appbundle --release

# O generar APK si prefieres
flutter build apk --release
```

El archivo se generará en:
- App Bundle: `build/app/outputs/bundle/release/app-release.aab`
- APK: `build/app/outputs/apk/release/app-release.apk`

### 5. Configurar cuenta de Google Play

1. Ve a https://play.google.com/console
2. Crea una cuenta de desarrollador ($25 USD, pago único)
3. Crea una nueva aplicación

### 6. Llenar la información de la aplicación

En Google Play Console:

**Información de la aplicación:**
- Título: Ping Pong
- Descripción: "Un juego clásico de Ping Pong para teléfonos inteligentes"
- Iconografía y capturas de pantalla

**Clasificación de contenido:**
- Edad: 3+ (sin restricciones)

**Categoría:** Games → Arcade

**Clasificación de contenido:** Selecciona las opciones apropiadas

### 7. Subir el archivo

1. Ve a "Lanzamiento" → "Producción"
2. Crea un lanzamiento
3. Sube el archivo `.aab`

### 8. Revisar y enviar

1. Revisa toda la información
2. Completa los cuestionarios de privacidad
3. Haz clic en "Enviar para revisión"

### 9. Esperar aprobación

Google normalmente revisa y aprueba apps en 1-3 horas.

---

## Versiones de actualización

Para actualizar:
1. Incrementa `versionCode` en `pubspec.yaml`
2. Actualiza `versionName` si es necesario
3. Compila nuevo App Bundle
4. Sube a Play Store

## Requisitos de Play Store

✓ App Bundle (.aab)
✓ Firmado digitalmente
✓ API mínimo 21 (ya configurado)
✓ Información completa de privacidad
✓ Clasificación de contenido
✓ Sin errores ni advertencias
