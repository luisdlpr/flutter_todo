// To Do List Card Tests.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/to_do_page/to_do_card.dart';

Widget initWidget() {
  return MaterialApp(
    home: ToDoCard(
      index: 1,
      completion: true,
      toggleCompletion: (bool newStatus, int index) {},
      action: 'test to do',
      deleteToDo: (int index) {},
    ),
  );
}

void main() {
  group('Test all components appear for To Do Card Widget', () {
    testWidgets('Test Checkbox (completion status) renders',
        (WidgetTester tester) async {
      // pump widget with test controller and void function.
      await tester.pumpWidget(initWidget());

      // check for component rendering and sub-components
      expect(find.byKey(const Key('TDCompletionStatus1')), findsOneWidget);
    });

    testWidgets('Test Action description renders', (WidgetTester tester) async {
      // pump widget with test controller and void function.
      await tester.pumpWidget(initWidget());

      // check for component rendering and sub-components
      expect(find.text('test to do'), findsOneWidget);
    });

    testWidgets('Test delete button renders', (WidgetTester tester) async {
      // pump widget with test controller and void function.
      await tester.pumpWidget(initWidget());

      // check for component rendering and sub-components
      expect(find.byKey(const Key('TDDeleteButton1')), findsOneWidget);
    });
  });
}
