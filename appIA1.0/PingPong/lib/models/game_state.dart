import 'dart:math';

class GameState {
  // Screen dimensions
  static const double screenWidth = 400;
  static const double screenHeight = 800;

  // Paddle properties
  static const double paddleWidth = 15;
  static const double paddleHeight = 100;
  static const double paddleMargin = 20;

  // Ball properties
  static const double ballRadius = 8;
  double ballX = screenWidth / 2;
  double ballY = screenHeight / 2;
  double ballVelocityX = -5;
  double ballVelocityY = 3;
  static const double maxBallSpeed = 12;

  // Paddle positions
  double playerPaddleX = paddleMargin;
  double playerPaddleY = screenHeight / 2 - paddleHeight / 2;
  double aiPaddleX = screenWidth - paddleMargin - paddleWidth;
  double aiPaddleY = screenHeight / 2 - paddleHeight / 2;

  // Score
  int playerScore = 0;
  int aiScore = 0;
  bool gameOver = false;

  // AI difficulty
  late double aiSpeed;
  late int difficulty;

  GameState() {
    aiSpeed = 5;
    difficulty = 1;
  }

  void update() {
    if (gameOver) return;

    // Update ball position
    ballX += ballVelocityX;
    ballY += ballVelocityY;

    // Ball collision with top and bottom
    if (ballY - ballRadius < 0 || ballY + ballRadius > screenHeight) {
      ballVelocityY *= -1;
      ballY = ballY - ballRadius < 0
          ? ballRadius
          : screenHeight - ballRadius;
    }

    // Ball collision with paddles
    // Player paddle collision
    if (ballX - ballRadius < playerPaddleX + paddleWidth &&
        ballY > playerPaddleY &&
        ballY < playerPaddleY + paddleHeight &&
        ballVelocityX < 0) {
      ballVelocityX *= -1.02; // Slight speed increase
      ballX = playerPaddleX + paddleWidth + ballRadius;

      // Add spin based on where ball hits paddle
      double hitPos = (ballY - playerPaddleY) / paddleHeight;
      ballVelocityY += (hitPos - 0.5) * 8;
    }

    // AI paddle collision
    if (ballX + ballRadius > aiPaddleX &&
        ballY > aiPaddleY &&
        ballY < aiPaddleY + paddleHeight &&
        ballVelocityX > 0) {
      ballVelocityX *= -1.02;
      ballX = aiPaddleX - ballRadius;

      // Add spin based on where ball hits paddle
      double hitPos = (ballY - aiPaddleY) / paddleHeight;
      ballVelocityY += (hitPos - 0.5) * 8;
    }

    // Limit ball speed
    double speed = sqrt(ballVelocityX * ballVelocityX + ballVelocityY * ballVelocityY);
    if (speed > maxBallSpeed) {
      ballVelocityX = (ballVelocityX / speed) * maxBallSpeed;
      ballVelocityY = (ballVelocityY / speed) * maxBallSpeed;
    }

    // Scoring
    if (ballX < 0) {
      aiScore++;
      checkGameOver();
      resetBall();
    } else if (ballX > screenWidth) {
      playerScore++;
      increaseDifficulty();
      checkGameOver();
      resetBall();
    }

    // AI movement
    updateAI();
  }

  void resetBall() {
    ballX = screenWidth / 2;
    ballY = screenHeight / 2;
    
    Random random = Random();
    ballVelocityX = (random.nextBool() ? -1 : 1) * (3 + difficulty * 0.5);
    ballVelocityY = (random.nextDouble() - 0.5) * 6;
  }

  void updateAI() {
    // AI follows the ball with a slight delay (difficulty based)
    double targetY = ballY - paddleHeight / 2;
    double speedAdjustment = 1 + (difficulty * 0.2);

    if (aiPaddleY < targetY - 5) {
      aiPaddleY += aiSpeed * speedAdjustment;
    } else if (aiPaddleY > targetY + 5) {
      aiPaddleY -= aiSpeed * speedAdjustment;
    }

    // Keep paddle in bounds
    aiPaddleY = aiPaddleY.clamp(0, screenHeight - paddleHeight);
  }

  void movePlayerPaddle(double delta) {
    playerPaddleY += delta * 2;
    playerPaddleY = playerPaddleY.clamp(0, screenHeight - paddleHeight);
  }

  void increaseDifficulty() {
    if (playerScore % 3 == 0 && playerScore > 0) {
      difficulty++;
      aiSpeed += 0.5;
    }
  }

  void checkGameOver() {
    if (playerScore >= 11 || aiScore >= 11) {
      gameOver = true;
    }
  }
}
