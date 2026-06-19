PLAY_STORE_INFO = {
    'app_name': 'Ping Pong',
    'package_name': 'com.pingpong.game',
    'version_code': '1',
    'version_name': '1.0.0',
    'min_sdk': 21,
    'target_sdk': 34,
    'compile_sdk': 34,
    'description': 'Un juego clásico de Ping Pong para dispositivos Android con IA adaptativa',
    'short_description': 'Juego de Ping Pong retro con desafío de IA',
    'category': 'GAME_ARCADE',
    'content_rating': 'UNRATED',
    'supported_languages': ['es', 'en'],
}

BUILD_COMMANDS = {
    'clean': 'flutter clean',
    'get_dependencies': 'flutter pub get',
    'analyze': 'flutter analyze',
    'test': 'flutter test',
    'run_debug': 'flutter run',
    'build_apk': 'flutter build apk --release',
    'build_appbundle': 'flutter build appbundle --release',
}

KEYSTORE_INFO = {
    'keytool_command': 'keytool -genkey -v -keystore upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload',
    'properties_file': 'android/key.properties',
    'properties_content': '''storePassword=YOUR_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=upload
storeFile=PATH_TO_upload-keystore.jks'''
}

STORE_LISTING = {
    'title': 'Ping Pong',
    'subtitle': 'Juego de reflejos clásico',
    'full_description': '''¡Bienvenido a Ping Pong, el juego clásico de reflejos!

Características:
• Juega contra una IA adaptativa y desafiante
• Dificultad progresiva que aumenta con tu nivel
• Interfaz moderna y atractiva
• Controles simples e intuitivos
• Perfecto para jugar en cualquier momento

Cómo jugar:
1. Desliza tu dedo verticalmente para controlar tu paleta
2. Evita que la pelota pase tu lado
3. Intenta que la IA falle
4. Sé el primero en alcanzar 11 puntos

Mecánicas de juego:
• Efecto de spin en la pelota según dónde la golpees
• Velocidad de pelota aumenta progresivamente
• IA que se adapta a tu nivel de juego
• Sistema de puntuación justo y equilibrado

¡Descarga ahora y demuestra tus habilidades de reflejos!''',
    'promotional_text': 'El juego de Ping Pong más adictivo para tu móvil',
    'rating': 4.5,
    'target_audience': 'Todos',
}

TESTING_CHECKLIST = [
    '✓ Juego inicia sin errores',
    '✓ Controles de paleta funcionan correctamente',
    '✓ IA responde adecuadamente',
    '✓ Detección de colisión funciona',
    '✓ Sistema de puntuación correcto',
    '✓ Dificultad progresiva activa',
    '✓ Pantalla de game over muestra resultados',
    '✓ Pantalla de inicio tiene botón play',
    '✓ No hay crashes durante el juego',
    '✓ Rendimiento estable (60 FPS)',
]

OPTIMIZATION_SETTINGS = {
    'minify': True,
    'shrink_resources': True,
    'proguard': True,
    'enable_r8': True,
    'optimization_level': 'full',
}
