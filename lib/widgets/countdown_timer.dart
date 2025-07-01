import 'package:flutter/material.dart';

class CountdownTimer extends StatelessWidget {
  final int timeRemaining;

  const CountdownTimer({
    super.key,
    required this.timeRemaining,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLowTime = timeRemaining <= 10;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isLowTime ? Colors.red : theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.timer,
            color: theme.colorScheme.onPrimary,
          ),
          const SizedBox(width: 8),
          Text(
            '$timeRemaining',
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
