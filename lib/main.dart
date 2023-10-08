import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/pages/home.dart';

void main() async {
  // initialize Hive for local storage
  await Hive.initFlutter();

  var box = await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-Do App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: const HomePage(),
    );
  }
}
