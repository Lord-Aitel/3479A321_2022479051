  import 'package:flutter/material.dart';

  void main() {
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});
    @override
    Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Buscaminas',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: const MinesweeperScreen(), // Apuntamos a nuestra nueva pantalla
    );
    }
  }

  class MinesweeperScreen extends StatelessWidget {
  const MinesweeperScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: const Text('Buscaminas')),
    body: SafeArea( // Protege la UI de los bordes del dispositivo
  child: Column( // Apila el marcador arriba y el tablero abajo
  children: [
  // Área de Status
  Container(
  height: 60,
  color: Colors.grey[300],
  child: Container(
  height: 60,
  color: Colors.grey[300],
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: const [
      Icon(Icons.timer, color: Colors.black),
      Text('349 s', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Icon(Icons.bug_report, color: Colors.red), //minas
      Text('10', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Icon(Icons.grid_on, color: Colors.blue), //cuadros
      Text('56', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    ],
  ),
),


  ),
  const Divider(height: 1),
  // Área de Juego
  Expanded( // Expande el tablero para llenar la pantalla
  child: _gameBoard(),
  ),
  ],
  ),
  ),
  );
  }
  }
  Widget _gameBoard() {
  return Center(
  child: Padding(
  padding: const EdgeInsets.all(8.0),
  child: AspectRatio(
  aspectRatio: 1.0, // Cuadrado perfecto
  child: GridView.builder(
  physics: const NeverScrollableScrollPhysics(), // Bloquea el scroll
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 8, // 8 columnas
  crossAxisSpacing: 2.0,
  mainAxisSpacing: 2.0,
  ),
  itemCount: 64, // 8x8 = 64 celdas
  itemBuilder: (context, index) {
  return MineCell(index: index,);
  },
  ),
  ),
  ),
  );
  }

class MineCell extends StatelessWidget {
  final int index;

  const MineCell({
    super.key,
    required this.index
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
    color: index % 2 == 0 ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 17, 0, 255),
        border: Border.all(color: Colors.grey[600]!, width: 1.5),
    ),
    );
  }
}