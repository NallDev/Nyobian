import 'package:restaurant_app/data/model/search_restaurant_response.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper? _instance;
  static Database? _database;

  DbHelper._internal() {
    _instance = this;
  }

  factory DbHelper() => _instance ?? DbHelper._internal();

  static const String _tableRestaurants = 'restaurants';

  Future<Database> _initializeDb() async {
    var dbPath = await getDatabasesPath();
    var db = openDatabase(
      '$dbPath/restaurant.db',
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $_tableRestaurants (
          id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          pictureId TEXT,
          city TEXT,
          rating REAL
        );
      ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<void> insertRestaurant(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tableRestaurants, restaurant.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Restaurant>> getRestaurants() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tableRestaurants);

    return results.map((e) => Restaurant.fromJson(e)).toList();
  }

  Future<bool> isRestaurantFavorite(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results =
        await db!.query(_tableRestaurants, where: "id = ?", whereArgs: [id]);

    return results.map((e) => Restaurant.fromJson(e)).toList().isNotEmpty;
  }

  Future<void> deleteRestaurant(String id) async {
    final db = await database;

    await db!.delete(
      _tableRestaurants,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
