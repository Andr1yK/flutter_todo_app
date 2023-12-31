import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';

abstract class RemoteTodoEvent {
  const RemoteTodoEvent();
}

class TodosSubscription extends RemoteTodoEvent {
  const TodosSubscription();
}

class AddTodo extends RemoteTodoEvent {
  final String title;

  const AddTodo({
    required this.title,
  });
}

class UpdateTodo extends RemoteTodoEvent {
  final TodoEntity item;

  const UpdateTodo({
    required this.item,
  });
}

class ToggleAll extends RemoteTodoEvent {
  const ToggleAll();
}

class DeleteTodo extends RemoteTodoEvent {
  final TodoEntity item;

  const DeleteTodo({
    required this.item,
  });
}

class ClearCompleted extends RemoteTodoEvent {
  const ClearCompleted();
}
