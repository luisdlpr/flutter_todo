import 'package:flutter_todo/ToDo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  int session = 1;
  List<ToDo> toDoList = [];

  final _db = Hive.box('tddb');

  void createInitialData() {
    toDoList = [];
  }

  void loadData() {
    if (_db.get('session$session') == null) {
      createInitialData();
    } else {
      toDoList = List<ToDo>.from(_db.get('session$session'));
    }
  }

  void saveData() {
    _db.put('session$session', toDoList);
  }
}
