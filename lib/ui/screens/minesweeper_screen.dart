import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../widgets/mine_cell.dart';
import '../../about.dart';

var logger = Logger();

class MinesweeperScreen extends StatefulWidget {
  const MinesweeperScreen({super.key});

  @override
  State<MinesweeperScreen> createState() => _MinesweeperScreenState();
}

class _MinesweeperScreenState extends State<MinesweeperScreen> {
  /* Definimos el tamaño del tablero
  final int rows = 8;
  final int columns = 8;*/

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String difficulty = args?['difficulty'] ?? 'Desconocida';
    final int gridSize = args?['gridSize'] ?? 10; //

    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Buscaminas - $difficulty"), // se señala la dificultad en el título
        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              );
            },
          ),
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          // Configuración de la cuadrícula
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridSize, // Número de columnas, ahora dependiente del argumento recibido
            mainAxisSpacing: 4.0,    // Espaciado vertical
            crossAxisSpacing: 4.0,   // Espaciado horizontal
          ),
          itemCount: gridSize * gridSize, // Total de celdas, ahora dependiente del argumento recibido
          itemBuilder: (context, index) {
            bool tieneMina = index % 7 == 0; 
            

            return MineCell(hasMine: tieneMina);
          },
        ),
      ),
    );
  }
}
