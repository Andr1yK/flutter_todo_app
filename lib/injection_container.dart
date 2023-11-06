import 'package:flutter_todo_app/features/todos/data/data_sources/remote/todos_service.dart';
import 'package:flutter_todo_app/features/todos/data/repository/todo_repository_impl.dart';
import 'package:flutter_todo_app/features/todos/domain/repository/todo_repository.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/add_todo.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/get_todos.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dependencies
  sl.registerSingleton<TodosService>(TodosService());

  sl.registerSingleton<TodoRepository>(
    TodoRepositoryImpl(sl())
  );

  // Use cases
  sl.registerSingleton<GetTodosUseCase>(
    GetTodosUseCase(sl())
  );

  sl.registerSingleton<AddTodoUseCase>(
    AddTodoUseCase(sl())
  );
  
  // Blocs
  sl.registerFactory<RemoteTodoBloc>(
    () => RemoteTodoBloc(sl(), sl())
  );
}