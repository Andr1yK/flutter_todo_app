import 'package:flutter/material.dart';
import 'package:flutter_todo_app/src/types/todo.typedefs.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Todo item;

  @override
  Widget build(BuildContext context) {
    var isDone = item.isDone;
    var title = item.title;

    return ListTile(
      leading: Checkbox(
        value: isDone,
        onChanged: (value) {},
      ),
      title: Text(title),
    );
  }
}