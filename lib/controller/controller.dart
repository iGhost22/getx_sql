import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLController extends GetxController {
  @override
  void onInit() {
    createDatabase();
    super.onInit();
  }

  void createDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');
    // print(path);

    openAppDatabase(path: path);
  }

  void deleteTheDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');

    await deleteDatabase(path);
    print("deleted");
  }

  void openAppDatabase({required String path}) async {
    // open the database
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        // todo => is our thable name / primary key increment automatically
        await db.execute(
            'CREATE TABLE todo (id INTEGER PRIMARY KEY, title TEXT, description TEXT, time favorite INTEGER, completed INTEGER)');

        debugPrint('Database is created');
      },
      onOpen: (Database database) {
        // Database is open, print its version
        debugPrint("Database is opened");
        // print('Database version: ${database.getVersion()}');
      },
    );
  }

  void getAllData() {}

  void insertData() {}

  void updateData() {}

  void deleteData() {}
}
