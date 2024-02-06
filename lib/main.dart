import 'package:flutter/material.dart';
import 'package:flutter_todo/ToDo.dart';
import 'package:flutter_todo/TodoPage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  var _db = await Hive.openBox('tddb');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do',
      home: TodoPage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        fontFamily: 'RobotoMono',
      ),
    );
  }
}
