import 'package:flutter_todo_app/core/resources/data_state.dart';
import 'package:flutter_todo_app/core/usecases/usecase.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';
import 'package:flutter_todo_app/features/todos/domain/repository/todo_repository.dart';

class UpdateTodoUseCase implements UseCase<DataState<void>, TodoEntity> {
  final TodoRepository _todoRepository;

  UpdateTodoUseCase(this._todoRepository);

  @override
  Future<DataState<void>> call({required TodoEntity params}) {
    return _todoRepository.updateTodo(params);
  }
}