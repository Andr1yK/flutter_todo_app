import 'package:flutter_todo_app/core/resources/data_state.dart';
import 'package:flutter_todo_app/features/todos/data/data_sources/remote/todos_service.dart';
import 'package:flutter_todo_app/features/todos/data/models/todo.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';
import 'package:flutter_todo_app/features/todos/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodosService _todosService;

  TodoRepositoryImpl(this._todosService);

  @override
  Future<DataState<List<TodoModel>>> getTodos() async {
    try {
      var todos = await _todosService.getTodos();

      return DataSuccess(todos);
    } on Error catch (e) {
      print(e);

      return DataError(e);
    }
  }

  @override
  Future<DataState<void>> addTodo(TodoEntity todo) async {
    try {
      await _todosService.addTodo(todo);

      return const DataSuccess(null);
    } on Error catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<void>> updateTodo(TodoEntity todo) async {
    try {
      await _todosService.updateTodo(todo);

      return const DataSuccess(null);
    } on Error catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<void>> deleteTodo(TodoEntity todo) async {
    try {
      await _todosService.deleteTodo(todo);

      return const DataSuccess(null);
    } on Error catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<void>> toggleAll() async {
    try {
      await _todosService.toggleAll();

      return const DataSuccess(null);
    } on Error catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<void>> clearCompleted() async {
    try {
      var todos = await _todosService.getTodos();

      var completedTodos = todos
        .where((todo) => todo.isDone == true)
        .toList();

      await _todosService.deleteTodos(completedTodos);

      return const DataSuccess(null);
    } on Error catch (e) {
      return DataError(e);
    }
  }
}