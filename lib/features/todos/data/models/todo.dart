import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';

class TodoModel extends TodoEntity {
  const TodoModel({
    super.id,
    super.title,
    super.isDone
  });

  factory TodoModel.fromSnapshot(dynamic snapshot) {
    return TodoModel(
      id: snapshot.key,
      title: snapshot.value['title'] ?? '',
      isDone: snapshot.value['isDone'] ?? false,
    );
  }

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      id: entity.id,
      title: entity.title,
      isDone: entity.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }

  @override
  TodoModel copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}