import 'package:flutter/material.dart';
import 'package:todotask/controller/helpertodo.dart';
import 'package:todotask/view/add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HelperTodo().db.then((value) => print("value =>>>>> $value"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: FutureBuilder(
        future: HelperTodo().getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length==0) {
              return Center(child: Text(
                "Hi No Data"
              ));
            }  else{
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.transparent,
                    child: ListTile(
                      onTap: () {},
                      title: Text("${snapshot.data[index].title}"),
                      subtitle: Text("${snapshot.data[index].date}"),
                      trailing: IconButton(
                        icon:Icon(
                            Icons.delete
                        ),
                        onPressed: () {
                          HelperTodo().deletedb(snapshot.data[index].id).then((value){
                            setState(() {
                              print(value);
                            });
                          });

                        },
                      ),
                    ),
                  );
                },
              );
            }

          }else{
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            );
          }
      },

      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
          return AddTask();
        }));
      },
        child: Icon(Icons.add),
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
