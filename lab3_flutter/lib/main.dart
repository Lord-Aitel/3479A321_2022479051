import 'package:flutter/material.dart';
import 'package:lab3_flutter/pages/my_home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicacion de contador.Lab3Peters',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 215, 106, 16)),
        useMaterial3: true,
        primaryColor: Colors.blue, 
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        fontFamily: 'Roboto', 
      ),
      home: const MyHomePage(title: 'Mi Primer HomePage'),
    );
  }
}