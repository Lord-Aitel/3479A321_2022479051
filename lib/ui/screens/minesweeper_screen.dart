import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../widgets/mine_cell.dart';

var logger = Logger();

class MinesweeperScreen extends StatefulWidget {
  const MinesweeperScreen({super.key});

  @override
  State<MinesweeperScreen> createState() => _MinesweeperScreenState();
}

class _MinesweeperScreenState extends State<MinesweeperScreen> {
  // Definimos el tamaño del tablero
  final int rows = 8;
  final int columns = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Buscaminas"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          // Configuración de la cuadrícula
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns, // Número de columnas
            mainAxisSpacing: 4.0,    // Espaciado vertical
            crossAxisSpacing: 4.0,   // Espaciado horizontal
          ),
          itemCount: rows * columns, // Total de celdas
          itemBuilder: (context, index) {
            // Ejemplo: ponemos una mina si el índice es múltiplo de 7
            bool tieneMina = index % 7 == 0; 
            
            // LLAMADA A TU WIDGET MINECELL
            return MineCell(hasMine: tieneMina);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logger.i('Reiniciando o refrescando tablero');
          setState(() {}); // Refresca la pantalla
        },
        tooltip: 'Refrescar',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
