import 'package:flutter/material.dart';
import 'package:flutter_todo_app/src/component/todos/TodoItem/TodoItem.dart';
import 'package:flutter_todo_app/src/types/todo.typedefs.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.todos,
  });

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: todos.map(
        (todo) => TodoItem(item: todo)
      ).toList(),
    );
  }
}