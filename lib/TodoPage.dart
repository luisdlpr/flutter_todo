import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter_todo/ToDo.dart";
import "package:flutter_todo/data.dart";
import "package:hive/hive.dart";

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _db = Hive.box('tddb');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    db.loadData();
    super.initState();
  }

  void createToDo() {
    setState(() {
      db.toDoList.add(ToDo('test', false));
      db.saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do'),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: ReorderableListView.builder(
        itemBuilder: (context, index) {
          return Card(
            key: Key('$index'),
            color: Theme.of(context).cardColor,
            child: SizedBox(
              height: 80,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                        value: db.toDoList[index].completion,
                        onChanged: (val) {
                          setState(() {
                            db.toDoList[index].completion = val!;
                            db.saveData();
                          });
                        }),
                    Text(
                      db.toDoList[index].action,
                      style: TextStyle(
                          decoration: (db.toDoList[index].completion)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            db.toDoList.removeAt(index);
                            db.saveData();
                          });
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: db.toDoList.length,
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final ToDo item = db.toDoList.removeAt(oldIndex);
            db.toDoList.insert(newIndex, item);
          });
        },
      ),
      // body: Padding(
      // padding: EdgeInsets.only(top: 10.0), child: ReorderableList()),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          createToDo();
        },
        child: Icon(Icons.add),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
          backgroundColor: Theme.of(context).primaryColorLight,
          foregroundColor: Theme.of(context).hintColor,
        ),
      ),
    );
  }
}

class ReorderableList extends StatefulWidget {
  const ReorderableList({super.key});

  @override
  State<ReorderableList> createState() => _ReorderableListState();
}

class _ReorderableListState extends State<ReorderableList> {
  final List<String> _items = ["String 1", "String 2"];
  @override
  Widget build(BuildContext context) {
    final List<Card> cards = <Card>[
      for (int i = 0; i < _items.length; i++)
        Card(
          key: Key('$i'),
          color: Theme.of(context).cardColor,
          child: SizedBox(
            height: 80,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text('${_items[i]}'),
                ],
              ),
            ),
          ),
        )
    ];

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(1, 6, animValue)!;
          final double scale = lerpDouble(1, 1.02, animValue)!;
          return Transform.scale(
            scale: scale,
            // Create a Card based on the color and the content of the dragged one
            // and set its elevation to the animated value.
            child: Card(
              elevation: elevation,
              color: cards[index].color,
              child: cards[index].child,
            ),
          );
        },
        child: child,
      );
    }

    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      proxyDecorator: proxyDecorator,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final String item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
      children: cards,
    );
  }
}
