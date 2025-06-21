// lib/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  // Tema Claro
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true, // Habilitar Material 3
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple, // Color base de tu aplicación
        brightness: Brightness.light,
        // Puedes personalizar más colores si lo deseas:
        // primary: Colors.deepPurple,
        // onPrimary: Colors.white,
        // secondary: Colors.orange,
        // onSecondary: Colors.white,
        // surface: Colors.white,
        // onSurface: Colors.black87,
        // inversePrimary: Colors.deepPurple.shade100, // Usado en AppBar en ActividadesPage
      ),
      appBarTheme: const AppBarTheme(
        // Puedes personalizar aquí el estilo de tu AppBar globalmente
        centerTitle: true,
        // Si no defines foregroundColor aquí, lo tomará del onPrimary del ColorScheme
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Radio de las tarjetas
        ),
      ),
      // Otros ajustes globales para el tema claro...
    );
  }

  // Tema Oscuro
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true, // Habilitar Material 3
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple, // Mismo color base para consistencia
        brightness: Brightness.dark,
        // Puedes personalizar más colores para el tema oscuro:
        // primary: Colors.deepPurple.shade700,
        // onPrimary: Colors.white,
        // secondary: Colors.orange.shade700,
        // onSecondary: Colors.white,
        // surface: Colors.grey.shade900,
        // onSurface: Colors.white70,
        // inversePrimary: Colors.deepPurple.shade900,
      ),
      appBarTheme: const AppBarTheme(
        // Estilo de AppBar para el tema oscuro
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      // Otros ajustes globales para el tema oscuro...
    );
  }
}