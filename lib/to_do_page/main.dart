import "package:flutter/material.dart";
import 'package:flutter_todo/to_do_page/add_to_do_dialog.dart';
import "package:flutter_todo/data.dart";
import "package:flutter_todo/to_do_page/add_to_do_button.dart";
import "package:flutter_todo/to_do_page/app_bar.dart";
import "package:flutter_todo/to_do_page/to_do_card.dart";

class TodoPage extends StatefulWidget {
  final ToDoDatabase db;
  const TodoPage({super.key, required this.db});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late ToDoDatabase db;
  TextEditingController newTodoTextController = TextEditingController();

  @override
  void initState() {
    db = widget.db;
    db.loadData();
    super.initState();
  }

  void createToDo() {
    setState(() {
      db.addToDo(newTodoTextController.text, false);
      Navigator.pop(context);
      newTodoTextController.clear();
    });
  }

  void toggleToDoCompletion(bool val, int index) {
    setState(() {
      db.toggleToDoCompletion(val, index);
    });
  }

  void deleteToDo(int index) {
    setState(() {
      db.deleteToDo(index);
    });
  }

  void reorderToDo(int oldIndex, int newIndex) {
    setState(() {
      db.reorderToDo(oldIndex, newIndex);
    });
  }

  void showToDoDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return NewTodoDialog(
            createToDo: createToDo,
            controller: newTodoTextController,
          );
        }).then((val) {
      newTodoTextController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('ToDoPage'),
      appBar: ToDoAppBar(
          key: const Key('ToDoAppBar'),
          backgroundColor: Theme.of(context).primaryColorLight),
      body: ReorderableListView.builder(
        itemBuilder: (context, index) {
          return ToDoCard(
            key: Key('$index'),
            index: index,
            completion: db.toDoList[index].completion,
            toggleCompletion: toggleToDoCompletion,
            action: db.toDoList[index].action,
            deleteToDo: deleteToDo,
          );
        },
        itemCount: db.toDoList.length,
        onReorder: reorderToDo,
      ),
      floatingActionButton: AddToDoButton(
        showToDoDialog: showToDoDialog,
      ),
    );
  }
}
