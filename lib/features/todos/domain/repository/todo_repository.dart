import 'package:flutter_todo_app/core/resources/data_state.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<DataState<List<TodoEntity>>> getTodos();

  Stream<DataState<List<TodoEntity>>> listenTodos();

  void dispose();

  Future<DataState<void>> addTodo(TodoEntity todo);

  Future<DataState<void>> updateTodo(TodoEntity todo);

  Future<DataState<void>> deleteTodo(TodoEntity todo);

  Future<DataState<void>> toggleAll();

  Future<DataState<void>> clearCompleted();
}