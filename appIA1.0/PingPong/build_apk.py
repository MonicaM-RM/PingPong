#!/usr/bin/env python3
"""
Script para compilar APK del proyecto Ping Pong Flutter
Este script automatiza el proceso de compilación a APK para Google Play Store
"""

import os
import sys
import subprocess
import json
from datetime import datetime
from pathlib import Path

class APKBuilder:
    def __init__(self, project_root):
        self.project_root = Path(project_root)
        self.android_dir = self.project_root / "android"
        self.app_dir = self.android_dir / "app"
        self.build_dir = self.app_dir / "build"
        self.output_dir = self.project_root / "build_output"
        
    def setup_environment(self):
        """Configurar variables de entorno necesarias"""
        print("[*] Configurando ambiente...")
        
        # Crear directorio de salida
        self.output_dir.mkdir(exist_ok=True)
        
        # Verificar si JAVA_HOME está configurado
        if not os.environ.get('JAVA_HOME'):
            java_paths = [
                r"C:\Program Files\Java\jdk1.8.0_381",
                r"C:\Program Files\Java\jdk8",
                r"C:\Program Files (x86)\Java\jdk8",
            ]
            for path in java_paths:
                if os.path.exists(path):
                    os.environ['JAVA_HOME'] = path
                    print(f"[✓] JAVA_HOME configurado: {path}")
                    break
        
        return True
    
    def run_command(self, cmd, cwd=None, shell=False):
        """Ejecutar comando en terminal"""
        try:
            if cwd is None:
                cwd = self.android_dir
            
            print(f"[>] Ejecutando: {' '.join(cmd) if isinstance(cmd, list) else cmd}")
            result = subprocess.run(
                cmd,
                cwd=cwd,
                shell=shell,
                capture_output=True,
                text=True,
                timeout=600
            )
            
            if result.stdout:
                print(result.stdout)
            if result.stderr:
                print(result.stderr, file=sys.stderr)
                
            return result.returncode == 0
        except Exception as e:
            print(f"[!] Error ejecutando comando: {e}")
            return False
    
    def verify_flutter_structure(self):
        """Verificar que la estructura Flutter sea válida"""
        print("[*] Verificando estructura del proyecto...")
        
        required_files = [
            self.project_root / "pubspec.yaml",
            self.android_dir / "build.gradle",
            self.app_dir / "build.gradle",
            self.app_dir / "src" / "main" / "AndroidManifest.xml",
        ]
        
        for file in required_files:
            if not file.exists():
                print(f"[!] Archivo requerido no encontrado: {file}")
                return False
            print(f"[✓] Encontrado: {file.name}")
        
        return True
    
    def build_apk_release(self):
        """Compilar APK en modo release"""
        print("[*] Compilando APK en modo RELEASE...")
        
        # Usar gradlew si existe, sino usar gradle
        if sys.platform == 'win32':
            gradlew = self.android_dir / "gradlew.bat"
            gradle_cmd = ["gradlew.bat" if gradlew.exists() else "gradle"]
        else:
            gradlew = self.android_dir / "gradlew"
            gradle_cmd = ["./gradlew" if gradlew.exists() else "gradle"]
        
        # Comando de compilación
        build_cmd = gradle_cmd + ["assembleRelease", "--stacktrace"]
        
        # Ejecutar compilación
        success = self.run_command(build_cmd)
        
        if not success:
            print("[!] Error durante la compilación")
            return False
        
        print("[✓] Compilación completada")
        return True
    
    def find_apk_output(self):
        """Encontrar el APK generado"""
        print("[*] Buscando archivo APK generado...")
        
        apk_patterns = [
            self.build_dir / "outputs" / "apk" / "release" / "*.apk",
            self.build_dir / "outputs" / "bundle" / "release" / "*.aab",
        ]
        
        import glob
        for pattern in apk_patterns:
            matches = glob.glob(str(pattern))
            if matches:
                return matches[0]
        
        print("[!] No se encontró archivo APK")
        return None
    
    def sign_apk(self, apk_path):
        """Firmar el APK para Google Play Store"""
        print("[*] Firmando APK...")
        
        # Crear archivo de propiedades de firma si no existe
        keystore_path = self.project_root / "pingpong.jks"
        key_password = "PingPong@123"
        
        if not keystore_path.exists():
            print("[!] Keystore no encontrado")
            print(f"[*] Para firmar el APK, crea un keystore:")
            print(f"    keytool -genkey -v -keystore {keystore_path} -keyalg RSA -keysize 2048 -validity 10000")
            return False
        
        # Firmar con jarsigner
        jarsigner_cmd = [
            "jarsigner",
            "-verbose",
            "-sigalg", "SHA1withRSA",
            "-digestalg", "SHA1",
            "-keystore", str(keystore_path),
            "-storepass", key_password,
            "-keypass", key_password,
            str(apk_path),
            "pingpong"
        ]
        
        return self.run_command(jarsigner_cmd)
    
    def align_apk(self, apk_path):
        """Alinear APK para optimizar"""
        print("[*] Alineando APK...")
        
        aligned_path = self.output_dir / "pingpong-release-aligned.apk"
        
        zipalign_cmd = [
            "zipalign",
            "-v", "4",
            str(apk_path),
            str(aligned_path)
        ]
        
        return self.run_command(zipalign_cmd)
    
    def build(self):
        """Ejecutar proceso completo de compilación"""
        print("=" * 60)
        print("COMPILADOR APK - PING PONG PARA GOOGLE PLAY STORE")
        print(f"Proyecto: {self.project_root}")
        print(f"Fecha: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        print("=" * 60)
        
        # Paso 1: Configurar ambiente
        if not self.setup_environment():
            print("[!] Fallo al configurar ambiente")
            return False
        
        # Paso 2: Verificar estructura
        if not self.verify_flutter_structure():
            print("[!] Estructura del proyecto inválida")
            return False
        
        # Paso 3: Compilar APK
        if not self.build_apk_release():
            print("[!] Fallo al compilar APK")
            return False
        
        # Paso 4: Encontrar APK
        apk_path = self.find_apk_output()
        if not apk_path:
            print("[!] No se pudo localizar el APK generado")
            return False
        
        print(f"[✓] APK encontrado: {apk_path}")
        
        # Paso 5: Copiar a output
        import shutil
        output_apk = self.output_dir / "pingpong-release.apk"
        shutil.copy2(apk_path, output_apk)
        print(f"[✓] APK copiado a: {output_apk}")
        
        print("\n" + "=" * 60)
        print("✓ COMPILACIÓN COMPLETADA EXITOSAMENTE")
        print("=" * 60)
        print(f"\nArchivo APK generado:")
        print(f"  {output_apk}")
        print(f"\nPasos siguientes:")
        print(f"  1. Firmar el APK con tu clave privada")
        print(f"  2. Alinear el APK con zipalign")
        print(f"  3. Subir a Google Play Console")
        print(f"\nGuía: https://developer.android.com/studio/publish/app-signing")
        
        return True

if __name__ == "__main__":
    project_path = r"C:\Users\mmoli\OneDrive\Escritorio\appIA1.0\PingPong"
    
    builder = APKBuilder(project_path)
    success = builder.build()
    
    sys.exit(0 if success else 1)
