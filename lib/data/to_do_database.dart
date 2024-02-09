import 'package:flutter_todo/data/to_do.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  int session = 1;
  List<ToDo> toDoList = [];

  final Box<dynamic> db;

  ToDoDatabase({required this.db});

  void createInitialData() {
    toDoList = [];
  }

  void loadData() {
    if (db.get('session$session') == null) {
      createInitialData();
    } else {
      toDoList = List<ToDo>.from(db.get('session$session'));
    }
  }

  void saveData() {
    db.put('session$session', toDoList);
  }

  void addToDo(String value, bool completion) {
    toDoList.add(ToDo(value, completion));
    saveData();
  }

  void toggleToDoCompletion(bool val, int index) {
    toDoList[index].completion = val;
    saveData();
  }

  void deleteToDo(int index) {
    toDoList.removeAt(index);
    saveData();
  }

  void reorderToDo(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex--;
    final ToDo item = toDoList.removeAt(oldIndex);
    toDoList.insert(newIndex, item);
    saveData();
  }
}
