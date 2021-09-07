import 'package:equatable/equatable.dart';
import 'package:flutter_todos/models/models.dart';

abstract class FilteredTodosState extends Equatable {
  const FilteredTodosState();

  @override
  List<Object> get props => [];
}

class FilteredTodosLoadInProgress extends FilteredTodosState {}

class FilteredTodosLoadSuccess extends FilteredTodosState {
  const FilteredTodosLoadSuccess(
    this.filteredTodos,
    this.activeFilter,
  );

  final List<Todo> filteredTodos;
  final VisibilityFilter activeFilter;

  @override
  List<Object> get props => [filteredTodos, activeFilter];

  @override
  String toString() {
    return 'FilteredTodosLoadSuccess { '
        'filteredTodos: $filteredTodos, '
        'activeFilter: $activeFilter, '
        '}';
  }
}
