import 'package:flutter/material.dart';
import '/models/game_result.dart';



class HistoryScreen extends StatelessWidget {
const HistoryScreen({super.key});
@override
Widget build(BuildContext context) {
 final List<GameResult> history = [
  GameResult(date: "22/04/2026", timeSpent: "2m 30s", isVictory: true),
  GameResult(date: "21/04/2026", timeSpent: "1m 45s", isVictory: false),
 ];

    return Scaffold(
      appBar: AppBar(title: const Text("Historial de Partidas")),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final game = history[index];
          return ListTile(
            title: Text("Fecha: ${game.date}"),
            subtitle: Text("Duración: ${game.timeSpent}"),
            trailing: Icon(
              game.isVictory ? Icons.check_circle : Icons.cancel,
              color: game.isVictory ? Colors.green : Colors.red,
            ),
          );
        },
      ),
    );
  }
}
