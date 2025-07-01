import 'package:flutter/material.dart';
import 'package:bincredible/screens/home_screen.dart';
import 'package:bincredible/screens/game_screen.dart';
import 'package:bincredible/screens/result_screen.dart';
import 'package:bincredible/screens/leaderboard_screen.dart';

void main() {
  runApp(const BincredibleApp());
}

class BincredibleApp extends StatelessWidget {
  const BincredibleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bincredible',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 80, 200, 120), // Emerald Green
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/game': (context) => const GameScreen(),
        '/result': (context) => const ResultScreen(),
        '/leaderboard': (context) => const LeaderboardScreen(),
      },
    );
  }
}
