// To Do Dialog Box Widget Test.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/to_do_page/add_to_do_dialog.dart';

Widget initWidget() {
  // generate test controller
  TextEditingController testController = TextEditingController();

  return MaterialApp(
    home: NewTodoDialog(createToDo: () {}, controller: testController),
  );
}

void main() {
  group('Test all components appear for Add To Do Dialog Box', () {
    testWidgets('Test title renders', (WidgetTester tester) async {
      // pump widget with test controller and void function.
      await tester.pumpWidget(initWidget());

      // check it renders and displays a title.
      expect(find.text('Note down your next task!'), findsOneWidget);
    });

    testWidgets('Test save button renders', (WidgetTester tester) async {
      // pump widget with test controller and void function.
      await tester.pumpWidget(initWidget());

      // check for save button.
      expect(find.widgetWithText(MaterialButton, 'Save'), findsOneWidget);
    });

    testWidgets('Test text field renders', (WidgetTester tester) async {
      // pump widget with test controller and void function.
      await tester.pumpWidget(initWidget());

      // check for text input field.
      expect(find.byKey(const Key('addToDoTextField')), findsOneWidget);
    });
  });
}
