import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_2486/utils/databasehelper.dart';

class Homecontroller extends GetxController
{
  RxBool isGrid = false.obs;
  RxBool isDark = false.obs;
  RxInt priority = 0.obs;
  RxString date = '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'.obs;

  RxList<bool> toggleBool = <bool>[
    false,
    false,
    false,
    false,
  ].obs;

  RxList priorityList = [
    'Low',
    'Meduim',
    'High',
    'Urgent',
  ].obs;
  RxList<Color> colorList = <Color>[
    Colors.yellow,
    Colors.blue,
    Colors.orange,
    Colors.red,
  ].obs;

  RxList<Map> todoList = <Map>[].obs;
  Future<void> displayDatabase()
  async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    todoList.value = await databaseHelper.readDatabase();
  }

  void deleteData(int id)
  {
    DatabaseHelper databaseHelper = DatabaseHelper();
    databaseHelper.deletedDatabase(id: id);
    displayDatabase();
  }


}