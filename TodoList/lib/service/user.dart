import 'dart:io';

class User {
  String userName;
  String password;
  String email;
  String profileimage;
  String age;

  User(
      {required this.userName,
      required this.password,
      required this.email,
      required this.profileimage,
      required this.age});

  Map<String, dynamic> toJson() {
    return {
      "userName": this.userName,
      "password": this.password,
      "email": this.email,
      "profileimage": this.profileimage,
      "age": this.age
    };
  }

  User.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        password = json['password'],
        email = json['email'],
        age = json['age'],
        profileimage = json['profileimage'] ?? "";
}
