import 'package:flutter/material.dart';


class AppColors {
  // Colores principales
  static const Color primary = Color(0xFF673AB7); 
  static const Color primaryLight = Color(0xFF9A67EA); 
  static const Color primaryDark = Color(0xFF320B86); 

  // Colores secundarios o de acento
  static const Color secondary = Color(0xFF00BCD4); 
  static const Color secondaryLight = Color(0xFF5EDFEA);
  static const Color secondaryDark = Color(0xFF008BA4);

  // Colores neutros y de fondo
  static const Color background = Color(0xFFF5F5F5); 
  static const Color surface = Color(0xFFFFFFFF); 
  static const Color onPrimary = Color(0xFFFFFFFF); 
  static const Color onSecondary = Color(0xFF000000); 
  static const Color onBackground = Color(0xFF212121); 
  static const Color onSurface = Color(0xFF212121); 

  // Colores de estado
  static const Color error = Color(0xFFB00020); 
  static const Color onError = Color(0xFFFFFFFF); 
}

// Define el tema general de la aplicación utilizando los colores definidos
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true, 
    brightness: Brightness.light,

    // Define el ColorScheme basado en tus colores personalizados
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.error,
      onError: AppColors.onError,
      background: AppColors.background,
      onBackground: AppColors.onBackground,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
    ),

    // Configuración del AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary, // Color de fondo de la barra superior
      foregroundColor: AppColors.onPrimary, // Color del texto e íconos en la barra superior
      elevation: 4.0, // Sombra debajo del AppBar
      titleTextStyle: TextStyle(
        color: AppColors.onPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Configuracion del FloatingActionButton
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.onSecondary,
    ),

    // Configuracion de ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.onPrimary, // Color del texto del boton
        backgroundColor: AppColors.primary, // Color de fondo del boton
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    // Configuración de las tarjetas (Card)
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    ),

    // Configuración de ListTile (útil para listas en el Drawer o rutas)
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.primaryDark,
      textColor: AppColors.onBackground,
    ),

    // Configuración de la entrada de texto (TextField)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.primary, width: 2.0),
      ),
      labelStyle: TextStyle(color: AppColors.primary),
      hintStyle: TextStyle(color: Colors.grey[500]),
    ),

    // Configuración del Drawer
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.surface,
    ),

    // Puedes añadir más configuraciones de texto, íconos, etc. aquí
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: AppColors.onBackground),
      displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: AppColors.onBackground),
      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.onBackground),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.onBackground),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.onBackground),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.onBackground),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.onBackground),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.onBackground),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.onBackground),
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.onBackground),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.onBackground),
      bodySmall: TextStyle(fontSize: 12, color: AppColors.onBackground),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.onBackground),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.onBackground),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.onBackground),
    ),
  );

  // static ThemeData darkTheme = ThemeData();
}