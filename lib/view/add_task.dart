import 'package:flutter/material.dart';
import 'package:todotask/controller/helpertodo.dart';
import 'package:todotask/view/home_screen.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String? Title, description, datetime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: Padding(
        padding: EdgeInsets.all(0.8),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "title",
                hintText: "rntwea",
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: "data",
                hintText: "data",
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "title",
                hintText: "7777777",
              ),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  HelperTodo().insertdb({
                  'description':description,
                    'title':Title,
                    'date':datetime,
                    'done':"not done",
                  }).then((value){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                      return HomeScreen();
                    }));
                  });
                },
                icon: Icon(Icons.add),
                label: Text("add Task"))
          ],
        ),
      ),
    );
  }

  _AppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.red,
      toolbarHeight: 70,
      // leading: GestureDetector(
      //
      //   onTap: () {
      //     ThemeControler().SwitchTheme();
      //     notificationHelper.displayNotification(
      //         title: "Theme Chaing ",
      //         body: Get.isDarkMode
      //             ? "Activated Light Theme"
      //             : "Activated Dark Theme");
      //     notificationHelper.scheduledNotification();
      //   },
      //   child: Icon(Get.isDarkMode ? Icons.wb_sunny_rounded :
      //   Icons.nightlight_round,
      //     size: 25,
      //     color: Get.isDarkMode ? Colors.white : Colors.black,
      //   ),
      // ),
      actions: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
          child: CircleAvatar(
            radius: 30.0,
            // backgroundImage: AssetImage("images/profile.png"),
            backgroundColor: Colors.transparent,
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
