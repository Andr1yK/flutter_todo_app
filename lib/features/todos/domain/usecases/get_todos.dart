import 'package:flutter_todo_app/core/resources/data_state.dart';
import 'package:flutter_todo_app/core/usecases/usecase.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';
import 'package:flutter_todo_app/features/todos/domain/repository/todo_repository.dart';

class GetTodosUseCase implements UseCase<DataState<List<TodoEntity>>, void> {
  final TodoRepository _todoRepository;

  GetTodosUseCase(this._todoRepository);

  @override
  Future<DataState<List<TodoEntity>>> call({void params}) {
    return _todoRepository.getTodos();
  }
}