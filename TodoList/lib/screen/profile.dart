import 'dart:io' as io;
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todolistapp/screen/todolist.dart';
import 'package:todolistapp/service/task.dart';
import 'package:todolistapp/service/userservice.dart';
import 'package:todolistapp/service/tolistservice.dart';
import 'package:todolistapp/service/user.dart';

class profilePage extends StatefulWidget {
  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  User? user = new User(
    userName: "userName",
    password: "password",
    email: "email",
    profileimage: "",
    age: "age",
  );
  List<Task> bitenler = [];
  List<Task> bitmeyenler = [];
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getUserFromService();
    getTaskListFromService();
  }

  getUserFromService() {
    Service.getUser().then((userFromService) {
      setState(() {
        user = userFromService;
      });
    });
  }

  getTaskListFromService() {
    Servicelist.getTaskList().then((value) {
      bitenler = value.where((element) => element.isDone == true).toList();
      bitmeyenler = value.where((element) => element.isDone == false).toList();
      setState(() {});
    });
  }

  getProfileImage() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    user!.profileimage = pickedFile!.path;
    await Service.saveUser(user);
    setState(() {});
    print(pickedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController()
      ..text = user?.email ?? "";
    TextEditingController ageController = TextEditingController()
      ..text = user?.age ?? "";
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile Page'),
        ),
        body: Column(
          children: [
            Container(
              height: 280,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.deepPurple.shade900,
                Colors.deepPurple.shade400,
                Colors.deepPurple.shade200,
              ])),
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  InkWell(
                    onTap: () {
                      getProfileImage();
                    },
                    child: user!.profileimage == ""
                        ? CircleAvatar(
                            radius: 70,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: AssetImage("avatar.jpg"),
                            ),
                          )
                        : CircleAvatar(
                            radius: 70,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage:
                                  FileImage(io.File(user!.profileimage)),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user?.userName ?? "",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans',
                            color: Colors.deepPurple[100]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.deepPurple[400]?.withOpacity(0.9),
                      height: 70.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Bitenler',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.deepPurple[50],
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Open Sans',
                              )),
                          Text(
                            bitenler.length.toString(),
                            style: TextStyle(
                                color: Colors.deepPurple[50],
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.deepPurple[800]?.withOpacity(0.8),
                    height: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Bitmeyenler',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.deepPurple[100],
                                fontSize: 24,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.bold)),
                        Text(
                          bitmeyenler.length.toString(),
                          style: TextStyle(
                            color: Colors.deepPurple[50],
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding:
                  EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      enabled: false,
                      labelText: "Mail",
                    ),
                  ),
                  TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      enabled: false,
                      labelText: 'Age',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.deepPurple,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => todolistPage()),
                        );
                      },
                      child: Text('Todo List',
                          style: TextStyle(
                            color: Colors.deepPurple[50],
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
