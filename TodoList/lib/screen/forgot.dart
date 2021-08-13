import 'package:flutter/material.dart';

class forgotPage extends StatefulWidget {
  @override
  _forgotPageState createState() => _forgotPageState();
}

class _forgotPageState extends State<forgotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Forgot Password Page'),
        ),
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("forgot.jpg"),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.dstATop),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
                child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      hintText: "emailaddres"),
                ),
                TextButton(
                  onPressed: () {
                    //sendcode
                  },
                  child: Text(
                    'Send email code',
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ],
            )),
          ),
        ));
  }
}
