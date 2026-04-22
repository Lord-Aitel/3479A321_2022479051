import 'package:flutter/material.dart';

class GameResult {
  final String date;
  final String timeSpent;
  final bool isVictory;

  GameResult({
    required this.date,
    required this.timeSpent,
    required this.isVictory,
  });
}

class GameResultUI extends StatelessWidget {
  final GameResult game;

  const GameResultUI({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Fecha: ${game.date}", style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Duración: ${game.timeSpent}"),
            Text(
              game.isVictory ? "Resultado: Victoria" : "Resultado: Derrota",
              style: TextStyle(color: game.isVictory ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}


