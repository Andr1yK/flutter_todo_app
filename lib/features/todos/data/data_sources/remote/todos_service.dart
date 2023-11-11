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
    await reference.push()
      .set(TodoModel.fromEntity(todo).toMap());
  }

  Future<void> updateTodo(TodoEntity todo) async {
    await reference.child(todo.id!)
      .update(TodoModel.fromEntity(todo).toMap());
  }

  Future<void> toggleAll() async {
    var todos = await getTodos();

    var allDone = todos.every((todo) => todo.isDone == true);

    List<TodoModel> newTodos = todos.map(
      (todo) => todo.copyWith(isDone: !allDone)
    ).toList();

    await reference.set(
      newTodos.map((todo) => todo.toMap()).toList(),
    );
  }

  Future<void> deleteTodo(TodoEntity todo) async {
    await reference.child(todo.id!)
      .remove();
  }
}