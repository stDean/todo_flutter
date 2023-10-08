import "package:flutter/material.dart";
import "/component/dialog_box.dart";
import "/component/todo_tile.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List todoList = [
    ['Make Tutorials', false],
    ['Get a job', false],
  ];

  final TextEditingController _myTextController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _myTextController.dispose();
    super.dispose();
  }

  void checkBoxChange(bool? val, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  void onSave() {
    
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
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: todoList[index][0],
            taskCompleted: todoList[index][1],
            onChange: (value) => checkBoxChange(value, index),
          );
        },
      ),
    );
  }
}
