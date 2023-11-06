import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_todo_app/features/todos/data/models/todo.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';

class TodosService {
  final reference = FirebaseDatabase.instance.ref('Todos');

  Future<List<TodoModel>> getTodos() async {
    var data = await reference.once();
    var snapshot = data.snapshot;

    if (!snapshot.exists) {
      return [];
    }

    var todos = snapshot.children;

    return todos.map(TodoModel.fromSnapshot).toList();
  }

  Future<void> addTodo(TodoEntity todo) async {
    await reference.push().set({
      'title': todo.title,
      'isDone': todo.isDone,
    });
  }
}