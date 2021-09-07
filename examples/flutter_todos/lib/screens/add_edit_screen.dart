import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_todos/models/models.dart';

typedef OnSaveCallback = Function(String task, String note);

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({
    Key? key,
    required this.onSave,
    required this.isEditing,
    this.todo,
  })  : assert(isEditing == false || todo != null),
        super(key: key ?? ArchSampleKeys.addTodoScreen);

  static Route<void> route({
    Key? key,
    required OnSaveCallback onSave,
    required bool isEditing,
    Todo? todo,
  }) {
    return MaterialPageRoute(
      builder: (_) {
        return AddEditScreen(
          key: key,
          onSave: onSave,
          isEditing: isEditing,
          todo: todo,
        );
      },
    );
  }

  final OnSaveCallback onSave;
  final bool isEditing;
  final Todo? todo;

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _task = '';
  var _note = '';

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditing ? localizations.editTodo : localizations.addTodo,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: widget.isEditing ? widget.todo!.task : '',
                key: ArchSampleKeys.taskField,
                autofocus: !widget.isEditing,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  hintText: localizations.newTodoHint,
                ),
                validator: (val) {
                  if ((val ?? '').trim().isEmpty) {
                    return localizations.emptyTodoError;
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => _task = value ?? '',
              ),
              TextFormField(
                initialValue: widget.isEditing ? widget.todo!.note : '',
                key: ArchSampleKeys.noteField,
                maxLines: 10,
                style: textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: localizations.notesHint,
                ),
                onSaved: (value) => _note = value ?? '',
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: widget.isEditing
            ? ArchSampleKeys.saveTodoFab
            : ArchSampleKeys.saveNewTodo,
        tooltip: widget.isEditing
            ? localizations.saveChanges
            : localizations.addTodo,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            widget.onSave(_task, _note);
            Navigator.of(context).pop();
          }
        },
        child: Icon(widget.isEditing ? Icons.check : Icons.add),
      ),
    );
  }
}
