import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  const TodoEntity({
    this.id,
    this.title,
    this.isDone,
  });

  final String ? id;
  final String ? title;
  final bool ? isDone;

  @override
  List<Object?> get props => [id, title, isDone];

  copyWith({
    String ? id,
    String ? title,
    bool ? isDone,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}