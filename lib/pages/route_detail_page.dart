import 'package:flutter/material.dart';
import '../data/models/AppRoute.dart'; 


class RouteDetailPage extends StatelessWidget {
  final AppRoute route; 

  const RouteDetailPage({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          route.name,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              child: Image.network(
                route.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey[600],
                      size: 80,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    route.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.timer, size: 20, color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(width: 5),
                      Text(
                        'Duración: ${route.duration}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: 20),
                      Icon(Icons.directions_walk, size: 20, color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(width: 5),
                      Text(
                        'Dificultad: ${route.difficulty}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const Divider(height: 30),
                  Text(
                    'Acerca de esta ruta:',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    route.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),

                  // INICIO DE LA SECCIÓN DE POIS - ¡NUEVA IMPLEMENTACIÓN!
                  if (route.pointsOfInterest.isNotEmpty) ...[ // Muestra solo si hay POIs
                    Text(
                      'Puntos de Interés Destacados:',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 15),
                    // Usamos Column para una lista de POIs en SingleChildScrollView
                    Column(
                      children: route.pointsOfInterest.map((poi) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10), // Margen entre POIs
                          elevation: 2.0,
                          shape: Theme.of(context).cardTheme.shape,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (poi.imageUrl.isNotEmpty) // Muestra imagen si existe
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      poi.imageUrl,
                                      width: double.infinity,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: double.infinity,
                                          height: 150,
                                          color: Colors.grey[200],
                                          child: Icon(Icons.location_on, color: Colors.grey[500]),
                                        );
                                      },
                                    ),
                                  ),
                                if (poi.imageUrl.isNotEmpty) const SizedBox(height: 10),
                                Text(
                                  poi.name,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  poi.description,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton.icon(
                                    onPressed: () {
                                      // TODO: Acción al tocar un POI, quizás ver en mapa o más detalles
                                      print('Ver detalles de POI: ${poi.name} (Lat: ${poi.latitude}, Lng: ${poi.longitude})');
                                      // Aquí podrías navegar a una página de detalle de POI
                                      // o abrir un mapa con la ubicación.
                                    },
                                    icon: const Icon(Icons.info_outline),
                                    label: const Text('Ver más'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                  // FIN DE LA SECCIÓN DE POIS

                  // Botón para iniciar la ruta
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Lógica para iniciar la ruta (ej. iniciar seguimiento GPS, etc.)
                        print('Iniciando ruta: ${route.name}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Iniciando ruta: ${route.name}!')),
                        );
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Iniciar Ruta'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}