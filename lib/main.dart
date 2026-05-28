import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'viewmodels/game_viewmodel.dart';
import 'ui/screens/minesweeper_screen.dart';
import 'ui/screens/history_screen.dart';
import 'about.dart';
import 'ui/screens/menu_screen.dart';

var logger = Logger();

void main() {
  logger.d('Iniciando la aplicación de Buscaminas');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameViewModel(gridSize: 10)),
      ],
      child: MaterialApp(
        title: 'Buscaminas',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/menu',
        routes: {
          '/menu': (context) => const MenuScreen(),
          '/game': (context) => const MinesweeperScreen(),
          '/history': (context) => const HistoryScreen(),
          '/about': (context) => const AboutScreen(),
        },
      ),
    );
  }
}
