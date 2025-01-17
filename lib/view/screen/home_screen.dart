import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controller/controller.dart';
import 'package:getx_sqflite/view/screen/edit_screen.dart';
import 'package:getx_sqflite/view/widgets/todo_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(SQLController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.deleteTheDatabase();
            },
            icon: const Icon(Icons.remove),
          ),
          IconButton(
            onPressed: () {
              controller.getAllData();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
              () => EditScreen(
                    id: null,
                  ),
              transition: Transition.downToUp);
        },
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<SQLController>(
        builder: (controller) => ListView.builder(
          itemCount: controller.list.length,
          itemBuilder: (context, index) =>
              TodoItem(controller: controller, index: index),
        ),
      ),
    );
  }
}
