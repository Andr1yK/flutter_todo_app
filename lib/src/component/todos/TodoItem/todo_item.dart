import 'package:flutter/material.dart';
import 'package:flutter_todo_app/src/types/todo.typedefs.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({
    Key? key,
    required this.item,
    required this.onStatusChange,
  }) : super(key: key);

  final Todo item;
  final void Function(bool?) onStatusChange;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    var isDone = widget.item.isDone;
    var title = widget.item.title;

    return Container(
      // add top border
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color.fromRGBO(230, 230, 230, 1),
          ),
        ),
      ),
      child: MouseRegion(
        onHover: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: ListTile(
          leading: Transform.scale(
            scale: 1.25,
            child: Checkbox(
              fillColor: MaterialStateProperty.all(
                  Colors.transparent,
              ),
              splashRadius: 14,
              activeColor: Colors.transparent,
              checkColor: Colors.green,
              value: isDone,
              onChanged: widget.onStatusChange,
              shape: const CircleBorder(),
              side: const BorderSide(
                width: 1,
                color: Color.fromRGBO(230, 230, 230, 1),
              ),
            ),
          ),
          trailing: isHovered
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {},
                )
              : null,
          title: Text(title),
        ),
      ),
    );
  }
}