import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/app_data.dart';
import 'pages/about_page.dart';
import 'pages/preferences_page.dart'; // Importa PreferenciasPage (nombre de la clase real)
import 'pages/activities_page.dart'; // Mantén esta importación para la página de placeholder
import 'data/database/database_helper.dart'; // Importa el DatabaseHelper
import 'data/models/AppRoute.dart'; // Importa AppRoute (verifica que tu archivo se llame route.dart y no AppRoute.dart)
import 'app_theme.dart'; // Para AppColors.onPrimary si lo usas en el DrawerHeader
import 'pages/route_detail_page.dart';
import 'pages/route_form_page.dart';
import 'data/models/poi.dart'; // ¡Importa la nueva página de formulario de rutas!

// Mock data, asegúrate de que este archivo también exista en data/models/mock_routes.dart
// Si no lo tienes, puedes definirlo directamente aquí o en un archivo aparte.
// Lo más común es tenerlo en un archivo separado, ej. 'data/models/mock_routes.dart'
// Si tu AppRoute.dart no define mockRoutes, asegúrate de tener una lista aquí o importarla.
// Para este ejemplo, lo defino aquí temporalmente para que compile si no lo tienes separado.
List<AppRoute> mockRoutes = [
  AppRoute(
    id: 1, // IDs serán ignorados por insertRoute, pero los mantengo para consistencia en mocks
    name: 'Ruta Histórica de Talca',
    description: 'Un recorrido a pie por los sitios históricos más emblemáticos de Talca, desde la Plaza de Armas hasta la Recova.',
    imageUrl: 'https://img.fotocommunity.com/plaza-de-armas-talca-a5a544c4-722a-4318-9774-8395562d98c2.jpg?height=1080',
    duration: '2.5 hrs',
    difficulty: 'Fácil',
    pointsOfInterest: [
      POI(id: 1, routeId: 1, name: 'Plaza de Armas', description: 'Corazón de Talca, rodeada de edificios históricos.', latitude: -35.4267, longitude: -71.6667, imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Plaza_de_Armas_de_Talca.JPG/1200px-Plaza_de_Armas_de_Talca.JPG'),
      POI(id: 2, routeId: 1, name: 'Catedral de Talca', description: 'Impresionante arquitectura, reconstruida varias veces.', latitude: -35.4275, longitude: -71.6675, imageUrl: 'https://live.staticflickr.com/8326/8099307767_405788939c_b.jpg'),
      POI(id: 3, routeId: 1, name: 'Mercado Central (La Recova)', description: 'Centro de comercio local con productos frescos y artesanía.', latitude: -35.4240, longitude: -71.6700, imageUrl: 'https://talcacity.cl/wp-content/uploads/2016/09/mercado-talca-la-recova.jpg'),
    ],
  ),
  AppRoute(
    id: 2,
    name: 'Parques y Naturaleza Urbana',
    description: 'Explora los pulmones verdes de Talca, ideales para un paseo relajante o actividades al aire libre.',
    imageUrl: 'https://www.utalca.cl/media/galeria/slider-p1/destacada_jardin-botanico.jpg',
    duration: '1.5 hrs',
    difficulty: 'Fácil',
    pointsOfInterest: [
      POI(id: 4, routeId: 2, name: 'Jardín Botánico UTalca', description: 'Gran diversidad de flora, un oasis en la ciudad.', latitude: -35.4510, longitude: -71.6490, imageUrl: 'https://www.utalca.cl/media/galeria/slider-p1/jardin-botanico.jpg'),
      POI(id: 5, routeId: 2, name: 'Parque de la Cultura (Ex-ORION)', description: 'Espacio para el arte, la cultura y la recreación familiar.', latitude: -35.4180, longitude: -71.6750, imageUrl: 'https://vivimoslanoticia.cl/wp-content/uploads/2021/04/parque-orion-talca.jpg'),
    ],
  ),
  AppRoute(
    id: 3,
    name: 'Ruta del Vino del Maule (Cercanías de Talca)',
    description: 'Un viaje a través de los viñedos y bodegas de la Región del Maule, cuna de vinos excepcionales.',
    imageUrl: 'https://vinosyviajes.cl/wp-content/uploads/2020/07/vi%C3%B1a-gonzalez-cabal.jpg',
    duration: 'Día completo',
    difficulty: 'Moderado',
    pointsOfInterest: [
      POI(id: 6, routeId: 3, name: 'Viña Balduzzi', description: 'Bodega familiar con tradición y excelentes vinos.', latitude: -35.4700, longitude: -71.5900, imageUrl: 'https://rutadelvinodelmaule.cl/wp-content/uploads/2020/07/balduzzi_galeria_01.jpg'),
      POI(id: 7, routeId: 3, name: 'Viña Terranoble', description: 'Reconocida por sus carmenere y cabernet sauvignon.', latitude: -35.3900, longitude: -71.6000, imageUrl: 'https://www.terranoble.cl/wp-content/uploads/2019/07/vinaterranoble-header.jpg'),
    ],
  ),
];


void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que Flutter esté inicializado para sqflite

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (context, appData, child) {
        return MaterialApp(
          title: 'Rastro Urbano',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appData.themeMode,
          home: const MyHomePage(title: 'Rastro Urbano'),
          routes: {
            '/about': (context) => const AboutPage(),
            '/preferences': (context) => const PreferenciasPage(), // Usamos PreferenciasPage aquí
            '/activities': (context) => const ActividadesPage(), // Ruta para la página de actividades
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper(); // Instancia del DatabaseHelper
  List<AppRoute> _routes = []; // Lista para almacenar las rutas cargadas de la DB
  bool _isLoading = true; // Para mostrar un indicador de carga

  @override
  void initState() {
    super.initState();
    _loadRoutes(); // Cargar las rutas al iniciar la pantalla
  }

  Future<void> _loadRoutes() async {
    setState(() {
      _isLoading = true; // Indicar que estamos cargando
    });

    // Opcional: Eliminar la DB para reiniciar en desarrollo
    // await _dbHelper.deleteDatabaseFile(); // ¡SOLO PARA DESARROLLO/PRUEBAS!

    List<AppRoute> routes = await _dbHelper.getRoutes();

    if (routes.isEmpty) {
      // Si la DB está vacía, insertamos los mockRoutes
      print('Base de datos de rutas vacía. Insertando rutas de prueba...');
      for (var route in mockRoutes) {
        await _dbHelper.insertRoute(route);
      }
      // Volvemos a cargar las rutas después de la inserción
      routes = await _dbHelper.getRoutes();
      print('Rutas de prueba insertadas y cargadas.');
    } else {
      print('Rutas cargadas desde la base de datos (${routes.length} rutas).');
    }

    setState(() {
      _routes = routes; // Actualizar la lista de rutas
      _isLoading = false; // Finalizar la carga
    });
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context); // Acceso a AppData para el tema

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary, // Color primario de tu tema
        foregroundColor: Theme.of(context).colorScheme.onPrimary, // Color del texto del AppBar
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'Menú Principal',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary, // Texto en color onPrimary
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
                // Ya estamos en el inicio, no hace falta navegar
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Acerca de'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Preferencias'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
                Navigator.pushNamed(context, '/preferences');
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_activity),
              title: const Text('Actividades'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
                Navigator.pushNamed(context, '/activities');
              },
            ),
            const Divider(), // Separador visual
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tema Oscuro'),
                  Switch(
                    value: appData.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      appData.toggleTheme();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _isLoading // Muestra un indicador de carga si los datos no han terminado de cargar
          ? const Center(child: CircularProgressIndicator())
          : _routes.isEmpty // Si no hay rutas después de cargar
              ? const Center(
                  child: Text('No hay rutas disponibles.', style: TextStyle(fontSize: 16, color: Colors.grey)),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Explora las rutas narrativas por Talca',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _routes.length,
                        itemBuilder: (context, index) {
                          final route = _routes[index]; // Ahora usa _routes

                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15.0),
                              onTap: () {
                                print('Navegando a los detalles de: ${route.name}');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RouteDetailPage(route: route),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        route.imageUrl,
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            height: 180,
                                            width: double.infinity,
                                            color: Colors.grey[300],
                                            child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 80),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Text(
                                      route.name,
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      route.description,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 12.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.timer, size: 18, color: Theme.of(context).colorScheme.secondary),
                                            const SizedBox(width: 4.0),
                                            Text(
                                              route.duration,
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.directions_walk, size: 18, color: Theme.of(context).colorScheme.secondary),
                                            const SizedBox(width: 4.0),
                                            Text(
                                              route.difficulty,
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // AÑADE ESTA FILA PARA LOS BOTONES DE ACCIÓN
                                    const SizedBox(height: 12.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end, // Alinea los botones a la derecha
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit, color: Colors.blue),
                                          tooltip: 'Editar Ruta',
                                          onPressed: () async {
                                            print('Editando ruta: ${route.name}');
                                            final bool? result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => RouteFormPage(routeToEdit: route), // Pasa la ruta a editar
                                              ),
                                            );
                                            if (result == true) {
                                              _loadRoutes(); // Recarga las rutas si se editó
                                            }
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                          tooltip: 'Eliminar Ruta',
                                          onPressed: () async {
                                            print('Eliminando ruta: ${route.name}');
                                            final bool? confirm = await showDialog<bool>(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text('Confirmar Eliminación'),
                                                  content: Text('¿Estás seguro de que quieres eliminar la ruta "${route.name}"?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () => Navigator.pop(context, false),
                                                      child: const Text('Cancelar'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () => Navigator.pop(context, true),
                                                      child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

                                            if (confirm == true) {
                                              await _dbHelper.deleteRoute(route.id);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Ruta "${route.name}" eliminada.')),
                                              );
                                              _loadRoutes(); // Recarga las rutas después de eliminar
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton( // <-- AÑADE ESTO
        onPressed: () async {
          print('Botón Agregar Ruta presionado');
          final bool? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RouteFormPage(), // Navega a una nueva pantalla de formulario
            ),
          );

          if (result == true) { // Si el formulario retorna 'true' (indicando que se guardó algo)
            _loadRoutes(); // Recarga las rutas para actualizar la UI
          }
        },
        tooltip: 'Agregar nueva ruta',
        child: const Icon(Icons.add),
      ),
    );
  }
}