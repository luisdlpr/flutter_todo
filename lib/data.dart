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
      toDoList = _db.get('session$session');
    }
  }

  void saveData() {
    _db.put('session$session', toDoList);
  }
}

class ToDo {
  String action = '';
  bool completion = false;

  ToDo(this.action, this.completion);
}
