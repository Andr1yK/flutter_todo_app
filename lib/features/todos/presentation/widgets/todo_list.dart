import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_state.dart';
import 'package:flutter_todo_app/features/todos/presentation/resources/filter.dart';
import 'package:flutter_todo_app/features/todos/presentation/widgets/todo_item.dart';

import '../bloc/todos/remote/remote_todo_bloc.dart';

class TodoList extends StatelessWidget {
  final Filter filter;

  const TodoList({
    super.key,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteTodoBloc, RemoteTodoState>(
      builder: (_, state) {
        if (state is RemoteTodoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is RemoteTodoError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        if (state is RemoteTodoDone) {
          var todos = state.todos!.where((todo) {
            switch (filter) {
              case Filter.active:
                return !todo.isDone!;
              case Filter.completed:
                return todo.isDone!;
              default:
                return true;
            }
          }).toList();

          return todos.isEmpty
            ? const SizedBox(
              height: 48,
              child: Center(
                child: Text('No todos'),
              ),
            )
            : ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                var todo = todos[index];

                return TodoItem(
                  key: Key('__todo_item_${todo.id}__'),
                  item: todo,
                );
              },
              itemCount: todos.length,
            );
        }

        return const Center(
          child: Text('Something went wrong'),
        );
      },
    );
  }
}