import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/models/models.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_todos/blocs/todos/todos.dart';
import 'package:flutter_todos/extensions/extensions.dart';
import 'package:flutter_todos/screens/screens.dart';
import 'package:flutter_todos/flutter_todos_keys.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key ?? ArchSampleKeys.todoDetailsScreen);

  static Route<Todo> route({required String id}) {
    return MaterialPageRoute(
      builder: (_) {
        return DetailsScreen(id: id);
      },
    );
  }

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        final todo = (state as TodosLoadSuccess)
            .todos
            .firstOrNullWhere((todo) => todo.id == id);

        final localizations = ArchSampleLocalizations.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(localizations.todoDetails),
            actions: [
              IconButton(
                tooltip: localizations.deleteTodo,
                key: ArchSampleKeys.deleteTodoButton,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<TodosBloc>(context).add(TodoDeleted(todo!));
                  Navigator.of(context).pop(todo);
                },
              )
            ],
          ),
          body: todo == null
              ? const SizedBox(key: FlutterTodosKeys.emptyDetailsContainer)
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Checkbox(
                              key: FlutterTodosKeys.detailsScreenCheckBox,
                              value: todo.complete,
                              onChanged: (_) {
                                BlocProvider.of<TodosBloc>(context).add(
                                  TodoUpdated(
                                    todo.copyWith(complete: !todo.complete),
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: '${todo.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 16,
                                    ),
                                    child: Text(
                                      todo.task,
                                      key: ArchSampleKeys.detailsTodoItemTask,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                ),
                                Text(
                                  todo.note,
                                  key: ArchSampleKeys.detailsTodoItemNote,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.editTodoFab,
            tooltip: localizations.editTodo,
            onPressed: todo == null
                ? null
                : () {
                    Navigator.of(context).push(
                      AddEditScreen.route(
                        key: ArchSampleKeys.editTodoScreen,
                        onSave: (task, note) {
                          BlocProvider.of<TodosBloc>(context).add(
                            TodoUpdated(
                              todo.copyWith(task: task, note: note),
                            ),
                          );
                        },
                        isEditing: true,
                        todo: todo,
                      ),
                    );
                  },
            child: const Icon(Icons.edit),
          ),
        );
      },
    );
  }
}
