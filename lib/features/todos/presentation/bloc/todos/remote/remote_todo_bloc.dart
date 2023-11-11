import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/core/resources/data_state.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/add_todo.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/clear_completed.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/delete_todo.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/todos_subscription.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/toggle_all.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/update_todo.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_event.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_state.dart';

class RemoteTodoBloc extends Bloc<RemoteTodoEvent, RemoteTodoState> {
  final TodosSubscriptionUseCase _todosSubscriptionUseCase;
  final AddTodoUseCase _addTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final ToggleAllUseCase _toggleAllUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;
  final ClearCompletedUseCase _clearCompletedUseCase;

  RemoteTodoBloc(
    this._todosSubscriptionUseCase,
    this._addTodoUseCase,
    this._updateTodoUseCase,
    this._toggleAllUseCase,
    this._deleteTodoUseCase,
    this._clearCompletedUseCase,
  ): super(const RemoteTodoLoading()) {
    on <TodosSubscription> (
      onTodosSubscription,
      transformer: restartable(),
    );
    on <AddTodo> (onAddTodo);
    on <UpdateTodo> (onUpdateTodo);
    on <ToggleAll> (onToggleAll);
    on <DeleteTodo> (onDeleteTodo);
    on <ClearCompleted> (onClearCompleted);
  }

  Future<void> onTodosSubscription(TodosSubscription event, Emitter<RemoteTodoState> emit) {
    return emit.forEach(
      _todosSubscriptionUseCase(),
      onData: (todos) {
        if (todos is DataSuccess) {
          return RemoteTodoDone(todos: todos.data!);
        }

        if (todos is DataError) {
          return RemoteTodoError(error: todos.error!);
        }

        return const RemoteTodoLoading();
      },
    );
  }

  void onAddTodo(AddTodo event, Emitter<RemoteTodoState> emit) async {
    await _addTodoUseCase(
      params: TodoEntity(
        title: event.title,
        isDone: false,
      ),
    );
  }

  void onUpdateTodo(UpdateTodo event, Emitter<RemoteTodoState> emit) async {
    await _updateTodoUseCase(
      params: event.item,
    );
  }

  void onToggleAll(ToggleAll event, Emitter<RemoteTodoState> emit) async {
    await _toggleAllUseCase();
  }

  void onDeleteTodo(DeleteTodo event, Emitter<RemoteTodoState> emit) async {
    await _deleteTodoUseCase(
      params: event.item,
    );
  }

  void onClearCompleted(ClearCompleted event, Emitter<RemoteTodoState> emit) async {
    await _clearCompletedUseCase();
  }

  @override
  Future<void> close() {
    _todosSubscriptionUseCase.dispose();

    return super.close();
  }
}