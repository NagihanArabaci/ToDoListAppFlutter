//import 'dart:html';

class Task {
  String taskName;
  bool isDone;
  int number;
  String categoryName;
  String date;

  Task(
      {required this.taskName,
      required this.isDone,
      required this.number,
      required this.categoryName,
      required this.date});

  Map<String, dynamic> toJson() {
    return {
      "taskName": this.taskName,
      "isDone": this.isDone,
      "number": this.number,
      "categoryName": this.categoryName,
      "date": this.date
    };
  }

  Task.fromJson(Map<String, dynamic> json)
      : taskName = json['taskName'],
        isDone = json['isDone'],
        number = json['number'],
        categoryName = json['categoryName'],
        date = json['date'];
}
