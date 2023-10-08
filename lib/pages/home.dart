import "package:flutter/material.dart";
import 'package:hive_flutter/hive_flutter.dart';
import "package:todo_app/data/database.dart";

import "/component/dialog_box.dart";
import "/component/todo_tile.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('myBox');

  // List db.todoList = [
  //   ['Make Tutorials', false],
  //   ['Get a job', false],
  // ];

  TodoDB db = TodoDB();

  final TextEditingController _myTextController = TextEditingController();

  @override
  void initState() {
    // if this is the first time opening app, create the default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exist data
      db.loadData();
    }

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _myTextController.dispose();
    super.dispose();
  }

  void checkBoxChange(bool? val, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDB();
  }

  void onSave() {
    setState(() {
      db.todoList.add([_myTextController.text, false]);
      _myTextController.clear();
    });

    db.updateDB();
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _myTextController,
          onSave: onSave,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void handleDeleteTask(int index) {
    setState(() {
      db.todoList.remove(db.todoList[index]);
    });
    db.updateDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("To Do".toUpperCase()),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChange: (value) => checkBoxChange(value, index),
            deleteTask: (context) => handleDeleteTask(index),
          );
        },
      ),
    );
  }
}
