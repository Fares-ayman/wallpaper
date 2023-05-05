import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'fares.db');
    Database myDb = await openDatabase(path,
        onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    return myDb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE photos 
      (
        id INTEGER NOT NULL PRIMARY KEY  AUTOINCREMENT, 
        url TEXT, 
        photographer TEXT, 
        avgColor TEXT, 
        original TEXT, 
        large TEXT, 
        portrait TEXT, 
        alt TEXT
      )
      ''');
  }

  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {}
}
