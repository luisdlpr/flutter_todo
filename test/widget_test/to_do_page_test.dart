// Main To Do Page Widget Tests.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/data.dart';
import 'package:flutter_todo/to_do_page/main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'to_do_page_test.mocks.dart';

@GenerateMocks([ToDoDatabase])
void main() {
  group('Test all components appear for To Do Card Widget', () {
    testWidgets('Test Checkbox (completion status) renders',
        (WidgetTester tester) async {
      //
      ToDoDatabase mockDB = MockToDoDatabase();

      when(mockDB.toDoList).thenReturn([]);

      // pump widget with test controller and void function.
      await tester.pumpWidget(
        MaterialApp(
          home: TodoPage(db: mockDB),
        ),
      );

      // check for component rendering and sub-components
      // expect(find.byKey(const Key('TDCompletionStatus1')), findsOneWidget);
    });
  });
}
