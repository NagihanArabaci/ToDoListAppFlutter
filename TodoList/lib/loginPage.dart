import 'package:flutter/material.dart';
import 'package:todolistapp/screen/forgot.dart';
import 'package:todolistapp/screen/profile.dart';
import 'package:todolistapp/screen/signup.dart';
import 'package:todolistapp/service/userservice.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Loginn();
  }

  Loginn() {
    Service.getUser().then((user) {
      if (user?.userName == nameController.text &&
          user?.password == passwordController.text) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => profilePage()),
        );
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("wrong password or username"),
                content: new Text("please enter again"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("login.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6), BlendMode.dstATop),
        )),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
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
                height: 20.0,
              ),
              Container(
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    hintText: "Password",
                    // labelText: 'Password',
                  ),
                  obscureText: true,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => forgotPage()),
                ),
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                height: 50,
                child: RaisedButton(
                  
                  color: Colors.deepPurple,

                  child: Text('Login',
                      style: TextStyle(
                        color: Colors.deepPurple[50],
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                  onPressed: Loginn,
                  //login screen
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text('Does not have account?'),
                    TextButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                        ),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => signupPage()),
                      ),
                    ),

                    //signup screen
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
