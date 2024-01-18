import '/model/login_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  // DatabaseHelper._internal() {
  //   // if (_database == null) database;
  // }
  // static final DatabaseHelper instance = DatabaseHelper._internal();
  // static Database? _database;
  //
  // Future<Database> get database async {
  //   if (_database != null) return _database!;
  //   _database = await _getDB();
  //   return _database!;
  // }

  static const int _version = 1;
  static const String _dbName = "FjuHeart.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Login(account TEXT PRIMARY KEY, password TEXT NOT NULL, logindt datetime default current_timestamp);"),
        version: _version);
  }

  static Future<int> addNote(Login login) async {
    final db = await _getDB();
    return await db.insert("Login", login.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(Login login) async {
    final db = await _getDB();
    return await db.update("Login", login.toJson(),
        where: 'account = ?',
        whereArgs: [login.account],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNote(Login login) async {
    final db = await _getDB();
    return await db.delete(
      "Login",
      where: 'account = ?',
      whereArgs: [login.account],
    );
  }

  static Future<List<Login>?> getAllNotes() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(
        "Login"
    );
    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Login.fromJson(maps[index]));
  }




}