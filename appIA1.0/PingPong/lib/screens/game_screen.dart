import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../models/game_state.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameState gameState;
  late Timer gameTimer;
  double playerDragDelta = 0;

  @override
  void initState() {
    super.initState();
    gameState = GameState();
    startGame();
  }

  void startGame() {
    gameTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        gameState.update();
      });

      if (gameState.gameOver) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    gameTimer.cancel();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    playerDragDelta = details.delta.dy;
    gameState.movePlayerPaddle(playerDragDelta);
  }

  void _restartGame() {
    gameTimer.cancel();
    setState(() {
      gameState = GameState();
    });
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: _handleDragUpdate,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0f3460),
                Color(0xFF1a1a2e),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Game field
              CustomPaint(
                painter: GameFieldPainter(gameState),
                size: Size.infinite,
              ),
              
              // Score display
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'TÚ',
                          style: TextStyle(
                            color: Colors.cyan,
                            fontSize: 16,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${gameState.playerScore}',
                          style: const TextStyle(
                            color: Colors.cyan,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'IA',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${gameState.aiScore}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Game over overlay
              if (gameState.gameOver)
                GestureDetector(
                  onTap: _restartGame,
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            gameState.playerScore > gameState.aiScore
                                ? '¡GANASTE!'
                                : '¡GAME OVER!',
                            style: TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.bold,
                              color: gameState.playerScore > gameState.aiScore
                                  ? Colors.cyan
                                  : Colors.red,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Final: ${gameState.playerScore} - ${gameState.aiScore}',
                            style: const TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Text(
                            'Toca para jugar de nuevo',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // Back button
              Positioned(
                top: 20,
                left: 20,
                child: SafeArea(
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.grey[800],
                    onPressed: () {
                      gameTimer.cancel();
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameFieldPainter extends CustomPainter {
  final GameState gameState;

  GameFieldPainter(this.gameState);

  @override
  void paint(Canvas canvas, Size size) {
    // Fondo con línea central
    final centerLine = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      centerLine,
    );

    // Paleta del jugador (izquierda)
    final playerPaddlePaint = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          gameState.playerPaddleX,
          gameState.playerPaddleY,
          gameState.paddleWidth,
          gameState.paddleHeight,
        ),
        const Radius.circular(10),
      ),
      playerPaddlePaint,
    );

    // Sombra paleta jugador
    final playerShadow = Paint()
      ..color = Colors.cyan.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          gameState.playerPaddleX - 2,
          gameState.playerPaddleY - 2,
          gameState.paddleWidth + 4,
          gameState.paddleHeight + 4,
        ),
        const Radius.circular(10),
      ),
      playerShadow,
    );

    // Paleta de IA (derecha)
    final aiPaddlePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          gameState.aiPaddleX,
          gameState.aiPaddleY,
          gameState.paddleWidth,
          gameState.paddleHeight,
        ),
        const Radius.circular(10),
      ),
      aiPaddlePaint,
    );

    // Sombra paleta IA
    final aiShadow = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          gameState.aiPaddleX - 2,
          gameState.aiPaddleY - 2,
          gameState.paddleWidth + 4,
          gameState.paddleHeight + 4,
        ),
        const Radius.circular(10),
      ),
      aiShadow,
    );

    // Pelota
    final ballPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(gameState.ballX, gameState.ballY),
      gameState.ballRadius,
      ballPaint,
    );

    // Sombra pelota
    final ballShadow = Paint()
      ..color = Colors.yellow.withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    canvas.drawCircle(
      Offset(gameState.ballX, gameState.ballY),
      gameState.ballRadius + 2,
      ballShadow,
    );
  }

  @override
  bool shouldRepaint(GameFieldPainter oldDelegate) => true;
}
