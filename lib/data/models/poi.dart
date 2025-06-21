// lib/data/models/poi.dart

class POI {
  final int? id; // El ID del POI puede ser nulo al crear uno nuevo (AUTOINCREMENT)
  final int routeId; // <--- ID de la ruta a la que pertenece este POI
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final String imageUrl;

  const POI({
    this.id, // Puede ser nulo
    this.routeId = 0, // Valor por defecto para evitar errores al inicio
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
  });

  // Método para crear un POI desde un mapa de la base de datos
  factory POI.fromMap(Map<String, dynamic> map) {
    return POI(
      id: map['id'],
      routeId: map['route_id'],
      name: map['name'],
      description: map['description'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      imageUrl: map['imageUrl'],
    );
  }

  // Método para convertir un POI a un mapa para la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Puede ser nulo para AUTOINCREMENT
      'route_id': routeId,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
    };
  }

  // Método copyWith para crear una nueva instancia con valores modificados
  POI copyWith({
    int? id,
    int? routeId,
    String? name,
    String? description,
    double? latitude,
    double? longitude,
    String? imageUrl,
  }) {
    return POI(
      id: id ?? this.id,
      routeId: routeId ?? this.routeId,
      name: name ?? this.name,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}