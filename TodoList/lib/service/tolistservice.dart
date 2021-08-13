import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolistapp/service/task.dart';

class Servicelist {
  static List<String> categoryList = [
    "School",
    "Habbits",
    "Book",
    "Movies",
    "Workout"
  ];

  static List<Icon> categoryIconList = [
    Icon(Icons.school, color: Colors.white),
    Icon(Icons.auto_fix_high, color: Colors.white),
    Icon(Icons.book, color: Colors.white),
    Icon(Icons.movie, color: Colors.white),
    Icon(Icons.sports, color: Colors.white)
  ];

  static String toJsonList(List<Task> list) {
    String json = jsonEncode(list);
    return json;
  }

  static List<Task> toTaskList(String json) {
    Iterable l = jsonDecode(json);
    List<Task> list = List<Task>.from(l.map((model) => Task.fromJson(model)));

    return list;
  }

  static Future<List<Task>> getTaskList() async {
    List<Task> list = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String taskListJson = (prefs.getString('TaskList') ?? "");
    if (taskListJson != "") {
      list = toTaskList(taskListJson);
    } else {
      list.add(Task(
          taskName: "İlk görev",
          isDone: false,
          number: 1,
          categoryName: "",
          date: " "));
      var json = toJsonList(list);
      prefs.setString('TaskList', json);
    }

    // list = list.where((element) => element.categoryName == Category).toList();
    list.sort((a, b) => a.number.compareTo(b.number));
    return list;
  }

  static Future<void> addTaskList(Task task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String taskListJson = (prefs.getString('TaskList') ?? "");
    List<Task> list = toTaskList(taskListJson);
    list.add(task);
    String json = toJsonList(list);
    prefs.setString('TaskList', json);
  }

  static Future<void> upDateTaskList(Task task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String taskListJson = (prefs.getString('TaskList') ?? "");
    List<Task> list = toTaskList(taskListJson);
    Task update =
        list.where((element) => element.taskName == task.taskName).first;

    list.remove(update);
    list.add(task);
    String json = toJsonList(list);
    prefs.setString('TaskList', json);
  }

  static Future<void> deleteTaskList(Task task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String taskListJson = (prefs.getString('TaskList') ?? "");
    List<Task> list = toTaskList(taskListJson);
    Task delete =
        list.where((element) => element.taskName == task.taskName).first;

    list.remove(delete);

    String json = toJsonList(list);
    prefs.setString('TaskList', json);
  }

  static Future<int> getMaxNumberTaskList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String taskListJson = (prefs.getString('TaskList') ?? "");
    List<Task> list = toTaskList(taskListJson);

    list.sort((a, b) => a.number.compareTo(b.number));
    Task task = list.last;

    String json = toJsonList(list);
    prefs.setString('TaskList', json);
    return task.number + 1;
  }
}
