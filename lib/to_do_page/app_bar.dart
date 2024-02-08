import 'package:flutter/material.dart';

class ToDoAppBar extends AppBar {
  final Color backgroundColor;
  ToDoAppBar({super.key, required this.backgroundColor})
      : super(
          title: const Text('To Do'),
          backgroundColor: backgroundColor,
        );
}
