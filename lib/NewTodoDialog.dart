import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo/ToDo.dart';
import 'package:flutter_todo/data.dart';

class NewTodoDialog extends StatelessWidget {
  final VoidCallback createToDo;
  final TextEditingController controller;

  const NewTodoDialog(
      {super.key, required this.createToDo, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: FractionallySizedBox(
        heightFactor: 0.5,
        child: Column(
          children: [
            Spacer(),
            Flexible(
              child: Text(
                'Note down your next task!',
              ),
            ),
            Spacer(),
            Flexible(
              flex: 10,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Spacer(),
            MaterialButton(
                onPressed: createToDo,
                color: Theme.of(context).primaryColorLight,
                minWidth: double.infinity,
                child: Text('Save'))
          ],
        ),
      ),
    );
  }
}
