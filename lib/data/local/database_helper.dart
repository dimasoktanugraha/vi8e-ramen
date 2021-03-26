import 'package:ramen/data/model/ramen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
 
  DatabaseHelper._createObject();
 
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }
 
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }
 
    return _database;
  }
 
  static String _tableName = 'ramen';
 
  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/ramen_db.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id INTEGER PRIMARY KEY,
               name TEXT,
               latitude REAL,
               longitude REAL
             )''',
        );
      },
      version: 1,
    );
 
    return db;
  }

  Future<void> insertRamen(Ramen ramen) async {
    final Database db = await database;
    await db.insert(_tableName, ramen.toJson());
    print('Data saved');
  }

  Future<List<Ramen>> getRamen() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);
  
    return results.map((res) => Ramen.fromJson(res)).toList();
  }

  Future<void> updateRamen(Ramen ramen) async {
  final db = await database;
 
  await db.update(
    _tableName,
    ramen.toMap(),
    where: 'id = ?',
    whereArgs: [ramen.id]
  );
}

  Future<void> deleteRamen(int id) async {
    final db = await database;
  
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  // Future<Map> getRamenByName(String name) async {
  //   final db = await database;
  
  //   List<Map<String, dynamic>> results = await db.query(
  //     _tableName,
  //     where: 'name = ?',
  //     whereArgs: [name],
  //   );
  
  //   if (results.isNotEmpty) {
  //     return results.first;
  //   } else {
  //     return {};
  //   }
  // }

  Future<int> checkRamenName(String name) async{
    final db = await database;
    int  count = Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) FROM $_tableName WHERE $name=$name")
    );
    return count;
  }

  // Future<Map> getRamenById(String id) async {
  //   final db = await database;
  
  //   List<Map<String, dynamic>> results = await db.query(
  //     _tableName,
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  
  //   if (results.isNotEmpty) {
  //     return results.first;
  //   } else {
  //     return {};
  //   }
  // }
}