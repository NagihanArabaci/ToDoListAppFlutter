import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/screen/profile.dart';
import 'package:todolistapp/service/tolistservice.dart';
import 'package:todolistapp/service/task.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:todolistapp/service/userservice.dart';

import 'add_task.dart';

class todolistPage extends StatefulWidget {
  @override
  _todolistPageState createState() => _todolistPageState();
}

class _todolistPageState extends State<todolistPage> {
  var textController = TextEditingController();
  List<Task> taskList = [];
  List<TabItem> tabItemList = [];
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < Servicelist.categoryList.length; i++) {
      tabItemList.add(TabItem(
          icon: Servicelist.categoryIconList[i],
          title: Servicelist.categoryList[i]));
    }

    refreshToList(tabItemList[0].title!);
  }

  refreshToList(String category) {
    Servicelist.getTaskList().then((list) {
      setState(() {
        taskList =
            list.where((element) => element.categoryName == category).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => profilePage()));
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.deepPurple,
            size: 30,
          ),
        ),
        title: Text(
          'Todo List ',
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.purple[800],
              size: 40,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTaskPage()));
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("todolist.jpg"),
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
          fit: BoxFit.cover,
        )),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(taskList[index].taskName),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(taskList[index].categoryName),
                          Text(taskList[index].date),
                        ],
                      ),
                      trailing: Checkbox(
                        value: taskList[index].isDone,
                        onChanged: (bool) {
                          setState(() {
                            taskList[index].isDone = !taskList[index].isDone;
                            Servicelist.upDateTaskList(taskList[index]).then(
                                (value) => refreshToList(
                                    tabItemList[selectedPage].title!));
                          });
                          print("onchange");
                        },
                      ),
                      leading: TextButton(
                        child: Icon(Icons.delete),
                        onPressed: () {
                          Servicelist.deleteTaskList(taskList[index]).then(
                              (value) => refreshToList(
                                  tabItemList[selectedPage].title!));
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
          items: tabItemList,
          initialActiveIndex: selectedPage,
          backgroundColor: Colors.deepPurple,
          activeColor: Colors.purpleAccent,
          onTap: (int index) {
            setState(() {
              refreshToList(tabItemList[index].title!);
              selectedPage = index;
            });
          }),
    );
  }
}

class widget {}
