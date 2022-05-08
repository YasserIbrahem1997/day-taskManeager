import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:todotask/model/Note.dart';

class HelperTodo {
  static Database? _db;
  static final _nameTable = "NOTETASK";

  Future <Database?> get db async {
    if (_db == null) {
      _db = await intialDB();
      return _db;
    } else {
      return _db;
    }
  }

  static intialDB() async {
    io.Directory directory = await getApplicationSupportDirectory();
    String path = join(directory.path, "TaskNote.db");
    var mydb = await openDatabase(
        path,
        version: 1,
        onCreate: _oncreated
    );
    return mydb;
  }

  static FutureOr<void> _oncreated(Database db, int version) async {
    print("creating a new one");
    try {
      await db.execute(
          'CREATE TABLE NOTETASKKK (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,description TEXT NOT NULL,title TEXT NOT NULL,date TEXT NOT NULL,done TEXT NOT NULL)');
    } catch (e) {
      print("eeeeeeorororororoororor $e");
    }
  }


  insertdb(Map<String, dynamic> data) async {
    Database? db_Clint = await db;
    var results = await db_Clint!.insert(_nameTable, data);
    return results;
  }


  deletedb(int id) async {
    Database? db_Clint = await db;
    var reselt =
    await db_Clint!.rawDelete("DELETE FROM $_nameTable WHERE id='$id' ");
    return reselt;
  }

  Updatedb(int id, String title, String note) async {
    Database? db_Clint = await db;
    var reselt = await db_Clint!
        .rawUpdate("UPDATE $_nameTable SET note SET title WHERE id='$id' ");
    return reselt;
  }

  getSingelRow(int id) async {
    Database? db_clint = await db;
    var reselt = await db_clint!.query(_nameTable, where: 'id="$id"');
    return reselt;
  }

  Future<List<TodoModle>> getData() async {
    Database?db_Clint = await db;
    List<TodoModle>list = [];
    var reselt = await db_Clint!.query(_nameTable);
    print(reselt);
    for (var i in reselt) {
      TodoModle todoModle = TodoModle(
          id: i["id"],
          description: i["description"],
          title: i["title"],
          date: i["date"],
          done: i["done"]);
      list.add(todoModle);
    }
    return list;
  }


// Future<List<TodoModle>> getData() async {
//   Database? db_Clint = await db;
//   List<TodoModle> list = [];
//   var reselt = await db_Clint!.query(_nameTable);
//   print(reselt);
//   for (var i in reselt) {
//     TodoModle todoModel = TodoModle(
//         id: i["id"],
//         description: i["description"],
//         title: i["title"],
//         date: i["date"],
//         done: i["done"]);
//     list.add(todoModel);
//   }
//   return list;
// }


}
