import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? database;

  // check database
  Future<Database?> checkDatabase() async {
    if (database == null) {
      return await createDatabase();
    } else {
      return database;
    }
  }

  // create database
  Future<Database> createDatabase() async {
    Directory databasesPath = await getApplicationDocumentsDirectory();
    String path = join(databasesPath.path, 'todo.db');
    String sql =
        'CREATE TABLE todotable(id INTEGER PRIMARY KEY, task TEXT,desc TEXT,date TEXT,priority INTEGER)';
    return openDatabase(path,
      version: 1,
      onCreate: (db, version) async {
         db.execute(sql);
      },
    );
  }

  // insert database
Future<void> insertDatabase({required task,required desc,required date,required priority})
async {
  database = await checkDatabase();
  database!.insert('todotable', {'task':task,'desc':desc,'date':date,'priority':priority});
}
//


 Future<List<Map>> readDatabase() async {
  database = await checkDatabase();
  String sql = 'SELECT * FROM todotable';
  List<Map> list = await database!.rawQuery(sql);
  return list;
}

Future<void> deletedDatabase({required id})
async {
  database = await checkDatabase();
  database!.delete('todotable', where: "id=?", whereArgs: [id]);
}

















}
