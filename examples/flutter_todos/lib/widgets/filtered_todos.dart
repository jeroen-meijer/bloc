import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_todos/blocs/blocs.dart';
import 'package:flutter_todos/widgets/widgets.dart';
import 'package:flutter_todos/screens/screens.dart';
import 'package:flutter_todos/flutter_todos_keys.dart';

class FilteredTodos extends StatefulWidget {
  const FilteredTodos({Key? key}) : super(key: key);

  @override
  _FilteredTodosState createState() => _FilteredTodosState();
}

class _FilteredTodosState extends State<FilteredTodos> {
  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);

    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        if (state is FilteredTodosLoadInProgress) {
          return const LoadingIndicator(
            key: ArchSampleKeys.todosLoading,
          );
        } else if (state is FilteredTodosLoadSuccess) {
          final todos = state.filteredTodos;
          return ListView.builder(
            key: ArchSampleKeys.todoList,
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todos[index];
              return TodoItem(
                todo: todo,
                onDismissed: (direction) {
                  BlocProvider.of<TodosBloc>(context).add(TodoDeleted(todo));
                  ScaffoldMessenger.of(context).showSnackBar(
                    DeleteTodoSnackBar(
                      key: ArchSampleKeys.snackbar,
                      todo: todo,
                      onUndo: () => BlocProvider.of<TodosBloc>(context)
                          .add(TodoAdded(todo)),
                      localizations: localizations,
                    ),
                  );
                },
                onTap: () async {
                  final removedTodo = await Navigator.of(context)
                      .push(DetailsScreen.route(id: todo.id));

                  if (!mounted) {
                    return;
                  }

                  if (removedTodo != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      DeleteTodoSnackBar(
                        key: ArchSampleKeys.snackbar,
                        todo: todo,
                        onUndo: () => BlocProvider.of<TodosBloc>(context)
                            .add(TodoAdded(todo)),
                        localizations: localizations,
                      ),
                    );
                  }
                },
                onCheckboxChanged: (_) {
                  BlocProvider.of<TodosBloc>(context).add(
                    TodoUpdated(todo.copyWith(complete: !todo.complete)),
                  );
                },
              );
            },
          );
        } else {
          return const SizedBox(
            key: FlutterTodosKeys.filteredTodosEmptyContainer,
          );
        }
      },
    );
  }
}
