import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../models/waste_item.dart';
import '../widgets/game_bin.dart';
import '../widgets/draggable_waste_item.dart';
import '../widgets/countdown_timer.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  final GameState _gameState = GameState();
  final List<WasteItem> _allWasteItems = WasteItemsRepository.getWasteItems();
  late WasteItem _currentItem;
  late Timer _gameTimer;
  int _timeRemaining = 60; // 60 seconds game time
  bool _gameActive = true;
  String _feedbackText = '';
  Color _feedbackColor = Colors.white;
  
  late AnimationController _feedbackAnimationController;
  late Animation<double> _feedbackAnimation;
  
  @override
  void initState() {
    super.initState();
    _gameState.resetGame();
    _currentItem = _getRandomWasteItem();
    _startGameTimer();
    
    _feedbackAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    _feedbackAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _feedbackAnimationController,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );
  }
  
  @override
  void dispose() {
    _gameTimer.cancel();
    _feedbackAnimationController.dispose();
    super.dispose();
  }
  
  void _startGameTimer() {
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          _endGame();
        }
      });
    });
  }
  
  void _endGame() {
    _gameTimer.cancel();
    setState(() {
      _gameActive = false;
    });
    
    // Navigate to results screen after a short delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/result');
      }
    });
  }
  
  WasteItem _getRandomWasteItem() {
    final random = Random();
    return _allWasteItems[random.nextInt(_allWasteItems.length)];
  }
  
  void _handleItemSorted(BinType binType) {
    if (!_gameActive) return;
    
    if (_currentItem.correctBin == binType) {
      // Correct bin
      _gameState.incrementScore(100);
      _showFeedback('Correct! +100', Colors.green);
    } else {
      // Incorrect bin
      _gameState.decrementScore(50);
      _showFeedback('Wrong bin! -50', Colors.red);
    }
    
    // Get next item
    setState(() {
      _currentItem = _getRandomWasteItem();
    });
  }
  
  void _showFeedback(String text, Color color) {
    setState(() {
      _feedbackText = text;
      _feedbackColor = color;
    });
    
    _feedbackAnimationController.reset();
    _feedbackAnimationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _feedbackAnimationController.reverse();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              theme.colorScheme.primary.withValues(alpha: 0.2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Game header with timer and score
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Timer
                    CountdownTimer(timeRemaining: _timeRemaining),
                    
                    // Score
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Score: ${_gameState.score}',
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Feedback animation
              SizedBox(
                height: 40,
                child: FadeTransition(
                  opacity: _feedbackAnimation,
                  child: Text(
                    _feedbackText,
                    style: TextStyle(
                      color: _feedbackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              
              // Current waste item
              Expanded(
                child: Center(
                  child: _gameActive
                      ? DraggableWasteItem(
                          wasteItem: _currentItem,
                          onDragEnd: (details) {
                            // Handle drag end if needed
                          },
                        )
                      : const Text(
                          'Game Over!',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                ),
              ),
              
              // Bins at the bottom
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GameBin(
                      binType: BinType.recycling,
                      label: 'Recycling',
                      color: Colors.blue,
                      icon: Icons.recycling,
                      onAccept: _handleItemSorted,
                    ),
                    GameBin(
                      binType: BinType.compost,
                      label: 'Compost',
                      color: Colors.green,
                      icon: Icons.eco,
                      onAccept: _handleItemSorted,
                    ),
                    GameBin(
                      binType: BinType.landfill,
                      label: 'Landfill',
                      color: Colors.grey,
                      icon: Icons.delete,
                      onAccept: _handleItemSorted,
                    ),
                    GameBin(
                      binType: BinType.eWaste,
                      label: 'E-Waste',
                      color: Colors.orange,
                      icon: Icons.devices,
                      onAccept: _handleItemSorted,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
