import 'dart:math';

class NumberGuessingGame {
  int numberToGuess;
  int maxAttempts;
  int maxScore;
  int attempts = 0;
  int score;
  String difficulty;

  NumberGuessingGame(this.difficulty) {
    if (difficulty == 'easy') {
      numberToGuess = Random().nextInt(10) + 1;  // Range: 1-10
      maxAttempts = 1000;  // Effectively unlimited
      maxScore = 50;
    } else if (difficulty == 'medium') {
      numberToGuess = Random().nextInt(50) + 1;  // Range: 1-50
      maxAttempts = 10;
      maxScore = 100;
    } else if (difficulty == 'hard') {
      numberToGuess = Random().nextInt(100) + 1;  // Range: 1-100
      maxAttempts = 5;
      maxScore = 150;
    }
    score = maxScore;
  }

  String makeGuess(int userGuess) {
    attempts++;
    if (userGuess < numberToGuess) {
      score -= 5;
      return 'Too low! Try again.';
    } else if (userGuess > numberToGuess) {
      score -= 5;
      return 'Too high! Try again.';
    } else {
      return 'Congratulations! You guessed the correct number in $attempts attempts. Your final score is $score';
    }
  }

  bool isGameOver() {
    return attempts >= maxAttempts || score <= 0;
  }

  String provideHint() {
    if (attempts % 3 == 0) {
      if (numberToGuess % 2 == 0) {
        return 'Hint: The number is even.';
      } else {
        return 'Hint: The number is odd.';
      }
    }
    return '';
  }
}
