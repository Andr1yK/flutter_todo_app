import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_bloc.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_event.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final TodoEntity item;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  bool isHovered = false;
  bool isEditing = false;
  String? newTitle;

  void _onEditingComplete() {
    setState(() {
      isEditing = false;
    });

    BlocProvider.of<RemoteTodoBloc>(context).add(
      UpdateTodo(
        item: widget.item.copyWith(title: newTitle),
      ),
    );
  }

  void _handleEditRequest() {
    setState(() {
      isEditing = true;
      newTitle = widget.item.title;
    });

    _focusNode.requestFocus();
    _controller.text = widget.item.title ?? '';
  }

  void _onStatusChange(bool? newStatus) {
    BlocProvider.of<RemoteTodoBloc>(context).add(
      UpdateTodo(
        item: widget.item.copyWith(isDone: newStatus),
      ),
    );
  }

  void _onDelete() {
    BlocProvider.of<RemoteTodoBloc>(context).add(
      DeleteTodo(
        item: widget.item,
      ),
    );
  }

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
              onChanged: _onStatusChange,
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
              onPressed: _onDelete,
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
                _onEditingComplete();
              },
              onEditingComplete: _onEditingComplete,
              onSubmitted: (_) {
                _onEditingComplete();
              },
            )
            : GestureDetector(
              onDoubleTap:_handleEditRequest,
              onLongPress: _handleEditRequest,
              child: Text(title ?? ''),
            ),
        ),
      ),
    );
  }
}