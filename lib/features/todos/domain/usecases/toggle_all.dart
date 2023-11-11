import 'package:flutter_todo_app/core/resources/data_state.dart';
import 'package:flutter_todo_app/core/usecases/usecase.dart';
import 'package:flutter_todo_app/features/todos/domain/repository/todo_repository.dart';

class ToggleAllUseCase implements UseCase<DataState<void>, void> {
  final TodoRepository _todoRepository;

  ToggleAllUseCase(this._todoRepository);

  @override
  Future<DataState<void>> call({void params}) {
    return _todoRepository.toggleAll();
  }
}