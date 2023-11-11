import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/core/resources/data_state.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/add_todo.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/clear_completed.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/delete_todo.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/get_todos.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/toggle_all.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/update_todo.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_event.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_state.dart';

class RemoteTodoBloc extends Bloc<RemoteTodoEvent, RemoteTodoState> {
  final GetTodosUseCase _getTodosUseCase;
  final AddTodoUseCase _addTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final ToggleAllUseCase _toggleAllUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;
  final ClearCompletedUseCase _clearCompletedUseCase;

  RemoteTodoBloc(
    this._getTodosUseCase,
    this._addTodoUseCase,
    this._updateTodoUseCase,
    this._toggleAllUseCase,
    this._deleteTodoUseCase,
    this._clearCompletedUseCase,
  ): super(const RemoteTodoLoading()) {
    on <GetTodos> (onGetTodos);
    on <AddTodo> (onAddTodo);
    on <UpdateTodo> (onUpdateTodo);
    on <ToggleAll> (onToggleAll);
    on <DeleteTodo> (onDeleteTodo);
    on <ClearCompleted> (onClearCompleted);
  }

  void onGetTodos(GetTodos event, Emitter<RemoteTodoState> emit) async {
    final todos = await _getTodosUseCase();

    if (todos is DataSuccess) {
      emit(
        RemoteTodoDone(todos: todos.data ?? []),
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

  void onUpdateTodo(UpdateTodo event, Emitter<RemoteTodoState> emit) async {
    await _updateTodoUseCase(
      params: event.item,
    );

    final todos = await _getTodosUseCase();

    emit(RemoteTodoDone(todos: todos.data!));
  }

  void onToggleAll(ToggleAll event, Emitter<RemoteTodoState> emit) async {
    await _toggleAllUseCase();

    final todos = await _getTodosUseCase();

    emit(RemoteTodoDone(todos: todos.data!));
  }

  void onDeleteTodo(DeleteTodo event, Emitter<RemoteTodoState> emit) async {
    await _deleteTodoUseCase(
      params: event.item,
    );

    final todos = await _getTodosUseCase();

    emit(RemoteTodoDone(todos: todos.data!));
  }

  void onClearCompleted(ClearCompleted event, Emitter<RemoteTodoState> emit) async {
    await _clearCompletedUseCase();

    final todos = await _getTodosUseCase();

    emit(RemoteTodoDone(todos: todos.data!));
  }
}