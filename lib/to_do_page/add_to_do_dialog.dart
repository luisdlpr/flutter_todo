import 'package:flutter/material.dart';

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
            const Spacer(),
            const Flexible(
              child: Text(
                'Note down your next task!',
              ),
            ),
            const Spacer(),
            Flexible(
              flex: 10,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const Spacer(),
            MaterialButton(
              onPressed: createToDo,
              color: Theme.of(context).primaryColorLight,
              minWidth: double.infinity,
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
