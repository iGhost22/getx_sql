import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controller/controller.dart';
import 'package:getx_sqflite/shared/custom_text_form_field.dart';

class EditScreen extends StatelessWidget {
  EditScreen({super.key, required this.id});

  final titleController = TextEditingController();
  final desController = TextEditingController();
  final timeController = TextEditingController();
  final controller = Get.put(SQLController());
  final int? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.updateTaskData ? 'Update Task' : 'Add Task'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomFormField(
            validationText: 'The title must have a value',
            controller: titleController,
          ),
          CustomFormField(
            validationText: 'The description must have a value',
            controller: desController,
          ),
          CustomFormField(
            validationText: 'The time must have a value',
            controller: timeController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              onPressed: () {
                if (!controller.updateTaskData) {
                  controller.insertData(
                      title: titleController.text,
                      description: desController.text,
                      time: timeController.text);
                } else {
                  controller.updateData(
                    title: titleController.text,
                    description: desController.text,
                    time: timeController.text,
                    id: id!,
                  );
                }
              },
              textColor: Colors.white,
              color: Colors.red,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child:
                  Text(controller.updateTaskData ? 'Update Data' : 'Add Data'),
            ),
          ),
        ],
      ),
    );
  }
}
