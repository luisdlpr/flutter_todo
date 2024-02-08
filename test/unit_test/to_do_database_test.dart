// ToDoDatabase Data Layer Unit Tests.
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/ToDo.dart';
import 'package:flutter_todo/data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'to_do_database_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  test('test ToDoDatabase with no data in box', () {
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

  test('test ToDoDatabase with previous data in box', () {
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
  });
}
