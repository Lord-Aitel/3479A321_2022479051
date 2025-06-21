import 'poi.dart';

class AppRoute {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String duration;
  final String difficulty;
  final List<POI> pointsOfInterest;

  const AppRoute({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.duration,
    required this.difficulty,
    this.pointsOfInterest = const [],
  });

  // Método para crear un AppRoute desde un mapa de la base de datos
  factory AppRoute.fromMap(Map<String, dynamic> map, List<POI> pois) {
    return AppRoute(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      duration: map['duration'],
      difficulty: map['difficulty'],
      pointsOfInterest: pois, // Los POIs se cargan por separado
    );
  }

  // Método para convertir un AppRoute a un mapa para la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id, // En insert, el id puede ser nulo para AUTOINCREMENT
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'duration': duration,
      'difficulty': difficulty,
      // Los POIs no se incluyen aquí, se gestionan en su propia tabla
    };
  }
}

// Datos de prueba (mock data) para las rutas
// ¡AHORA NECESITAMOS AÑADIR POIS A ESTAS RUTAS DE PRUEBA!
final List<AppRoute> mockRoutes = [
  AppRoute( // Quitamos 'const' porque ahora la lista de POI no es const
    id: 1,
    name: 'El Corazón de Talca',
    description: 'Un recorrido por los puntos históricos y culturales más emblemáticos del centro de Talca.',
    imageUrl: 'https://img.fotocommunity.com/la-plaza-de-armas-talca-e028b1e4-fc19-4cd1-b210-9cf65373673f.jpg?height=1080',
    duration: '1.5 hrs',
    difficulty: 'Fácil',
    pointsOfInterest: [ // Añadimos POIs de prueba
      const POI(
        id: 101,
        name: 'Plaza de Armas de Talca',
        description: 'El corazón de la ciudad, punto de encuentro y escenario de eventos históricos. Ideal para comenzar tu aventura.',
        latitude: -35.4267,
        longitude: -71.6575,
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Plaza_de_Armas_de_Talca.jpg/1024px-Plaza_de_Armas_de_Talca.jpg',
      ),
      const POI(
        id: 102,
        name: 'Catedral de Talca',
        description: 'Imponente edificación religiosa con una rica historia.',
        latitude: -35.4278,
        longitude: -71.6570,
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Iglesia_Coraz%C3%B3n_de_Mar%C3%ADa_%28Talca%29.jpg/1200px-Iglesia_Coraz%C3%B3n_de_Mar%C3%ADa_%28Talca%29.jpg',
      ),
    ],
  ),
  AppRoute(
    id: 2,
    name: 'Mitos y Leyendas del Maule',
    description: 'Adéntrate en las historias y mitos urbanos que han moldeado la tradición de la región del Maule.',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Iglesia_Coraz%C3%B3n_de_Mar%C3%ADa_%28Talca%29.jpg/1200px-Iglesia_Coraz%C3%B3n_de_Mar%C3%ADa_%28Talca%29.jpg',
    duration: '2.0 hrs',
    difficulty: 'Moderado',
    pointsOfInterest: [
      const POI(
        id: 201,
        name: 'Casa de los Curas',
        description: 'Se dice que aquí ocurren fenómenos paranormales relacionados con antiguos sacerdotes.',
        latitude: -35.4250,
        longitude: -71.6600,
        imageUrl: 'https://www.litoralpress.cl/contenido/noticia.aspx?id=128509',
      ),
    ],
  ),
  // Añade 'pointsOfInterest' a las demás rutas también para que no den error
  AppRoute(
    id: 3,
    name: 'Sabores y Tradiciones Talquinas',
    description: 'Explora los mercados y locales donde la gastronomía local cobra vida.',
    imageUrl: 'https://chileestuyo.cl/wp-content/uploads/2021/08/Talca.jpg',
    duration: '1.0 hr',
    difficulty: 'Fácil',
    pointsOfInterest: const [], // Puedes dejar vacío si no hay POIs específicos aún
  ),
  AppRoute(
    id: 4,
    name: 'Arquitectura Histórica de Talca',
    description: 'Un viaje a través del tiempo admirando las construcciones más antiguas y emblemáticas de la ciudad.',
    imageUrl: 'https://mwz.cl/wp-content/uploads/2023/11/IMG_0129-scaled.jpg',
    duration: '2.5 hrs',
    difficulty: 'Moderado',
    pointsOfInterest: const [],
  ),
  AppRoute(
    id: 5,
    name: 'Parques y Espacios Verdes',
    description: 'Descubre los pulmones de la ciudad y relájate en sus áreas verdes.',
    imageUrl: 'https://elcentro.cl/wp-content/uploads/2024/05/WhatsApp-Image-2024-05-24-at-13.06.49.jpeg',
    duration: '1.0 hr',
    difficulty: 'Fácil',
    pointsOfInterest: const [],
  ),
];