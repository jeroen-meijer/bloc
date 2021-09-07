import 'package:equatable/equatable.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

class Todo extends Equatable {
  Todo(
    this.task, {
    this.complete = false,
    String? note = '',
    String? id,
  })  : note = note ?? '',
        id = id ?? Uuid().generateV4();

  final bool complete;
  final String id;
  final String note;
  final String task;

  Todo copyWith({
    bool? complete,
    String? id,
    String? note,
    String? task,
  }) {
    return Todo(
      task ?? this.task,
      complete: complete ?? this.complete,
      note: note ?? this.note,
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [complete, id, note, task];

  @override
  String toString() {
    return 'Todo { complete: $complete, task: $task, note: $note, id: $id }';
  }

  TodoEntity toEntity() {
    return TodoEntity(task, id, note, complete);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(
      entity.task,
      complete: entity.complete,
      note: entity.note,
      id: entity.id,
    );
  }
}
