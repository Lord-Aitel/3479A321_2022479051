import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'ui/screens/minesweeper_screen.dart';
import 'ui/screens/history_screen.dart';
import 'about.dart';
import 'ui/screens/menu_screen.dart';

var logger = Logger();

void main() {
  logger.d('Iniciando la aplicación de Buscaminas');
  //logger.i('Iniciando la aplicación de Buscaminas'); // Info
  //logger.w('Iniciando la aplicación de Buscaminas'); // Warning
  //logger.e('Error en la ejecucion'); // Error

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Buscaminas',
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 11, 10, 11),
          primary: const Color.fromARGB(255, 0, 0, 0),
          secondary: const Color.fromARGB(255, 0, 0, 0)
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 102, 4, 250), 

      textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
      useMaterial3: true,
      ),
        initialRoute: '/menu',
        routes: {
          '/menu': (context) => const MenuScreen(),
          '/game': (context) => const MinesweeperScreen(),
          '/history': (context) => const HistoryScreen(),
          '/about': (context) => const AboutScreen(),
        },
      //home: const MinesweeperScreen(), // Apuntamos a nuestra nueva pantalla
      );
      
  }
}