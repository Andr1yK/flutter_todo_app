import 'package:flutter/material.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';
import 'package:flutter_todo_app/src/component/todos/AddTodoForm/add_todo_form.dart';
import 'package:flutter_todo_app/src/component/todos/TodoList/todo_list.dart';

enum Filter {
  all('All'),
  active('Active'),
  completed('Completed');

  const Filter(this.label);

  final String label;
}

class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Filter filter = Filter.all;

  List<TodoEntity> todos = const [
    Todo(
      id: 1,
      isDone: false,
      title: 'Buy milk',
    ),
    Todo(
      id: 2,
      isDone: false,
      title: 'Buy eggs',
    ),
    Todo(
      id: 3,
      isDone: false,
      title: 'Buy bread',
    ),
  ];

  void setTodos(List<Todo> newTodos) {
    setState(() {
      todos = newTodos;
    });
  }

  void addTodo(String title,) {
    var newTodo = Todo(
      id: todos.length + 1,
      isDone: false,
      title: title,
    );

    var newTodos = [newTodo, ...todos];

    setTodos(newTodos);
  }

  void onClearCompleted() {
    var newTodos = todos.where(
      (todo) => !todo.isDone
    ).toList();

    setTodos(newTodos);
  }

  void toggleAll() {
    var allDone = todos.every((todo) => todo.isDone);

    var newTodos = todos.map((todo) {
      return Todo(
        id: todo.id,
        isDone: !allDone,
        title: todo.title,
      );
    }).toList();

    setTodos(newTodos);
  }

  void setFilter(Filter newFilter) {
    setState(() {
      filter = newFilter;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 24
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              child: const Text(
                'todos',
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w100,
                  color: Color.fromRGBO(175, 47, 47, 0.15),
                ),
              ),
            ),
            Flexible(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      offset: Offset(0, 25),
                      blurRadius: 50,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AddTodoForm(
                      addTodo: addTodo,
                      onToggleAll: toggleAll,
                    ),
                    Footer(
                      todos: todos,
                      activeFilter: filter,
                      onFilterChange: setFilter,
                      onClearCompleted: onClearCompleted,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({
    super.key,
    required this.todos,
    required this.activeFilter,
    required this.onFilterChange,
    required this.onClearCompleted,
  });

  final List<Todo> todos;
  final Filter activeFilter;
  final void Function(Filter) onFilterChange;
  final void Function() onClearCompleted;

  @override
  Widget build(BuildContext context) {
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    int itemsLeft = todos.where((todo) => !todo.isDone).length;

    bool isMobile = MediaQuery.of(context).size.width < 520;

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
                      onPressed: onClearCompleted,
                      disabled: !todos.any((todo) => todo.isDone),
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
                  onPressed: onClearCompleted,
                  disabled: !todos.any((todo) => todo.isDone),
                ),
              ),
            ],
          ),
      ),
    );
  }
}

class Filters extends StatelessWidget {
  const Filters({
    super.key,
    required this.activeFilter,
    required this.onFilterChange,
  });

  final Filter activeFilter;
  final void Function(Filter) onFilterChange;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 520;

    return Row(
      mainAxisAlignment: isMobile
        ? MainAxisAlignment.spaceEvenly
        : MainAxisAlignment.center,
      children: Filter.values.map((filter) {
        Widget button = FilterButton(
          text: filter.label,
          isSelected: activeFilter == filter,
          onPressed: () {
            onFilterChange(filter);
          },
        );

        return isMobile
          ? Expanded(
            child: button,
          )
          : button;
      }).toList(),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSelected = false,
    this.disabled = false,
  });

  final String text;
  final void Function() onPressed;
  final bool isSelected;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    var secondaryColor = Theme.of(context).colorScheme.secondary;

    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
          (Set<MaterialState> states) {
            if (isSelected || states.contains(MaterialState.hovered)) {
              return const RoundedRectangleBorder(
                side: BorderSide(
                  color: Color.fromRGBO(175, 47, 47, 0.2),
                ),
              );
            }
            return const RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromRGBO(230, 230, 230, 0),
              ),
            );
          },
        ),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: disabled ? null : onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: disabled ? Colors.grey : secondaryColor,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}