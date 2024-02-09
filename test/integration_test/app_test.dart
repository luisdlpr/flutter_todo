import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/data/to_do.dart';
import 'package:flutter_todo/main.dart';
import 'package:flutter_todo/to_do_page/add_to_do_button.dart';
import 'package:flutter_todo/to_do_page/add_to_do_dialog.dart';
import 'package:flutter_todo/to_do_page/to_do_card.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (tester) async {
      // mock box.
      Box<List<ToDo>> mockBox = MockBox();

      // mock data saved in hive box
      when(mockBox.get('session1')).thenAnswer(
          (_) => [ToDo('test task 1', false), ToDo('test task 2', false)]);

      // pump app
      await tester.pumpWidget(MyApp(box: mockBox));

      // check cards are created for each todo
      expect(find.byType(ToDoCard), findsExactly(2));

      // toggle completion of test task 1
      await tester.tap(find.byKey(const Key('TDCompletionStatus0')));
      await tester.pumpAndSettle();

      // test completion status
      Checkbox completionStatusTaskOne = tester.firstWidget(
        find.byKey(
          const Key('TDCompletionStatus0'),
        ),
      );
      Checkbox completionStatusTaskTwo = tester.firstWidget(
        find.byKey(
          const Key('TDCompletionStatus1'),
        ),
      );
      expect(completionStatusTaskOne.value, true);
      expect(completionStatusTaskTwo.value, false);

      // test drag to reorder
      final Offset firstTaskPos = tester.getCenter(find.text('test task 1'));

      // gesture for reordering involves hold then drag
      final TestGesture drag = await tester.startGesture(firstTaskPos);
      await tester.pumpAndSettle(Duration(seconds: 2));
      await drag.moveBy(const Offset(0, 200));
      await tester.pumpAndSettle(Duration(seconds: 2));
      await drag.up();
      await tester.pumpAndSettle();

      // check widgets have swapped indexes
      completionStatusTaskOne = tester.firstWidget(
        find.byKey(
          const Key('TDCompletionStatus0'),
        ),
      );
      completionStatusTaskTwo = tester.firstWidget(
        find.byKey(
          const Key('TDCompletionStatus1'),
        ),
      );
      expect(completionStatusTaskOne.value, false);
      expect(completionStatusTaskTwo.value, true);

      // test deleting first to do
      await tester.tap(find.byKey(const Key('TDDeleteButton0')));
      await tester.pumpAndSettle();
      completionStatusTaskOne =
          tester.firstWidget(find.byKey(Key('TDCompletionStatus0')));
      expect(find.byType(ToDoCard), findsOneWidget);
      expect(find.text('test task 1'), findsOneWidget);
      expect(completionStatusTaskOne.value, true);

      // test adding to do
      await tester.tap(find.byType(AddToDoButton));
      await tester.pumpAndSettle();
      expect(find.byType(NewTodoDialog), findsOneWidget);
      await tester.enterText(
          find.byKey(Key('addToDoTextField')), 'test task 3');
      await tester.tap(find.widgetWithText(MaterialButton, 'Save'));
      await tester.pumpAndSettle();
      expect(find.text('test task 3'), findsOneWidget);
      expect(find.byType(ToDoCard), findsExactly(2));

      // test cancelling to do does not save text
      await tester.tap(find.byType(AddToDoButton));
      await tester.pumpAndSettle();
      expect(find.byType(NewTodoDialog), findsOneWidget);
      await tester.enterText(
          find.byKey(Key('addToDoTextField')), 'test task 4');
      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();
      expect(find.text('test task 4'), findsNothing);
      expect(find.byType(ToDoCard), findsExactly(2));
      await tester.tap(find.byType(AddToDoButton));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(MaterialButton, 'Save'));
      await tester.pumpAndSettle();
      expect(find.text('test task 4'), findsNothing);
      expect(find.byType(ToDoCard), findsExactly(3));
    });
  });
}
