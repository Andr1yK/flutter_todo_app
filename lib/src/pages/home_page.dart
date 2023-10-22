import 'package:flutter/material.dart';
import 'package:flutter_todo_app/src/component/todos/AddTodoForm/add_todo_form.dart';
import 'package:flutter_todo_app/src/component/todos/TodoList/todo_list.dart';
import 'package:flutter_todo_app/src/types/todo.typedefs.dart';

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

  List<Todo> todos = const [
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

  void setFilter(Filter newFilter) {
    setState(() {
      filter = newFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
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
                      addTodo: addTodo
                    ),
                    TodoList(
                      todos: todos,
                      setTodos: setTodos,
                      filter: filter,
                    ),
                    Footer(
                      todos: todos,
                      filter: filter,
                      setFilter: setFilter,
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
    required this.filter,
    required this.setFilter,
  });

  final List<Todo> todos;
  final Filter filter;
  final void Function(Filter) setFilter;

  @override
  Widget build(BuildContext context) {
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    int itemsLeft = todos.where((todo) => !todo.isDone).length;


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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '$itemsLeft items left',
              style: TextStyle(
                color: secondaryColor,
              ),
            ),
            Filters(
              filter: filter,
              setFilter: setFilter,
            ),
            FilterButton(
                text: 'Clear completed',
                onPressed: () {},
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
    required this.filter,
    required this.setFilter,
  });

  final Filter filter;
  final void Function(Filter) setFilter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: Filter.values.map((filter) {
        return FilterButton(
          text: filter.label,
          isSelected: this.filter == filter,
          onPressed: () {
            setFilter(filter);
          },
        );
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
  });

  final String text;
  final void Function() onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var secondaryColor = Theme.of(context).colorScheme.secondary;

    return TextButton(
      // add borders to buttons on hover
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
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: secondaryColor,
        ),
      ),
    );
  }
}