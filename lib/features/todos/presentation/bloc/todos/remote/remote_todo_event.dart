abstract class RemoteTodoEvent {
  const RemoteTodoEvent();
}

class GetTodos extends RemoteTodoEvent {
  const GetTodos();
}

class AddTodo extends RemoteTodoEvent {
  final String title;

  const AddTodo({
    required this.title,
  });
}