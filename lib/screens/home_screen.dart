import 'package:flutter/material.dart';
import 'package:bincredible/models/game_state.dart';
import 'package:bincredible/widgets/animated_bin.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gameState = GameState();
    
    // Reset game state when returning to home screen
    gameState.resetGame();
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.7),
              theme.colorScheme.primary,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo and title
                const SizedBox(height: 40),
                Icon(
                  Icons.recycling,
                  size: 80,
                  color: theme.colorScheme.onPrimary,
                ),
                const SizedBox(height: 20),
                Text(
                  'BINCREDIBLE',
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Recycling's never been this Bincredible.",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                
                // Animated bins
                const SizedBox(height: 60),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBin(
                      binType: 'Recycling',
                      color: Colors.blue,
                      icon: Icons.recycling,
                      delay: 0,
                    ),
                    AnimatedBin(
                      binType: 'Compost',
                      color: Colors.green,
                      icon: Icons.eco,
                      delay: 0.2,
                    ),
                    AnimatedBin(
                      binType: 'Landfill',
                      color: Colors.grey,
                      icon: Icons.delete,
                      delay: 0.4,
                    ),
                    AnimatedBin(
                      binType: 'E-Waste',
                      color: Colors.orange,
                      icon: Icons.devices,
                      delay: 0.6,
                    ),
                  ],
                ),
                
                // Buttons
                const SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/game');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: theme.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'START GAME',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    _showHowToPlay(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'HOW TO PLAY',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/leaderboard');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'LEADERBOARD',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void _showHowToPlay(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('How to Play'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInstructionStep('1', 'Waste items will appear at the top of the screen.'),
                const SizedBox(height: 10),
                _buildInstructionStep('2', 'Drag each item to the correct bin: Recycling, Compost, Landfill, or E-Waste.'),
                const SizedBox(height: 10),
                _buildInstructionStep('3', 'You have 60 seconds to sort as many items as possible.'),
                const SizedBox(height: 10),
                _buildInstructionStep('4', 'Correct sorting earns points, incorrect sorting loses points.'),
                const SizedBox(height: 10),
                _buildInstructionStep('5', 'Try to get the highest score and top the leaderboard!'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('GOT IT!'),
            ),
          ],
        );
      },
    );
  }
  
  Widget _buildInstructionStep(String number, String instruction) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 80, 200, 120),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(instruction),
        ),
      ],
    );
  }
}
