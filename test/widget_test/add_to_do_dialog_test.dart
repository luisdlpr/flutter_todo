// To Do Dialog Box Widget Test.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/data/to_do.dart';
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

  group('test text field', () {
    testWidgets('test changes reflect in given controller',
        (WidgetTester tester) async {
      // mock environment
      TextEditingController testController = TextEditingController();
      List<ToDo> mockToDoList = [];
      mockCreateToDo() {
        mockToDoList.add(ToDo(testController.text, false));
      }

      // generate test environment for tododialog
      await tester.pumpWidget(
        MaterialApp(
          home: NewTodoDialog(
            createToDo: mockCreateToDo,
            controller: testController,
          ),
        ),
      );

      // check inital texteditingcontroller state.
      expect(testController.text, '');
      // check input to textfield updates given controller.
      await tester.enterText(find.byType(TextField), 'new task todo');
      expect(testController.text, 'new task todo');

      // call create to do manually (test save button seperately).
      mockCreateToDo();
      // check mockToDoList is as expected.
      expect(mockToDoList.length, 1);
      expect(mockToDoList[0].action, 'new task todo');
      expect(mockToDoList[0].completion, false);
    });
  });

  group('test save button', () {
    testWidgets('test save button calls given function with controller',
        (WidgetTester tester) async {
      // mock environment
      TextEditingController testController = TextEditingController();
      List<ToDo> mockToDoList = [];
      mockCreateToDo() {
        mockToDoList.add(ToDo(testController.text, false));
      }

      // generate test environment for tododialog
      await tester.pumpWidget(
        MaterialApp(
          home: NewTodoDialog(
            createToDo: mockCreateToDo,
            controller: testController,
          ),
        ),
      );

      // manually change controller state (test textfield seperately).
      expect(testController.text, '');
      testController.text = 'new task todo';
      expect(testController.text, 'new task todo');

      // click the save button
      await tester.tap(find.widgetWithText(MaterialButton, 'Save'));

      // check mockToDoList is as expected.
      expect(mockToDoList.length, 1);
      expect(mockToDoList[0].action, 'new task todo');
      expect(mockToDoList[0].completion, false);
    });
  });
}
