// lib/pages/route_form_page.dart

import 'package:flutter/material.dart';
import '../data/models/AppRoute.dart'; // Importa AppRoute
import '../data/models/poi.dart';   // Importa POI (lo necesitaremos para POIs en el futuro)
import '../data/database/database_helper.dart'; // Importa DatabaseHelper

class RouteFormPage extends StatefulWidget {
  final AppRoute? routeToEdit; // Ruta opcional para edición (si es null, es una nueva ruta)

  const RouteFormPage({super.key, this.routeToEdit});

  @override
  State<RouteFormPage> createState() => _RouteFormPageState();
}

class _RouteFormPageState extends State<RouteFormPage> {
  final _formKey = GlobalKey<FormState>(); // Clave para validar el formulario
  final _dbHelper = DatabaseHelper(); // Instancia del DatabaseHelper

  // Controladores para los campos de texto
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  late TextEditingController _durationController;
  late TextEditingController _difficultyController;

  // Lista temporal para los POIs que se añadirán a esta ruta
  // Por ahora, solo es una lista vacía, pero aquí se gestionaría la adición de POIs
  List<POI> _currentPois = [];

  @override
  void initState() {
    super.initState();
    // Inicializa los controladores con los datos de la ruta si es edición
    _nameController = TextEditingController(text: widget.routeToEdit?.name ?? '');
    _descriptionController = TextEditingController(text: widget.routeToEdit?.description ?? '');
    _imageUrlController = TextEditingController(text: widget.routeToEdit?.imageUrl ?? '');
    _durationController = TextEditingController(text: widget.routeToEdit?.duration ?? '');
    _difficultyController = TextEditingController(text: widget.routeToEdit?.difficulty ?? '');

    // Si estamos editando, cargamos los POIs existentes de la ruta
    if (widget.routeToEdit != null) {
      _currentPois = List.from(widget.routeToEdit!.pointsOfInterest);
    }
  }

  @override
  void dispose() {
    // Libera los recursos de los controladores cuando la pantalla se cierra
    _nameController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _durationController.dispose();
    _difficultyController.dispose();
    super.dispose();
  }

  // Método para guardar la ruta
  Future<void> _saveRoute() async {
    if (_formKey.currentState!.validate()) { // Valida que los campos requeridos estén llenos
      final newRoute = AppRoute(
        id: widget.routeToEdit?.id ?? 0, // Si es edición, usa el ID existente; si es nuevo, 0 (sqflite lo auto incrementará)
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        imageUrl: _imageUrlController.text.trim(),
        duration: _durationController.text.trim(),
        difficulty: _difficultyController.text.trim(),
        pointsOfInterest: _currentPois, // Incluimos los POIs (aunque en este formulario no se editen aún)
      );

      if (widget.routeToEdit == null) {
        // Es una nueva ruta
        await _dbHelper.insertRoute(newRoute);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ruta creada exitosamente!')),
        );
      } else {
        // Es una edición
        await _dbHelper.updateRoute(newRoute);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ruta actualizada exitosamente!')),
        );
      }

      // Vuelve a la pantalla anterior indicando que se realizó un cambio
      if (mounted) Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routeToEdit == null ? 'Crear Nueva Ruta' : 'Editar Ruta'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la Ruta',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre de la ruta';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una descripción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'URL de la Imagen',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la URL de una imagen';
                  }
                  // Opcional: Añadir validación de formato de URL
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(
                  labelText: 'Duración (ej. "1.5 hrs")',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la duración';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _difficultyController,
                decoration: const InputDecoration(
                  labelText: 'Dificultad (ej. "Fácil", "Moderado")',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la dificultad';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),

              // TODO: Aquí se añadiría la UI para gestionar POIs (agregar/eliminar/editar)
              // Por ahora, solo mostramos un mensaje si estamos editando y tiene POIs
              if (widget.routeToEdit != null && _currentPois.isNotEmpty) ...[
                Text(
                  'Puntos de Interés actuales:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                // Aquí podrías listar los POIs y dar opciones para editarlos
                // Por simplicidad, no se implementa el CRUD de POIs en este formulario por ahora.
                ..._currentPois.map((poi) => Text('- ${poi.name}')),
                const SizedBox(height: 24.0),
              ],

              ElevatedButton.icon(
                onPressed: _saveRoute,
                icon: const Icon(Icons.save),
                label: Text(widget.routeToEdit == null ? 'Guardar Ruta' : 'Actualizar Ruta'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), // Botón de ancho completo
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}