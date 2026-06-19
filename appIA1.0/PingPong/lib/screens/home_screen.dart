import 'package:flutter/material.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1a1a2e),
              const Color(0xFF16213e),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // Título principal
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.blue[300]!, Colors.cyan],
                ).createShader(bounds),
                child: const Text(
                  'PING PONG',
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Juego clásico de reflejos',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[400],
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 80),
              
              // Botón Play
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[400]!, Colors.blue[700]!],
                  ),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GameScreen(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 20,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.play_arrow, size: 32, color: Colors.white),
                          SizedBox(width: 12),
                          Text(
                            'JUGAR',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Botón Instrucciones
              OutlinedButton(
                onPressed: () {
                  _showInstructions(context);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.cyan,
                  side: const BorderSide(color: Colors.cyan, width: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'INSTRUCCIONES',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              
              const Spacer(),
              
              // Versión
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  'v1.0.0',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInstructions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF16213e),
        title: const Text(
          'CÓMO JUGAR',
          style: TextStyle(color: Colors.cyan, letterSpacing: 2),
        ),
        content: const SingleChildScrollView(
          child: Text(
            '• Mueve tu paleta hacia arriba y hacia abajo\n\n'
            '• Evita que la pelota pase por tu lado\n\n'
            '• Intenta que la IA cometa errores\n\n'
            '• Primera en llegar a 11 puntos gana\n\n'
            '• La dificultad aumenta con tu puntuación\n\n'
            'Controles: Toca cualquier punto de la pantalla y desliza verticalmente',
            style: TextStyle(color: Colors.white70),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ENTENDIDO', style: TextStyle(color: Colors.cyan)),
          ),
        ],
      ),
    );
  }
}
