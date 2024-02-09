// Mocks generated by Mockito 5.4.4 from annotations
// in flutter_todo/test/widget_test/to_do_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_todo/data/to_do_database.dart' as _i3;
import 'package:flutter_todo/data/to_do.dart' as _i4;
import 'package:hive_flutter/hive_flutter.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeBox_0<E> extends _i1.SmartFake implements _i2.Box<E> {
  _FakeBox_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ToDoDatabase].
///
/// See the documentation for Mockito's code generation for more information.
class MockToDoDatabase extends _i1.Mock implements _i3.ToDoDatabase {
  MockToDoDatabase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int get session => (super.noSuchMethod(
        Invocation.getter(#session),
        returnValue: 0,
      ) as int);

  @override
  set session(int? _session) => super.noSuchMethod(
        Invocation.setter(
          #session,
          _session,
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<_i4.ToDo> get toDoList => (super.noSuchMethod(
        Invocation.getter(#toDoList),
        returnValue: <_i4.ToDo>[],
      ) as List<_i4.ToDo>);

  @override
  set toDoList(List<_i4.ToDo>? _toDoList) => super.noSuchMethod(
        Invocation.setter(
          #toDoList,
          _toDoList,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.Box<dynamic> get db => (super.noSuchMethod(
        Invocation.getter(#db),
        returnValue: _FakeBox_0<dynamic>(
          this,
          Invocation.getter(#db),
        ),
      ) as _i2.Box<dynamic>);

  @override
  void createInitialData() => super.noSuchMethod(
        Invocation.method(
          #createInitialData,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void loadData() => super.noSuchMethod(
        Invocation.method(
          #loadData,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void saveData() => super.noSuchMethod(
        Invocation.method(
          #saveData,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addToDo(
    String? value,
    bool? completion,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #addToDo,
          [
            value,
            completion,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void toggleToDoCompletion(
    bool? val,
    int? index,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #toggleToDoCompletion,
          [
            val,
            index,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void deleteToDo(int? index) => super.noSuchMethod(
        Invocation.method(
          #deleteToDo,
          [index],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void reorderToDo(
    int? oldIndex,
    int? newIndex,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #reorderToDo,
          [
            oldIndex,
            newIndex,
          ],
        ),
        returnValueForMissingStub: null,
      );
}
