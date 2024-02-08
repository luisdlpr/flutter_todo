// Top Bar Widget Test.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/to_do_page/app_bar.dart';

void main() {
  testWidgets('Test app bar element', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: ToDoAppBar(backgroundColor: Colors.teal),
      ),
    );

    expect(find.text('To Do'), findsOneWidget);
  });
}
