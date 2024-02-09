// Main To Do Page Widget Tests.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/data/to_do.dart';
import 'package:flutter_todo/data/to_do_database.dart';
import 'package:flutter_todo/to_do_page/add_to_do_button.dart';
import 'package:flutter_todo/to_do_page/add_to_do_dialog.dart';
import 'package:flutter_todo/to_do_page/app_bar.dart';
import 'package:flutter_todo/to_do_page/main.dart';
import 'package:flutter_todo/to_do_page/to_do_card.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'to_do_page_test.mocks.dart';

@GenerateMocks([ToDoDatabase])
void main() {
  group('Test all widgets appear for page', () {
    testWidgets(
        'Test widgets for page default state (ToDoAppBar, ToDoCard, AddToDoButton)',
        (WidgetTester tester) async {
      //
      ToDoDatabase mockDB = MockToDoDatabase();

      when(mockDB.toDoList).thenReturn([ToDo('test1', true)]);

      // pump widget with test controller and void function.
      await tester.pumpWidget(
        MaterialApp(
          home: TodoPage(db: mockDB),
        ),
      );

      // check for component rendering and sub-components
      expect(find.byKey(const Key('ToDoPage')), findsOneWidget);
      expect(find.byType(ToDoAppBar), findsOneWidget);
      expect(find.byType(ToDoCard), findsOneWidget);
      expect(find.byType(AddToDoButton), findsOneWidget);
    });

    testWidgets('Test showing NewToDoDialog', (WidgetTester tester) async {
      //
      ToDoDatabase mockDB = MockToDoDatabase();

      when(mockDB.toDoList).thenReturn([ToDo('test1', true)]);

      // pump widget with test controller and void function.
      await tester.pumpWidget(
        MaterialApp(
          home: TodoPage(db: mockDB),
        ),
      );

      // check for component rendering and sub-components
      expect(find.byType(NewTodoDialog), findsNothing);
      await tester.tap(find.byType(AddToDoButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(NewTodoDialog), findsOneWidget);
    });

    testWidgets('Test showing multiple cards', (WidgetTester tester) async {
      //
      ToDoDatabase mockDB = MockToDoDatabase();

      when(mockDB.toDoList).thenReturn(
        [
          ToDo('test1', true),
          ToDo('test2', false),
          ToDo('test3', false),
          ToDo('test4', true),
        ],
      );

      // pump widget with test controller and void function.
      await tester.pumpWidget(
        MaterialApp(
          home: TodoPage(db: mockDB),
        ),
      );

      // check for component rendering and sub-components
      expect(find.byKey(const Key('0')), findsOneWidget);
      expect(find.byKey(const Key('1')), findsOneWidget);
      expect(find.byKey(const Key('2')), findsOneWidget);
      expect(find.byKey(const Key('3')), findsOneWidget);
      expect(find.byKey(const Key('4')), findsNothing);
    });
  });
}
