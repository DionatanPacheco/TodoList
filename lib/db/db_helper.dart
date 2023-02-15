// ignore_for_file: prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers

import 'package:projeto_ge2/models/task.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'tasks';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }

    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, note TEXT , date STRING, "
            " starTime STRING, "
            "endTime STRING,"
            "remind INTEGER, "
            "repeat STRING,"
            " color INTEGER, "
            "isComplete INTEGER)",
          );
        },
      );
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<int> insert(Task? task) async =>
      await _db?.insert(
        _tableName,
        task!.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ) ??
      1;

  static Future<List<Map<String, dynamic>>> query() async =>
      await _db?.query(_tableName) ?? <Map<String, dynamic>>[];

  static delete(Task task) async =>
      await _db!.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);

  static update(int id) async => await _db!.rawUpdate(
        '''
      UPDATE tasks
      SET isComplete = ?
      WHERE id = ?
    ''',
        [1, id],
      );
}
