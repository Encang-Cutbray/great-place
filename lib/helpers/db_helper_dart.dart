import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as path;

class DBHelper {
  static const _dbName = 'places.db';
  static const userPlaces = 'user_places';

  static Future<sqlite.Database> database() async {
    final dbPath = await sqlite.getDatabasesPath();

    return sqlite.openDatabase(
      path.join(dbPath, _dbName),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $userPlaces (id TEXT PRIMARY KEY, title TEXT, image_path TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    return db.insert(
      userPlaces,
      data,
      conflictAlgorithm: sqlite.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getPlaces(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
