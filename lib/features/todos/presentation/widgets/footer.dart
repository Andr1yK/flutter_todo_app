import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_bloc.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_event.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_state.dart';
import 'package:flutter_todo_app/features/todos/presentation/resources/filter.dart';

import 'filter_button.dart';
import 'filters.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
    required this.activeFilter,
    required this.onFilterChange,
  });

  final Filter activeFilter;
  final void Function(Filter) onFilterChange;

  void onClearCompleted(BuildContext context) {
    BlocProvider.of<RemoteTodoBloc>(context)
      .add(const ClearCompleted());
  }

  @override
  Widget build(BuildContext context) {
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    bool isMobile = MediaQuery.of(context).size.width < 520;

    return BlocBuilder<RemoteTodoBloc, RemoteTodoState>(
      builder: (_, state) {
        if (state is! RemoteTodoDone) {
          return Container();
        }

        var todos = state.todos!;

        int itemsLeft = todos.where((todo) => todo.isDone != true).length;
        bool isSomeCompleted = itemsLeft != todos.length;

        return Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: Color.fromRGBO(230, 230, 230, 1),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            child: isMobile
              ? Column(
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        '$itemsLeft items left',
                        style: TextStyle(
                          color: secondaryColor,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        alignment: Alignment.centerRight,
                        child: FilterButton(
                          text: 'Clear completed',
                          onPressed: () {
                            onClearCompleted(context);
                          },
                          disabled: !isSomeCompleted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Filters(
                    activeFilter: activeFilter,
                    onFilterChange: onFilterChange,
                  ),
                ],
              )
              : Row(
                children: <Widget>[
                  Text(
                    '$itemsLeft items left',
                    style: TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Spacer(),
                  Filters(
                    activeFilter: activeFilter,
                    onFilterChange: onFilterChange,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Spacer(),
                  Container(
                    alignment: Alignment.centerRight,
                    child: FilterButton(
                      text: 'Clear completed',
                      onPressed: () {
                        onClearCompleted(context);
                      },
                      disabled: !isSomeCompleted,
                    ),
                  ),
                ],
              ),
          ),
        );

      }
    );
  }
}