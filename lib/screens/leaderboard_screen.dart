import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../models/leaderboard.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gameState = GameState();
    
    // Get dummy leaderboard entries and add current player if they have a score
    List<LeaderboardEntry> entries = LeaderboardRepository.getDummyEntries();
    
    if (gameState.score > 0 && gameState.playerInitials.isNotEmpty) {
      entries.add(
        LeaderboardEntry(
          playerInitials: gameState.playerInitials,
          score: gameState.score,
          date: DateTime.now(),
        ),
      );
    }
    
    // Sort entries by score (highest first)
    entries.sort((a, b) => b.score.compareTo(a.score));
    
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
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'LEADERBOARD',
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Top Recyclers',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onPrimary.withValues(
                          alpha: 0.9),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Trophy for top player
              if (entries.isNotEmpty)
                _buildTopPlayerTrophy(entries[0], theme),
              
              // Leaderboard entries
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      final isCurrentPlayer = entry.playerInitials == gameState.playerInitials && 
                                             entry.score == gameState.score;
                      
                      return _buildLeaderboardEntry(
                        context, 
                        entry, 
                        index + 1,
                        isCurrentPlayer,
                      );
                    },
                  ),
                ),
              ),
              
              // Back button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('BACK TO HOME'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: theme.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTopPlayerTrophy(LeaderboardEntry topEntry, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const Icon(
            Icons.emoji_events,
            color: Colors.amber,
            size: 60,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: theme.colorScheme.primary,
                  radius: 20,
                  child: Text(
                    topEntry.playerInitials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Top Recycler',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${topEntry.score} points',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLeaderboardEntry(
    BuildContext context, 
    LeaderboardEntry entry, 
    int position,
    bool isCurrentPlayer,
  ) {
    final theme = Theme.of(context);
    
    // Determine rank icon and color
    IconData rankIcon;
    Color rankColor;
    
    switch (position) {
      case 1:
        rankIcon = Icons.looks_one;
        rankColor = Colors.amber;
        break;
      case 2:
        rankIcon = Icons.looks_two;
        rankColor = Colors.grey.shade400;
        break;
      case 3:
        rankIcon = Icons.looks_3;
        rankColor = Colors.brown.shade300;
        break;
      default:
        rankIcon = Icons.emoji_events;
        rankColor = Colors.grey.shade700;
    }
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isCurrentPlayer ? theme.colorScheme.primary.withValues(alpha: 0.1) : null,
        borderRadius: BorderRadius.circular(12),
        border: isCurrentPlayer 
            ? Border.all(color: theme.colorScheme.primary, width: 2)
            : null,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: rankColor,
          child: Icon(
            rankIcon,
            color: Colors.white,
          ),
        ),
        title: Text(
          entry.playerInitials,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          _formatDate(entry.date),
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${entry.score}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} hr ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}
