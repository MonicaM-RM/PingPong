@echo off
REM ===================================================================
REM Script de Compilación APK - Ping Pong para Google Play Store
REM ===================================================================
REM Este script automático compila el proyecto Flutter a APK
REM Requisitos: Flutter SDK, Java JDK, Android SDK
REM ===================================================================

setlocal enabledelayedexpansion

echo.
echo ===================================================================
echo  COMPILADOR APK - PING PONG
echo ===================================================================
echo.

REM Detectar directorio del proyecto
set PROJECT_DIR=%~dp0
cd /d "%PROJECT_DIR%"

echo [*] Verificando ambiente...
echo     Directorio del proyecto: %PROJECT_DIR%

REM Verificar Java
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Java no encontrado. Instala Java JDK 8 o superior.
    exit /b 1
)
echo [✓] Java detectado

REM Verificar Flutter
where flutter >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Flutter no encontrado en PATH.
    echo     Descarga Flutter desde: https://flutter.dev/docs/get-started/install/windows
    echo     Añade C:\src\flutter\bin a tu variable PATH
    exit /b 1
)
echo [✓] Flutter detectado

REM Mostrar versión de Flutter
flutter --version
echo.

REM Limpiar builds anteriores
echo [*] Limpiando builds anteriores...
call flutter clean
if %errorlevel% neq 0 (
    echo [!] Error al limpiar. Intenta manualmente con: flutter clean
    exit /b 1
)
echo [✓] Limpieza completada

REM Obtener dependencias
echo.
echo [*] Descargando dependencias...
call flutter pub get
if %errorlevel% neq 0 (
    echo [!] Error descargando dependencias.
    exit /b 1
)
echo [✓] Dependencias descargadas

REM Compilar APK en modo RELEASE
echo.
echo [*] Compilando APK en modo RELEASE...
echo     Esto puede tardar 5-15 minutos...
echo.
call flutter build apk --release

if %errorlevel% neq 0 (
    echo.
    echo [!] ERROR durante la compilación
    echo     Intenta:
    echo       1. flutter clean
    echo       2. flutter pub get
    echo       3. flutter build apk --release
    exit /b 1
)

echo.
echo ===================================================================
echo [✓] COMPILACIÓN COMPLETADA EXITOSAMENTE
echo ===================================================================
echo.

set APK_PATH=build\app\outputs\apk\release\app-release.apk

if exist "%APK_PATH%" (
    for %%A in ("%APK_PATH%") do set APK_SIZE=%%~zA
    echo [✓] APK generado correctamente
    echo     Ruta: %APK_PATH%
    echo     Tamaño: !APK_SIZE! bytes
    echo.
    echo Pasos siguientes:
    echo   1. Firmar el APK con tu clave privada
    echo   2. Subirlo a Google Play Console
    echo.
    echo Documentación: Consulta COMPILE_APK_GUIDE.md
) else (
    echo [!] APK no encontrado en la ruta esperada
    echo     Ruta esperada: %APK_PATH%
    exit /b 1
)

echo.
echo Script completado.
pause
