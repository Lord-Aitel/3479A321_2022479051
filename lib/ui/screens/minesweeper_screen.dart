import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../widgets/mine_cell.dart';
import '../../about.dart';
import '../../viewmodels/game_viewmodel.dart';
import 'package:share_plus/share_plus.dart';

var logger = Logger();

class MinesweeperScreen extends StatelessWidget {
  const MinesweeperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String difficulty = args?['difficulty'] ?? 'Desconocida';
    final int gridSize = args?['gridSize'] ?? 10;

    return ChangeNotifierProvider(
      create: (_) => GameViewModel(gridSize: gridSize),
      child: Consumer<GameViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text("Buscaminas - $difficulty"),
              centerTitle: true,
              actions: [
                // 👇 Botón de compartir solo aparece cuando el juego terminó
                if (viewModel.isGameOver)
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      final String mensaje = '¡Acabo de jugar Buscaminas Pro!\n'
                          'Dificultad: $difficulty\n'
                          'Tiempo de supervivencia: ${viewModel.secondsElapsed} segundos.\n'
                          '¡Intenta superarme!';
                      Share.share(mensaje);
                    },
                  ),
                IconButton(
                  icon: const Icon(Icons.person_outline),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutScreen()),
                    );
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
                itemCount: gridSize * gridSize,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => viewModel.onCellTap(index),
                    child: MineCell(
                      hasMine: viewModel.hasMine(index),
                      isRevealed: viewModel.isRevealed(index),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
