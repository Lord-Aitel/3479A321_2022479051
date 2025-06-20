import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/app_data.dart';
import 'about_page.dart';
// import 'home_Page.dart'; // Si ya moviste MyHomePage, asegúrate de que esté comentado o eliminado
import 'preferences_page.dart';
import 'activities_page.dart';
import 'database_helper.dart';
import 'provider/app_theme.dart'; // Importa tu nuevo archivo de tema

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa la base de datos.
  await DatabaseHelper().database;

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rastro Urbano', // Actualizado el título de la aplicación
      theme: AppTheme.lightTheme, // Aplicando tu tema personalizado
      home: const MyHomePage(title: 'Rastro Urbano'), // Actualizado el título
      routes: {
        '/home': (context) => const MyHomePage(title: 'Rastro Urbano'),
        '/about': (context) => const AboutPage(),
        '/preferencias': (context) => const PreferenciasPage(),
        '/actividades': (context) => const ActividadesPage(), // Considerar renombrar
        // TODO: Añadir la ruta para RouteDetailPage aquí una vez que la crees
        // '/routeDetail': (context) => const RouteDetailPage(),
      },
    );
  }
}

// ================================================================
// NUEVAS CLASES Y DATOS DE PRUEBA PARA MYHOMEPAGE
// Idealmente, estas clases de modelo deberían estar en 'lib/models/route_model.dart'
// y los datos de prueba en un archivo separado o cargados desde la base de datos.
// ================================================================

// Modelo básico para una ruta narrativa
class Route {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String duration;
  final String difficulty;

  const Route({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.duration,
    required this.difficulty,
  });
}

// Datos de prueba (mock data) para las rutas
final List<Route> mockRoutes = [
  const Route(
    id: 1,
    name: 'El Corazón de Talca',
    description: 'Un recorrido por los puntos históricos y culturales más emblemáticos del centro de Talca.',
    imageUrl: 'https://img.fotocommunity.com/la-plaza-de-armas-talca-e028b1e4-fc19-4cd1-b210-9cf65373673f.jpg?height=1080',
    duration: '1.5 hrs',
    difficulty: 'Fácil',
  ),
  const Route(
    id: 2,
    name: 'Mitos y Leyendas del Maule',
    description: 'Adéntrate en las historias y mitos urbanos que han moldeado la tradición de la región del Maule.',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Iglesia_Coraz%C3%B3n_de_Mar%C3%ADa_%28Talca%29.jpg/1200px-Iglesia_Coraz%C3%B3n_de_Mar%C3%ADa_%28Talca%29.jpg',
    duration: '2.0 hrs',
    difficulty: 'Moderado',
  ),
  const Route(
    id: 3,
    name: 'Sabores y Tradiciones Talquinas',
    description: 'Explora los mercados y locales donde la gastronomía local cobra vida.',
    imageUrl: 'https://chileestuyo.cl/wp-content/uploads/2021/08/Talca.jpg',
    duration: '1.0 hr',
    difficulty: 'Fácil',
  ),
  const Route(
    id: 4,
    name: 'Arquitectura Histórica de Talca',
    description: 'Un viaje a través del tiempo admirando las construcciones más antiguas y emblemáticas de la ciudad.',
    imageUrl: 'https://mwz.cl/wp-content/uploads/2023/11/IMG_0129-scaled.jpg',
    duration: '2.5 hrs',
    difficulty: 'Moderado',
  ),
  const Route(
    id: 5,
    name: 'Parques y Espacios Verdes',
    description: 'Descubre los pulmones de la ciudad y relájate en sus áreas verdes.',
    imageUrl: 'https://elcentro.cl/wp-content/uploads/2024/05/WhatsApp-Image-2024-05-24-at-13.06.49.jpeg',
    duration: '1.0 hr',
    difficulty: 'Fácil',
  ),
];

// ================================================================

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(); // Constructor sin parámetros

  // Eliminamos los métodos vacíos de initState, didChangeDependencies, etc.
  // Solo mantén los que realmente uses.

  @override
  Widget build(BuildContext context) {
    final appData = context.watch<AppData>(); // Si aún usas appData, mantenlo.

    return Scaffold(
      appBar: AppBar(
        // Utiliza los colores del tema automáticamente gracias a Theme.of(context).colorScheme
        // backgroundColor: Theme.of(context).colorScheme.primary, // Ya no es necesario si usas el tema
        title: Text(
          '${widget.title} ',
          style: Theme.of(context).appBarTheme.titleTextStyle, // Usa el estilo del AppBar de tu tema
        ),
        actions: const [
          // Puedes añadir acciones aquí si las necesitas
        ],
      ),
      body: Center(
        child: Column( // Puedes mantener el Column si quieres algún widget encima o debajo de la lista
          children: <Widget>[
            // Puedes añadir un banner o mensaje de bienvenida aquí si lo deseas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Descubre las rutas narrativas de Talca:',
                style: Theme.of(context).textTheme.headlineSmall, // Usa un estilo de texto de tu tema
                textAlign: TextAlign.center,
              ),
            ),
            Expanded( // Envuelve ListView.builder en Expanded para que ocupe el espacio restante
              child: ListView.builder(
                itemCount: mockRoutes.length, // Número de rutas de tus datos de prueba
                itemBuilder: (context, index) {
                  final route = mockRoutes[index]; // Obtiene la ruta actual

                  return Card(
                    // Utiliza los estilos de Card de tu tema
                    margin: Theme.of(context).cardTheme.margin,
                    elevation: Theme.of(context).cardTheme.elevation,
                    shape: Theme.of(context).cardTheme.shape,
                    child: InkWell( // Usa InkWell para un efecto de "splash" al tocar
                      onTap: () {
                        // TODO: Implementar navegación a la página de detalles de la ruta
                        print('Navegando a los detalles de: ${route.name}');
                        // Ejemplo de navegación (necesitarás crear RouteDetailPage)
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => RouteDetailPage(route: route),
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Imagen de la ruta
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                route.imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.broken_image, color: Colors.grey[600]),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Detalles de la ruta
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    route.name,
                                    style: Theme.of(context).textTheme.titleLarge, // Estilo para el título de la ruta
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    route.description,
                                    style: Theme.of(context).textTheme.bodyMedium, // Estilo para la descripción
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.timer, size: 16, color: Theme.of(context).colorScheme.secondary),
                                      const SizedBox(width: 4),
                                      Text(
                                        route.duration,
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                      const SizedBox(width: 16),
                                      Icon(Icons.directions_walk, size: 16, color: Theme.of(context).colorScheme.secondary),
                                      const SizedBox(width: 4),
                                      Text(
                                        route.difficulty,
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary), // Usa el color primario de tu tema
              child: Text('Menú de Navegación', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.onPrimary)), // Estilo con color del tema
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () => Navigator.pushNamed(context, '/home'),
            ),
            ListTile(
              title: const Text('About'),
              onTap: () => Navigator.pushNamed(context, '/about'),
            ),
            ListTile(
              title: const Text('Preferencias'),
              onTap: () {
                Navigator.pushNamed(context, '/preferencias');
              },
            ),
            ListTile(
              title: const Text('Actividades'), // Renombrar en el futuro?
              onTap: () => Navigator.pushNamed(context, '/actividades'),
            ),
          ],
        ),
      ),
    );
  }
}