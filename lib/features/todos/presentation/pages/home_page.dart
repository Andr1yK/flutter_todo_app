import 'package:flutter/material.dart';
import 'package:flutter_todo_app/features/todos/presentation/widgets/footer.dart';

import '../resources/filter.dart';
import '../widgets/add_todo_form.dart';
import '../widgets/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Filter filter = Filter.all;

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
                    const AddTodoForm(),
                    Flexible(
                      child: TodoList(
                        filter: filter,
                      ),
                    ),
                    Footer(
                      activeFilter: filter,
                      onFilterChange: setFilter,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}