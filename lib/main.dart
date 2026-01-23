import 'package:flutter/material.dart';

import 'ui/game_screen.dart';

void main() => runApp(const StrategyGameApp());


class StrategyGameApp extends StatelessWidget {
  const StrategyGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jeu de Stratégie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const GameScreen(),
    );
  }
}
