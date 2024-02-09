import 'package:hive/hive.dart';

part 'to_do.g.dart';

@HiveType(typeId: 1)
class ToDo {
  @HiveField(0)
  String action = '';

  @HiveField(1)
  bool completion = false;

  ToDo(this.action, this.completion);
}
