import 'package:flutter/material.dart';
import 'package:todolistapp/screen/profile.dart';
import 'package:todolistapp/service/userservice.dart';
import 'package:todolistapp/service/user.dart';

class signupPage extends StatefulWidget {
  @override
  _signupPageState createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordagainController = TextEditingController();
  var emailController = TextEditingController();
  var ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("signup.jpg"),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
          color: Colors.deepPurple[50],
        ),
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              child: ListView(
                children: [
                  CircleAvatar(
                      radius: 50,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("avatar.jpg"),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        hintText: 'User Name',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      controller: ageController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        hintText: 'Age',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        hintText: 'Password',
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      controller: passwordagainController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        hintText: 'Confirm Password',
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    child: RaisedButton(
                      color: Colors.deepPurple,
                      onPressed: () {
                        if (passwordController.text ==
                            passwordagainController.text) {
                          Service.saveUser(
                            User(
                                userName: nameController.text,
                                password: passwordController.text,
                                email: emailController.text,
                                profileimage: "",
                                age: ageController.text),
                          ).then(
                            (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => profilePage()),
                            ),
                          );
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: new Text(
                                      "Passwords entered do not match!"),
                                  content: new Text("please enter again"),
                                );
                              });
                        }
                      },
                      child: Text('Sign Up',
                          style: TextStyle(
                            color: Colors.deepPurple[50],
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          )),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
