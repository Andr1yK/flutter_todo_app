import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_bloc.dart';
import 'package:flutter_todo_app/src/component/todos/TodoItem/todo_item.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';

import '../../../pages/home_page.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.todos,
    required this.setTodos,
    required this.filter,
  });

  final List<Todo> todos;
  final void Function(List<Todo>) setTodos;
  final Filter filter;

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

  void onEdit(Todo currentTodo, String value) {
    if (value.isEmpty) {
      onDelete(currentTodo);
      return;
    }

    var newTodos = todos.map((todo) {
      if (todo.id == currentTodo.id) {
        return Todo(
          id: todo.id,
          isDone: todo.isDone,
          title: value,
        );
      }

      return todo;
    }).toList();

    setTodos(newTodos);
  }

  void onDelete(Todo currentTodo) {
    var newTodos = todos.where(
      (todo) => todo.id != currentTodo.id
    ).toList();

    setTodos(newTodos);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteTodoBloc, RemoteTodoState>(
      builder: (_, state) {
        if (state is RemoteTodoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is RemoteTodoError) {
          return const Center(
            child: Icon(Icons.refresh),
          );
        }

    return ListView(
      shrinkWrap: true,
      children: visibleTodos.map(
        (todo) => TodoItem(
          key: Key(todo.id.toString()),
          item: todo,
          onStatusChange: (newStatus) {
            onStatusChange(todo, newStatus);
          },
          onEdit: (value) {
            onEdit(todo, value);
          },
          onDelete: () {
            onDelete(todo);
          }
        )
      ).toList(),
    );
  }
}