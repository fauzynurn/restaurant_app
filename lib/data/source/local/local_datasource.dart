import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSource {
  static Database _db;
  final SharedPreferences _pref;

  LocalDataSource(this._pref);

  static String _favoriteTable = 'favorite';
  static String _restaurantNotification = 'res_notif';

  Future<Database> get database async {
    if (_db == null) {
      _db = await _initializeDb();
    }

    return _db;
  }

  void setRestaurantNotification(bool value) async {
    await _pref.setBool(_restaurantNotification, value);
  }

  bool getRestaurantNotification() =>
      _pref.getBool(_restaurantNotification) ?? false;

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/favorite.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_favoriteTable (
               id TEXT PRIMARY KEY,
               thumb TEXT, name TEXT, cuisines TEXT,
               average_cost_for_two INTEGER, user_rating TEXT
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<void> addToFavorite(Restaurant res) async {
    final Database db = await database;
    await db.insert(_favoriteTable, res.toMap());
  }

  Future<void> removeFromFavorite(String id) async {
    final db = await database;

    await db.delete(
      _favoriteTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isOnFav(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _favoriteTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty;
  }

  Future<List<Restaurant>> getFavoriteRestaurant() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_favoriteTable);

    return results.map((res) => Restaurant.fromMap(res)).toList();
  }
}
