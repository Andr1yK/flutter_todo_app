import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_todo_app/features/todos/data/models/todo.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';

class TodosService {
  final reference = FirebaseDatabase.instance.ref('Todos');

  Future<List<TodoModel>> getTodos() async {
    var snapshot = await reference.get();

    if (!snapshot.exists) {
      return [];
    }

    var todos = snapshot.children;

    return todos.map(TodoModel.fromSnapshot).toList();
  }

  Stream<List<TodoModel>> listenTodos() {
    var stream = reference.onValue;
    var mappedStream = stream.map((event) {
      var todos = event.snapshot.children;

      return todos.map(TodoModel.fromSnapshot).toList();
    });

    return mappedStream;
  }

  void dispose() {
    reference.onValue.drain();
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

  Future<void> deleteTodos(List<TodoEntity> todos) async {
    if (todos.isEmpty) {
      return;
    }

    await reference.update(
      todos.fold({}, (acc, todo) {
        acc[todo.id!] = null;
        return acc;
      }),
    );
  }
}