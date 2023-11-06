import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/core/resources/data_state.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/add_todo.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/get_todos.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_event.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_state.dart';

class RemoteTodoBloc extends Bloc<RemoteTodoEvent, RemoteTodoState> {
  final GetTodosUseCase _getTodosUseCase;
  final AddTodoUseCase _addTodoUseCase;

  RemoteTodoBloc(
    this._getTodosUseCase,
    this._addTodoUseCase,
  ): super(const RemoteTodoLoading()) {
    on <GetTodos> (onGetTodos);
    on <AddTodo> (onAddTodo);
  }

  void onGetTodos(GetTodos event, Emitter<RemoteTodoState> emit) async {
    final todos = await _getTodosUseCase();

    if (todos is DataSuccess && todos.data!.isNotEmpty) {
      emit(
        RemoteTodoDone(todos: todos.data!),
      );
    }

    if (todos is DataError) {
      emit(
        RemoteTodoError(error: todos.error!),
      );
    }
  }

  void onAddTodo(AddTodo event, Emitter<RemoteTodoState> emit) async {
    await _addTodoUseCase(
      params: TodoEntity(
        title: event.title,
        isDone: false,
      ),
    );

    final todos = await _getTodosUseCase();

    emit(RemoteTodoDone(todos: todos.data!));
  }
}