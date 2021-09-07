import 'package:equatable/equatable.dart';
import 'package:flutter_todos/models/models.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class TodosLoadRequested extends TodosEvent {}

class TodoAdded extends TodosEvent {
  const TodoAdded(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoAdded { todo: $todo }';
}

class TodoUpdated extends TodosEvent {
  const TodoUpdated(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoUpdated { updatedTodo: $todo }';
}

class TodoDeleted extends TodosEvent {
  const TodoDeleted(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoDeleted { todo: $todo }';
}

class ClearCompleted extends TodosEvent {}

class ToggleAll extends TodosEvent {}
