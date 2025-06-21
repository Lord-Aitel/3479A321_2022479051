// lib/provider/app_data.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa shared_preferences

class AppData extends ChangeNotifier {
  // --- Propiedades originales del contador y usuario ---
  int _counter = 0;
  String _username = "Usuario";
  bool _canReset = false;

  // --- Propiedades para el tema (añadidas) ---
  static const String _themeModeKey = 'themeMode'; // Clave para SharedPreferences
  ThemeMode _themeMode = ThemeMode.system; // Valor por defecto

  // --- Constructor: Carga todas las preferencias al iniciar ---
  AppData() {
    _loadCanResetPreference(); // Carga la preferencia de reseteo
    _loadThemePreference(); // Carga la preferencia del tema
  }

  // --- Getters originales ---
  int get counter => _counter;
  String get username => _username;
  bool get canReset => _canReset;

  // --- Getter para el tema (añadido) ---
  ThemeMode get themeMode => _themeMode;

  // --- Métodos originales del contador y usuario ---
  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    _counter--;
    notifyListeners();
  }

  void resetCounter() {
    if (_canReset) {
      _counter = 0;
      notifyListeners();
    }
  }

  void updateUsername(String name) {
    _username = name;
    notifyListeners();
  }

  // --- Métodos para la preferencia de reseteo ---
  Future<void> setCanReset(bool value) async {
    _canReset = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isResetEnabled', value);
  }

  Future<void> _loadCanResetPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _canReset = prefs.getBool('isResetEnabled') ?? false;
    notifyListeners();
  }

  // --- Métodos para el tema (añadidos) ---
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedThemeMode = prefs.getString(_themeModeKey);

    if (savedThemeMode == 'light') {
      _themeMode = ThemeMode.light;
    } else if (savedThemeMode == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      await prefs.setString(_themeModeKey, 'dark');
    } else if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.system; // Alterna a system después de dark
      await prefs.setString(_themeModeKey, 'system');
    } else {
      _themeMode = ThemeMode.light; // Alterna a light después de system
      await prefs.setString(_themeModeKey, 'light');
    }
    notifyListeners();
  }
}