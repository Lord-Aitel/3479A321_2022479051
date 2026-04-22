import 'package:flutter/material.dart';
import '/models/game_result.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<GameResult> history = [
      GameResult(date: '10 Abr', timeSpent: '01:20', isVictory: true),
      GameResult(date: '09 Abr', timeSpent: '04:45', isVictory: false),
      GameResult(date: '08 Abr', timeSpent: '02:10', isVictory: true),
      GameResult(date: '07 Abr', timeSpent: '03:00', isVictory: false),
      GameResult(date: '06 Abr', timeSpent: '05:15', isVictory: true),
      GameResult(date: '05 Abr', timeSpent: '02:50', isVictory: false),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Historial de Partidas")),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final game = history[index];
          return GameResultUI(game: game); // usa tu widget del modelo
        },
      ),
    );
  }
}
