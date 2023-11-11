import 'package:equatable/equatable.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';

abstract class RemoteTodoState extends Equatable {
  final List<TodoEntity> ? todos;
  final Error ? error;

  const RemoteTodoState({
    this.todos,
    this.error,
  });

  @override
  List<Object?> get props => [todos, error];
}

class RemoteTodoLoading extends RemoteTodoState {
  const RemoteTodoLoading();
}

class RemoteTodoDone extends RemoteTodoState {
  const RemoteTodoDone({
    required List<TodoEntity> todos,
  }) : super(todos: todos);
}

class RemoteTodoError extends RemoteTodoState {
  const RemoteTodoError({
    required Error error,
  }) : super(error: error);
}