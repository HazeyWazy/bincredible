import 'package:flutter/material.dart';
import '../models/game_state.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  final GameState _gameState = GameState();
  final TextEditingController _initialsController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _scoreAnimation;
  
  final List<String> _sustainabilityFacts = [
    'Recycling one aluminum can saves enough energy to run a TV for three hours.',
    'The average person generates over 4 pounds of trash every day.',
    'About 80% of what we throw away is actually recyclable.',
    'E-waste represents 2% of trash in landfills, but 70% of overall toxic waste.',
    'Composting can reduce the amount of waste sent to landfills by up to 30%.',
    'Plastic bags can take up to 1,000 years to decompose in landfills.',
    'Glass bottles can take up to 4,000 years to decompose if not recycled.',
    'Recycling paper uses 60% less energy than making paper from new materials.',
  ];
  
  String get _randomFact {
    return _sustainabilityFacts[DateTime.now().millisecond % _sustainabilityFacts.length];
  }
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    
    _scoreAnimation = Tween<double>(begin: 0, end: _gameState.score.toDouble())
        .animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    _initialsController.dispose();
    super.dispose();
  }
  
  void _submitScore() {
    if (_initialsController.text.isNotEmpty) {
      _gameState.setPlayerInitials(_initialsController.text.toUpperCase());
      Navigator.pushReplacementNamed(context, '/leaderboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your initials'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
              theme.colorScheme.primary.withOpacity(0.7),
              theme.colorScheme.primary,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Game over text
                    Text(
                      'GAME OVER',
                      style: theme.textTheme.displayMedium?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 40),
                    
                    // Score card
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const Text(
                              'YOUR SCORE',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            AnimatedBuilder(
                              animation: _scoreAnimation,
                              builder: (context, child) {
                                return Text(
                                  _scoreAnimation.value.toInt().toString(),
                                  style: const TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF50C878),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildStatItem(
                                  'Correct',
                                  _gameState.correctItems.toString(),
                                  Icons.check_circle,
                                  Colors.green,
                                ),
                                _buildStatItem(
                                  'Incorrect',
                                  _gameState.incorrectItems.toString(),
                                  Icons.cancel,
                                  Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Fun fact
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.lightbulb, color: Colors.amber),
                              SizedBox(width: 8),
                              Text(
                                'DID YOU KNOW?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _randomFact,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Enter initials
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'ENTER YOUR INITIALS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _initialsController,
                            textCapitalization: TextCapitalization.characters,
                            maxLength: 3,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: 'AAA',
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _submitScore,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'SUBMIT SCORE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Play again button
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/game');
                      },
                      icon: const Icon(Icons.replay, color: Colors.white),
                      label: const Text(
                        'PLAY AGAIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      icon: const Icon(Icons.home, color: Colors.white),
                      label: const Text(
                        'HOME',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
