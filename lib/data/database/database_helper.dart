// lib/data/database/database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/AppRoute.dart'; // Importa AppRoute
import '../models/poi.dart';   // Importa POI

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    String databasePath = join(path, 'rastro_urbano.db');

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Añadir onUpgrade para futuras migraciones
    );
  }

  void _onCreate(Database db, int version) async {
    // Tabla para AppRoutes
    await db.execute('''
      CREATE TABLE routes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        duration TEXT NOT NULL,
        difficulty TEXT NOT NULL
      )
    ''');

    // Tabla para POIs, con clave foránea a routes
    await db.execute('''
      CREATE TABLE pois (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        route_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        imageUrl TEXT NOT NULL,
        FOREIGN KEY (route_id) REFERENCES routes (id) ON DELETE CASCADE
      )
    ''');
  }

  // Método para manejar actualizaciones de esquema de base de datos
  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Si en el futuro necesitas añadir nuevas tablas o columnas,
    // lo harías aquí con lógica condicional por versión.
    // Por ejemplo:
    // if (oldVersion < 2) {
    //   await db.execute("ALTER TABLE routes ADD COLUMN new_column TEXT;");
    // }
  }


  // --- Operaciones CRUD para AppRoute ---

  Future<int> insertRoute(AppRoute route) async {
    final db = await database;
    // Insertar la ruta y obtener el ID generado
    int id = await db.insert('routes', route.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace); // replace si el id ya existe

    // Insertar los POIs asociados a la ruta (si los hay)
    for (var poi in route.pointsOfInterest) {
      await insertPoi(poi.copyWith(routeId: id)); // Asigna el route_id del AppRoute
    }
    return id;
  }

  Future<List<AppRoute>> getRoutes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('routes');

    if (maps.isEmpty) {
      return [];
    }

    // Para cada mapa de ruta, obtén sus POIs asociados
    return await Future.wait(maps.map((routeMap) async {
      final int routeId = routeMap['id'];
      final List<POI> pois = await getPoisForRoute(routeId);
      return AppRoute.fromMap(routeMap, pois);
    }).toList());
  }

  Future<int> updateRoute(AppRoute route) async {
    final db = await database;
    // Actualizar la ruta
    int updatedRows = await db.update(
      'routes',
      route.toMap(),
      where: 'id = ?',
      whereArgs: [route.id],
    );

    // Opcional: Para actualizar POIs, podrías borrar los antiguos y reinsertar los nuevos,
    // o implementar una lógica más fina para actualizar/eliminar/insertar POIs individuales.
    // Por simplicidad para este ejemplo, si actualizas una ruta, podrías considerar
    // que los POIs se gestionan por separado o se reinsertan.
    // Por ahora, no hay un método update para POI, así que esta parte es un TODO.
    // TODO: Implementar lógica de actualización de POIs al actualizar una ruta.

    return updatedRows;
  }

  Future<int> deleteRoute(int id) async {
    final db = await database;
    // ON DELETE CASCADE en la definición de la tabla POIs asegura que
    // los POIs asociados se borren automáticamente al borrar la ruta.
    return await db.delete(
      'routes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- Operaciones CRUD para POI ---

  Future<int> insertPoi(POI poi) async {
    final db = await database;
    return await db.insert('pois', poi.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<POI>> getPoisForRoute(int routeId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'pois',
      where: 'route_id = ?',
      whereArgs: [routeId],
      orderBy: 'id ASC', // Opcional: ordenar por ID para consistencia
    );
    return List.generate(maps.length, (i) {
      return POI.fromMap(maps[i]);
    });
  }

  Future<int> updatePoi(POI poi) async {
    final db = await database;
    return await db.update(
      'pois',
      poi.toMap(),
      where: 'id = ?',
      whereArgs: [poi.id],
    );
  }

  Future<int> deletePoi(int id) async {
    final db = await database;
    return await db.delete(
      'pois',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- Métodos de utilidad ---

  // Método para borrar toda la base de datos (útil para desarrollo/pruebas)
  Future<void> deleteDatabaseFile() async {
    String path = await getDatabasesPath();
    String databasePath = join(path, 'rastro_urbano.db');
    await deleteDatabase(databasePath);
    _database = null; // Resetear la instancia de la base de datos
    print("Database file deleted: $databasePath");
  }
}