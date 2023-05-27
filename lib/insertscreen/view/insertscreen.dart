import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_2486/home/controller/homecontroller.dart';

import '../../utils/databasehelper.dart';

class Insertscreen extends StatefulWidget {
  const Insertscreen({Key? key}) : super(key: key);

  @override
  State<Insertscreen> createState() => _InsertscreenState();
}

class _InsertscreenState extends State<Insertscreen> {
  Homecontroller homecontroller = Get.put(Homecontroller());
  TextEditingController txtTask = TextEditingController();
  TextEditingController txtdesc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('To-Do'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Add To-Do',
                    style: TextStyle(fontSize: 15),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          //add screen
                          DatabaseHelper databaseHelper = DatabaseHelper();
                          String task = txtTask.text;
                          String desc = txtdesc.text;
                          String date = homecontroller.date.value;
                          int priority = homecontroller.priority.value;
                          databaseHelper.insertDatabase(
                              task: task, desc: desc, date: date, priority: priority);
                          homecontroller.displayDatabase();
                          Get.back();
                        },
                        child: Icon(Icons.add)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          // reset data
                          setState(() {
                            homecontroller.date.value = '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
                            homecontroller.priority.value = 0;
                            txtTask.clear();
                            txtdesc.clear();
                          });
                        },
                        child: Icon(Icons.refresh)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ToggleButtons(children: [
                Text('Low'),
                Text('Medium'),
                Text('High'),
                Text('Urgent'),
              ], isSelected: homecontroller.toggleBool,
                onPressed: (index) {
              homecontroller.priority.value = index;
                },
                color: Colors.green,
              ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: txtTask,
                decoration: InputDecoration(
                  label: Text('Task'),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.5)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: txtdesc,
                decoration: InputDecoration(
                  label: Text('Description'),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.5)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Pick date'),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2030));
                        homecontroller.date.value =
                            '${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}';
                      },
                      child: Icon(Icons.calendar_month)),
                  Spacer(),
                  Obx(() => Text('${homecontroller.date.value}')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
