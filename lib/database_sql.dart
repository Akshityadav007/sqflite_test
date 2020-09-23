import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_test/help.dart';

class DatabaseSql {
  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;

  // static final _tableName = 'myTable';
  //
  // static final columnId = 'id';
  // static final columnName = 'Lecture';

  DatabaseSql._();

  static final DatabaseSql db = DatabaseSql._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion,
        onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE lectures(
        primaryKey TEXT PRIMARY KEY,
        attendedLectures TEXT,
        totalLectures TEXT
        )
      ''');
    },
    );
  }

  newLectureData(Lectures newLectureData) async {
    final db = await database;

    var res = await db.rawInsert('''
    INSERT INTO lectures(
    attendedLectures,totalLectures
    ) VALUES (?,?)
     ''',[newLectureData.attendedLectures,newLectureData.totalLectures]);

    return res;
  }

  Future<dynamic> getLecture() async {
    final db = await database;

    var res = await db.query('lectures');
    if(res.length == 0){
      return null;
    }
    else{
      var resMap = res[0];
      return resMap.isNotEmpty?resMap:Null;
    }
  }


  update(String attendedLectures,String totalAttendance) async {
    final db = await database;
    var res = await db.rawUpdate('''
    UPDATE lectures
    SET attendedLectures = ?, totalLectures = ?
    WHERE primaryKey = ?
    ''',['$attendedLectures','$totalAttendance','attendance']);
    return res;
  }


// Future update(Map<String, dynamic> row) async {
//   Database db = await instance.database;
//   int id = row[columnId];
//   return await db
//       .update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);
// }
//
// Future showQuery(int _id) async {
//   Database db = await instance.database;
//   return await db.rawQuery('SELECT * FROM myTable WHERE id=?', [_id]);
// }
//
// Future<int> delete(int id) async {
//   Database db = await instance.database;
//   return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
// }
}
