import 'package:flutter/material.dart';
import 'package:flutter_todo_app/src/component/todos/AddTodoForm/add_todo_form.dart';
import 'package:flutter_todo_app/src/component/todos/TodoList/todo_list.dart';
import 'package:flutter_todo_app/src/types/todo.typedefs.dart';

class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    ),
                    const Footer(),
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
  });

  @override
  Widget build(BuildContext context) {
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

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
              '0 items left',
              style: TextStyle(
                color: secondaryColor,
              ),
            ),
            const Filters(),
            const FilterButton(text: 'Clear completed'),
          ],
        ),
      ),
    );
  }
}

class Filters extends StatelessWidget {
  const Filters({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        FilterButton(text: "All", isSelected: true),
        SizedBox(width: 8),
        FilterButton(text: "Active"),
        SizedBox(width: 8),
        FilterButton(text: "Completed"),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.text,
    this.isSelected = false,
  });

  final String text;
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
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(
          color: secondaryColor,
        ),
      ),
    );
  }
}