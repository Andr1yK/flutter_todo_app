import 'package:flutter/material.dart';
import 'package:flutter_todo_app/src/component/todos/TodoList/TodoList.dart';
import 'package:flutter_todo_app/src/types/todo.typedefs.dart';

class HomePage extends StatelessWidget {
  const HomePage({ super.key });

  @override
  Widget build(BuildContext context) {
    const todos = [
      Todo(
        isDone: false,
        title: 'Buy milk',
      ),
      Todo(
        isDone: false,
        title: 'Buy eggs',
      ),
      Todo(
        isDone: false,
        title: 'Buy bread',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const TodoList(todos: todos),
    );
  }
}