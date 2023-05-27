import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_2486/home/controller/homecontroller.dart';
import 'package:todo_2486/utils/databasehelper.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Homecontroller homecontroller = Get.put(Homecontroller());

  @override
  void initState() {
    // TODO: implement initState
    DatabaseHelper databaseHelper = DatabaseHelper();
    databaseHelper.checkDatabase();
    databaseHelper.createDatabase();
    homecontroller.displayDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.toNamed('/insert');

              },
              child: Icon(Icons.add),
            ),
            appBar: AppBar(
              title: Text('TO-Do'),
              actions: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        homecontroller.isDark.value =
                        !homecontroller.isDark.value;
                      },
                      child: Icon(
                        Icons.nightlight_outlined,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      homecontroller.isGrid.value = !homecontroller.isGrid.value;
                    },
                    child: Obx(
                      () =>  Icon(
                        homecontroller.isGrid.isTrue?Icons.grid_view_outlined:Icons.list,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: homecontroller.isGrid.isTrue?GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2),itemBuilder: (context, index) => InkWell(
              onDoubleTap: () {
                homecontroller.deleteData(
                  homecontroller.todoList[index]['id'],
                );
              },
                    child: todoGrid(
              homecontroller.todoList[index]['task'],
              homecontroller.todoList[index]['desc'],
              homecontroller.todoList[index]['date'],
              homecontroller.todoList[index]['priority'],
            ),
                  ),itemCount: homecontroller.todoList.length,):ListView.builder(
              itemBuilder: (context, index) => InkWell(
                onDoubleTap: () {
                  homecontroller.deleteData(
                    homecontroller.todoList[index]['id'],
                  );
                },
                child: todoBox(
                  homecontroller.todoList[index]['task'],
                  homecontroller.todoList[index]['desc'],
                  homecontroller.todoList[index]['date'],
                  homecontroller.todoList[index]['priority'],
                ),
              ),
              itemCount: homecontroller.todoList.length,
            ),

        ),
      ),
    );
  }
  
  Widget todoGrid(String task, String desc, String date, int priority)
  {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: priority == 0
              ? Colors.yellow
              : priority == 1
              ? Colors.blue
              : priority == 2
              ? Colors.orange
              : Colors.red,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          priority == 0
              ? priorityBox('Low')
              : priority == 1
              ? priorityBox('Medium')
              : priority == 2
              ? priorityBox('High')
              : priorityBox('Urgent'),
          Text('$task',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18)),
          Text('$desc', style: TextStyle(color: Colors.black,fontSize: 12)),
          Text('$date', style: TextStyle(color: Colors.black,fontSize: 12)),
        ],
      ),
    );
  }

  Widget todoBox(String task, String desc, String date, int priority) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: priority == 0
            ? Colors.yellow
            : priority == 1
            ? Colors.blue
            : priority == 2
            ? Colors.orange
            : Colors.red,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('$task',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20)),
              Text('$desc', style: TextStyle(color: Colors.black)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              priority == 0
                  ? priorityBox('Low')
                  : priority == 1
                  ? priorityBox('Medium')
                  : priority == 2
                  ? priorityBox('High')
                  : priorityBox('Urgent'),
              Text('$date', style: TextStyle(color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }

  Widget priorityBox(String info) {
    return Container(
      height: 30,
      width: 90,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(150)
      ),
      alignment: Alignment.center,
      child: Text('$info', style: TextStyle(color: Colors.black, fontSize: 10)),
    );
  }

}
