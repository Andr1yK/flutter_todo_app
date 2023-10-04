import 'package:flutter/material.dart';
import 'package:flutter_todo_app/src/component/todos/TodoItem/TodoItem.dart';
import 'package:flutter_todo_app/src/types/todo.typedefs.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.todos,
    required this.setTodos,
  });

  final List<Todo> todos;
  final void Function(List<Todo>) setTodos;

  void onStatusChange(Todo currentTodo, bool? newStatus) {
    var newTodos = todos.map((todo) {
      if (todo.id == currentTodo.id) {
        return Todo(
          id: todo.id,
          isDone: newStatus!,
          title: todo.title,
        );
      }

      return todo;
    }).toList();

    setTodos(newTodos);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: todos.map(
        (todo) => TodoItem(
          key: Key(todo.id.toString()),
          item: todo,
          onStatusChange: (newStatus) {
            onStatusChange(todo, newStatus);
          },
        )
      ).toList(),
    );
  }
}