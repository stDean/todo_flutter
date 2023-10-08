import 'package:hive_flutter/hive_flutter.dart';

class TodoDB {
  List todoList = [];
  // reference the hive box
  final _myBox = Hive.box('myBox');

  // run this if this is app's first initialization
  void createInitialData() {
    todoList = [
      ['Make Tutorials', false],
      ['Get Something To Eat', false],
    ];
  }

  // load data from DB
  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  // update DB
  void updateDB() {
    _myBox.put("TODOLIST", todoList);
  }
}
