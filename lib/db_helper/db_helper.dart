// ignore_for_file: constant_identifier_names

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';

import '../model/user_model.dart';

class DbHelper {
  late Database _db;

  static const String DB_Name = 'e_notes.db';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_UserID = 'id';
  static const String C_UserTitle = 'title';
  static const String C_UserNotes = 'notes';
  static const String C_UserImages = 'images';



  Future<Database> get db async {
    /* if (_db != null) {
      return _db;
    }*/

    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_UserID INTEGER PRIMARY KEY, "
        " $C_UserTitle TEXT, "
        " $C_UserNotes TEXT,"
        " $C_UserImages TEXT"

        ")");


  }
  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_User, user.toJson());
    return res;
  }

  Future<int> deleteCart(int id) async {
    var dbClient = await db;
    return await dbClient
        .rawDelete('DELETE FROM $Table_User WHERE $C_UserID = ?', [id]);
  }

  Future<List<Map<String, dynamic>>> fetchDataFromDB() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> maps =
    await dbClient.rawQuery('''SELECT * FROM $Table_User''');
    return maps;
  }

  Future<int> deleteData(int? id) async {
    var dbClient = await db;
    return await dbClient
        .rawDelete('DELETE FROM $Table_User WHERE $C_UserID = ?', [id]);
  }

}