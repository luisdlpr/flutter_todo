// To Do List Card Tests.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/data/to_do.dart';
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

  group('test checkbox functionality for ToDoCard', () {
    testWidgets(
        'Test completion checkbox interacts correctly with mock function',
        (WidgetTester tester) async {
      // mock environment
      List<ToDo> mockTodoList = [
        ToDo('test', false),
        ToDo('test2', true),
      ];
      mockToggleCompletion(bool newStatus, int index) {
        mockTodoList[index].completion = newStatus;
      }

      // create widget
      await tester.pumpWidget(
        MaterialApp(
          home: ToDoCard(
            index: 1,
            completion: mockTodoList[1].completion,
            toggleCompletion: mockToggleCompletion,
            action: mockTodoList[1].action,
            deleteToDo: (int index) {},
          ),
        ),
      );

      // test initial condition
      expect(mockTodoList[0].completion, false);
      expect(mockTodoList[1].completion, true);

      // click checkbox
      await tester.tap(find.byType(Checkbox));

      // test completion status has changed
      expect(mockTodoList[0].completion, false);
      expect(mockTodoList[1].completion, false);
    });
  });

  group('test text decoration functionality for ToDoCard', () {
    testWidgets('Test completion correctly reflects in textdecoration',
        (WidgetTester tester) async {
      // mock environment
      List<ToDo> mockTodoList = [
        ToDo('test', false),
        ToDo('test2', true),
      ];

      // create widget
      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: [
              ToDoCard(
                index: 0,
                completion: mockTodoList[0].completion,
                toggleCompletion: (bool completion, int index) {},
                action: mockTodoList[0].action,
                deleteToDo: (int index) {},
              ),
              ToDoCard(
                index: 1,
                completion: mockTodoList[1].completion,
                toggleCompletion: (bool completion, int index) {},
                action: mockTodoList[1].action,
                deleteToDo: (int index) {},
              ),
            ],
          ),
        ),
      );

      // test strikethrough is applied to completion
      expect(mockTodoList[1].completion, true);
      final Text widget = tester.firstWidget(find.text('test2'));
      expect(widget.style?.decoration, TextDecoration.lineThrough);

      expect(mockTodoList[0].completion, false);
      final Text widget2 = tester.firstWidget(find.text('test'));
      expect(widget2.style?.decoration, TextDecoration.none);
    });
  });

  group('test delete functionality for ToDoCard', () {
    testWidgets('Test delete button interacts correctly with mock function',
        (WidgetTester tester) async {
      // mock environment
      List<ToDo> mockTodoList = [
        ToDo('test', false),
        ToDo('test2', true),
      ];
      mockDeleteToDo(int index) {
        mockTodoList.removeAt(index);
      }

      // create widget
      await tester.pumpWidget(
        MaterialApp(
          home: ToDoCard(
            index: 1,
            completion: mockTodoList[1].completion,
            toggleCompletion: (bool completion, int index) {},
            action: mockTodoList[1].action,
            deleteToDo: mockDeleteToDo,
          ),
        ),
      );

      // test initial condition
      expect(mockTodoList.length, 2);

      // click checkbox
      await tester.tap(find.byType(IconButton));

      // test completion status has changed
      expect(mockTodoList.length, 1);
      expect(mockTodoList[0].action, 'test');
      expect(mockTodoList[0].completion, false);
    });
  });
}
