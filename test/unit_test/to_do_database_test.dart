// ToDoDatabase Data Layer Unit Tests.
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/data/to_do.dart';
import 'package:flutter_todo/data/to_do_database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'to_do_database_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  group('test initial load function for ToDoDatabase (loadData)', () {
    test('test loadData with no data in box', () {
      // create mock hive box.
      final box = MockBox();

      // mock get response
      when(box.get('session1')).thenAnswer((_) => null);

      // init db with mock box
      final toDoDatabase = ToDoDatabase(db: box);

      // loading db should give a empty list
      toDoDatabase.loadData();

      expect(toDoDatabase.toDoList.length, 0);
    });

    test('test loadData with previous data in box', () {
      // create mock hive box.
      final box = MockBox();

      // mock get response
      when(box.get('session1'))
          .thenAnswer((_) => [ToDo('task1', false), ToDo('task2', true)]);

      // init db with mock box
      final toDoDatabase = ToDoDatabase(db: box);

      // loading db should give a empty list
      toDoDatabase.loadData();

      expect(toDoDatabase.toDoList.length, 2);
      expect(toDoDatabase.toDoList.runtimeType, List<ToDo>);
      expect(toDoDatabase.toDoList[0].action, 'task1');
      expect(toDoDatabase.toDoList[0].completion, false);
      expect(toDoDatabase.toDoList[1].action, 'task2');
      expect(toDoDatabase.toDoList[1].completion, true);
    });
  });

  group('test adding a new ToDo to the ToDoDatabase (addToDo)', () {
    test('test addToDo', () {
      // create mock hive box.
      final box = MockBox();

      // init db with mock box
      final toDoDatabase = ToDoDatabase(db: box);

      // check empty
      expect(toDoDatabase.toDoList.length, 0);

      // add to do and check it exists
      toDoDatabase.addToDo('test', false);

      expect(toDoDatabase.toDoList.length, 1);
      expect(toDoDatabase.toDoList[0].action, 'test');
      expect(toDoDatabase.toDoList[0].completion, false);
    });
  });

  group('test toggling completion status of todos (toggleToDoCompletion)', () {
    test('toggle a uncompleted todo to completed and the reverse', () {
      // create mock hive box.
      final box = MockBox();

      // mock get response
      when(box.get('session1'))
          .thenAnswer((_) => [ToDo('task1', false), ToDo('task2', true)]);

      // init db with mock box
      final toDoDatabase = ToDoDatabase(db: box);

      // loading db should give a single todo list
      toDoDatabase.loadData();

      // confirm initial completion states
      expect(toDoDatabase.toDoList.length, 2);
      expect(toDoDatabase.toDoList[0].completion, false);
      expect(toDoDatabase.toDoList[1].completion, true);

      // toggle first todo completion
      toDoDatabase.toggleToDoCompletion(true, 0);

      // confirm new state
      expect(toDoDatabase.toDoList.length, 2);
      expect(toDoDatabase.toDoList[0].completion, true);
      expect(toDoDatabase.toDoList[1].completion, true);

      // repeat toggle to same state and check for no change
      toDoDatabase.toggleToDoCompletion(true, 0);
      expect(toDoDatabase.toDoList.length, 2);
      expect(toDoDatabase.toDoList[0].completion, true);
      expect(toDoDatabase.toDoList[1].completion, true);

      // try toggle second todo to not-completed
      toDoDatabase.toggleToDoCompletion(false, 1);
      expect(toDoDatabase.toDoList.length, 2);
      expect(toDoDatabase.toDoList[0].completion, true);
      expect(toDoDatabase.toDoList[1].completion, false);
    });
  });

  group('test deleting a to do (deleteToDo)', () {
    test('test deleteToDo', () {
      // create mock hive box.
      final box = MockBox();

      // mock get response
      when(box.get('session1'))
          .thenAnswer((_) => [ToDo('task1', false), ToDo('task2', true)]);

      // init db with mock box
      final toDoDatabase = ToDoDatabase(db: box);

      // loading db should give a single todo list
      toDoDatabase.loadData();

      // check initial state
      expect(toDoDatabase.toDoList.length, 2);
      expect(toDoDatabase.toDoList[0].action, 'task1');
      expect(toDoDatabase.toDoList[0].completion, false);
      expect(toDoDatabase.toDoList[1].action, 'task2');
      expect(toDoDatabase.toDoList[1].completion, true);

      // delete the first todo
      toDoDatabase.deleteToDo(0);

      // check new state
      expect(toDoDatabase.toDoList.length, 1);
      expect(toDoDatabase.toDoList[0].action, 'task2');
      expect(toDoDatabase.toDoList[0].completion, true);
    });
  });

  group('test reordering to dos', () {
    test('move todo forward/down', () {
      // create mock hive box.
      final box = MockBox();

      // mock get response
      when(box.get('session1')).thenAnswer((_) =>
          [ToDo('task1', false), ToDo('task2', true), ToDo('task3', false)]);

      // init db with mock box
      final toDoDatabase = ToDoDatabase(db: box);

      // loading db should give a todo list
      toDoDatabase.loadData();

      // check initial state
      expect(toDoDatabase.toDoList.length, 3);
      expect(toDoDatabase.toDoList[0].action, 'task1');
      expect(toDoDatabase.toDoList[0].completion, false);
      expect(toDoDatabase.toDoList[1].action, 'task2');
      expect(toDoDatabase.toDoList[1].completion, true);
      expect(toDoDatabase.toDoList[2].action, 'task3');
      expect(toDoDatabase.toDoList[2].completion, false);

      // move task 2 to end of list
      toDoDatabase.reorderToDo(1, 3);

      // check new state
      expect(toDoDatabase.toDoList.length, 3);
      expect(toDoDatabase.toDoList[0].action, 'task1');
      expect(toDoDatabase.toDoList[0].completion, false);
      expect(toDoDatabase.toDoList[2].action, 'task2');
      expect(toDoDatabase.toDoList[2].completion, true);
      expect(toDoDatabase.toDoList[1].action, 'task3');
      expect(toDoDatabase.toDoList[1].completion, false);
    });

    test('move todo back/up', () {
      // create mock hive box.
      final box = MockBox();

      // mock get response
      when(box.get('session1')).thenAnswer((_) =>
          [ToDo('task1', false), ToDo('task2', true), ToDo('task3', false)]);

      // init db with mock box
      final toDoDatabase = ToDoDatabase(db: box);

      // loading db should give a todo list
      toDoDatabase.loadData();

      // check initial state
      expect(toDoDatabase.toDoList.length, 3);
      expect(toDoDatabase.toDoList[0].action, 'task1');
      expect(toDoDatabase.toDoList[0].completion, false);
      expect(toDoDatabase.toDoList[1].action, 'task2');
      expect(toDoDatabase.toDoList[1].completion, true);
      expect(toDoDatabase.toDoList[2].action, 'task3');
      expect(toDoDatabase.toDoList[2].completion, false);

      // move task 2 to start of list
      toDoDatabase.reorderToDo(1, 0);

      // check new state
      expect(toDoDatabase.toDoList.length, 3);
      expect(toDoDatabase.toDoList[1].action, 'task1');
      expect(toDoDatabase.toDoList[1].completion, false);
      expect(toDoDatabase.toDoList[0].action, 'task2');
      expect(toDoDatabase.toDoList[0].completion, true);
      expect(toDoDatabase.toDoList[2].action, 'task3');
      expect(toDoDatabase.toDoList[2].completion, false);
    });
  });
}
