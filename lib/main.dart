import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_2486/home/controller/homecontroller.dart';
import 'package:todo_2486/home/view/homescreen.dart';
import 'package:todo_2486/insertscreen/view/insertscreen.dart';
void main()
{
  Homecontroller homecontroller = Get.put(Homecontroller());
  runApp(
    Obx(
      () =>  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: homecontroller.isDark.isFalse?ThemeData.dark():ThemeData.light(),
        getPages: [
          GetPage(name: '/', page: () => Homescreen(),),
          GetPage(name: '/insert', page: () => Insertscreen(),),
        ],
      ),
    ),
  );
}