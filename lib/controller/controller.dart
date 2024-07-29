import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/model/todo_model.dart';

class SQLController extends GetxController {
  @override
  void onInit() {
    createDatabase();
    super.onInit();
  }

  late Database database;

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
    await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        // todo => is our thable name / primary key increment automatically
        await db.execute('CREATE TABLE todo (id INTEGER PRIMARY KEY, '
            'title TEXT, description TEXT, time Text, favorite INTEGER, '
            'completed INTEGER)');

        debugPrint('Database is created');
      },
      onOpen: (Database db) {
        // Database is open, print its version
        database = db;
        debugPrint("Database is opened");
        // print('Database version: ${database.getVersion()}');
      },
    );
  }

  List<TodoModel> list = [];

  void getAllData() async {
    list = [];
    var allData = await database.query("todo");
    for (var i in allData) {
      list.add(TodoModel.fromJson(i));
    }
    // debugPrint(allData.toString());
    update();
  }

  void insertData({
    required String title,
    required String description,
    required String time,
    // required int favorite,
    // required int completed,
  }) async {
    try {
      var insert = await database.insert("todo", {
        "title": title,
        "description": description,
        "time": time,
        "favorite": 0,
        "completed": 0,
      });
      Get.back();
      debugPrint("$insert data inserted");
      getAllData();
    } catch (e) {
      debugPrint(e.toString());
    }

    // update();
  }

  bool updateTaskData = false;

  void updateData({
    required String title,
    required String description,
    required String time,
    required int id,
  }) async {
    try {
      var updateData = await database.update(
        "todo",
        {
          "title": title,
          "description": description,
          "time": time,
          "favorite": 1,
          "completed": 1,
        },
        where: 'id = $id',
      );
      Get.back();
      debugPrint("Update item ${updateData}");
      getAllData();
    } catch (e) {
      debugPrint(e.toString());
    }
    // var updateData = await database.update(
    //   "todo",
    //   {
    //     "title": title,
    //     "description": description,
    //     "time": time,
    //     "favorite": 1,
    //     "completed": 1,
    //   },
    //   where: 'id = $id',
    // );
    // Get.back();
    // debugPrint("Update item ${updateData}");
    // getAllData();
  }

  void deleteData({required int id}) async {
    var deletedItem = await database.delete("todo", where: "id = $id");
    debugPrint("Deleted item ${deletedItem}");
    getAllData();
  }
}
