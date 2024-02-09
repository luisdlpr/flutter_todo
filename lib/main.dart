import 'package:flutter/material.dart';
import 'package:flutter_todo/data/to_do.dart';
import 'package:flutter_todo/data/to_do_database.dart';
import 'package:flutter_todo/to_do_page/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  Box box = await Hive.openBox('tddb');

  runApp(MyApp(box: box));
}

class MyApp extends StatelessWidget {
  final Box box;
  const MyApp({super.key, required this.box});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do',
      home: TodoPage(db: ToDoDatabase(db: box)),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        fontFamily: 'RobotoMono',
      ),
    );
  }
}
