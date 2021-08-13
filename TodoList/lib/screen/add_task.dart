import 'package:flutter/material.dart';
import 'package:todolistapp/screen/todolist.dart';
import 'package:todolistapp/service/tolistservice.dart';
import 'package:todolistapp/service/task.dart';
import 'package:todolistapp/service/userservice.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  List<DropdownMenuItem<String>>? items = [];
  String _currentCategory = "School";

  var textController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  String tarih = "";

  @override
  void initState() {
    super.initState();

    items = [];
    Servicelist.categoryList.forEach((element) {
      items!.add(DropdownMenuItem<String>(
          child: Text(element.toString()), value: element));
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('addlist.jpg'),
          colorFilter: ColorFilter.mode(
              Colors.purple.withOpacity(0.5), BlendMode.dstATop),
          fit: BoxFit.cover,
        )),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text('Add Task',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w800)),
            SizedBox(
              height: 35.0,
            ),
            Form(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      controller: textController,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          labelText: 'Task Name',
                          labelStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      height: 64,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.circular(10)),
                      child: OutlinedButton(
                        child: Container(
                            width: double.infinity,
                            height: 64,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tarih",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Icon(Icons.date_range_rounded),
                                ])),
                        onPressed: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2022));

                          var formatter = new DateFormat('dd-MM-yyyy');
                          tarih = formatter.format(date!);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DropdownButtonFormField(
                        value: _currentCategory,
                        icon: Icon(Icons.arrow_drop_down_circle),
                        iconSize: 22.0,
                        iconEnabledColor: Theme.of(context).primaryColor,
                        items: items,
                        decoration: InputDecoration(
                            hintText: 'Choose Category',
                            hintStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        onChanged: (dynamic newValue) {
                          setState(() {
                            _currentCategory = newValue;
                          });
                        }),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 60.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: TextButton(
                      child: Text(
                        'Add',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        Servicelist.getMaxNumberTaskList().then((maxnumber) {
                          Servicelist.addTaskList(Task(
                                  taskName: textController.text,
                                  isDone: false,
                                  number: maxnumber,
                                  categoryName: _currentCategory,
                                  date: tarih))
                              .then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => todolistPage()),
                            );
                          });
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
