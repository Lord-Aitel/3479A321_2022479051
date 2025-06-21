// lib/pages/activities_page.dart

import 'package:flutter/material.dart';
// Ya no necesitamos importar 'actividad.dart' porque no vamos a usar esa clase
// Ya no necesitamos importar DatabaseHelper directamente aquí por ahora,
// ya que esta página no interactuará con la BD para "actividades" específicas.

class ActividadesPage extends StatelessWidget { // Cambiado a StatelessWidget ya que no tendrá estado local por ahora
  const ActividadesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividades'), // Título de la página
        backgroundColor: Theme.of(context).colorScheme.primary, // Usa el color primario de tu tema
        foregroundColor: Theme.of(context).colorScheme.onPrimary, // Color del texto del AppBar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction, // Un ícono representativo de "en construcción"
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 20),
              Text(
                'Esta es la página de Actividades.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                'Aquí podrás ver el progreso o funcionalidades futuras relacionadas con tus rutas o logros.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 30),
              // Opcional: Un botón para volver a Home
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/home'));
                },
                icon: const Icon(Icons.home),
                label: const Text('Volver a Home'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}