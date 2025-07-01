class GameState {
  static final GameState _instance = GameState._internal();
  
  // Factory constructor implementing the singleton pattern
  factory GameState() {
    return _instance;
  }
  
  GameState._internal();
  
  int score = 0;
  int correctItems = 0;
  int incorrectItems = 0;
  String playerInitials = '';
  
  void resetGame() {
    score = 0;
    correctItems = 0;
    incorrectItems = 0;
  }
  
  void incrementScore(int points) {
    score += points;
    correctItems++;
  }
  
  void decrementScore(int points) {
    score = (score - points).clamp(0, double.infinity).toInt();
    incorrectItems++;
  }
  
  void setPlayerInitials(String initials) {
    playerInitials = initials;
  }
}
