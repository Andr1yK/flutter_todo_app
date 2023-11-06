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
}