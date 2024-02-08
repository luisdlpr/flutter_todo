import 'package:flutter/material.dart';

class AddToDoButton extends StatelessWidget {
  final VoidCallback showToDoDialog;
  const AddToDoButton({super.key, required this.showToDoDialog});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: showToDoDialog,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
          backgroundColor: Theme.of(context).primaryColorLight,
          foregroundColor: Theme.of(context).hintColor,
        ),
        child: const Icon(Icons.add));
  }
}
