import 'package:flutter/material.dart';
import 'package:flutter_todo_app/src/component/todos/AddTodoForm/add_todo_form.dart';
import 'package:flutter_todo_app/src/component/todos/TodoList/todo_list.dart';
import 'package:flutter_todo_app/src/types/todo.typedefs.dart';

class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> todos = const [
    Todo(
      id: 1,
      isDone: false,
      title: 'Buy milk',
    ),
    Todo(
      id: 2,
      isDone: false,
      title: 'Buy eggs',
    ),
    Todo(
      id: 3,
      isDone: false,
      title: 'Buy bread',
    ),
  ];

  void setTodos(List<Todo> newTodos) {
    setState(() {
      todos = newTodos;
    });
  }

  void addTodo(String title,) {
    var newTodo = Todo(
      id: todos.length + 1,
      isDone: false,
      title: title,
    );

    var newTodos = [newTodo, ...todos];

    setTodos(newTodos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: AddTodoForm(
                addTodo: addTodo
              ),
            ),
            Expanded(
              child: TodoList(
              todos: todos,
              setTodos: setTodos,
              ),
            )
          ],
        ),
      ),
    );
  }
}