import 'package:flutter/material.dart';
import 'package:flutter_todo_app/src/types/todo.typedefs.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({
    Key? key,
    required this.item,
    required this.onStatusChange,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  final Todo item;
  final void Function(bool?) onStatusChange;
  final void Function(String) onEdit;
  final void Function() onDelete;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  bool isHovered = false;
  bool isEditing = false;
  String? newTitle;

  void onEditingComplete() {
    setState(() {
      isEditing = false;
    });

    widget.onEdit(newTitle!);
  }

  void handleEditRequest() {
    setState(() {
      isEditing = true;
      newTitle = widget.item.title;
    });

    _focusNode.requestFocus();
    _controller.text = widget.item.title;
  }

  @override
  Widget build(BuildContext context) {
    var isDone = widget.item.isDone;
    var title = widget.item.title;
    var onDelete = widget.onDelete;

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
        child: GestureDetector(
          onDoubleTap:handleEditRequest,
          onLongPress: handleEditRequest,
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
                    onPressed: onDelete,
                  )
                : null,
            title: isEditing
              ? TextField(
                focusNode: _focusNode,
                controller: _controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    newTitle = value;
                  });
                },
                onTapOutside: (_) {
                  onEditingComplete();
                },
                onEditingComplete: onEditingComplete,
                onSubmitted: (_) {
                  onEditingComplete();
                },
              )
              : Text(
                title,
                style: TextStyle(
                  decoration: isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                ),
              ),
          ),
        ),
      ),
    );
  }
}