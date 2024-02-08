import 'package:flutter/material.dart';

class ToDoCard extends StatelessWidget {
  final String action;
  final bool completion;
  final int index;
  final Color? cardColor;
  final void Function(bool, int) toggleCompletion;
  final void Function(int) deleteToDo;

  const ToDoCard({
    super.key,
    required this.index,
    required this.completion,
    required this.toggleCompletion,
    required this.action,
    required this.deleteToDo,
    this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Checkbox(
              value: completion,
              onChanged: (v) {
                toggleCompletion(v!, index);
              },
            ),
            Text(
              action,
              style: TextStyle(
                  decoration: (completion)
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            IconButton(
                onPressed: () {
                  deleteToDo(index);
                },
                icon: const Icon(Icons.delete)),
          ]),
        ),
      ),
    );
  }
}
