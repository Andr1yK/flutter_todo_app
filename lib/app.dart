import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_bloc.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_event.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todos/remote/remote_todo_state.dart';
import 'package:flutter_todo_app/features/todos/presentation/widgets/todo_item.dart';

import 'features/todos/presentation/pages/home_page.dart';
import 'injection_container.dart' show sl;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteTodoBloc>(
      create: (BuildContext context) {
        return sl()..add(const GetTodos());
      },
      child: MaterialApp(
        title: 'ToDo App',
        theme: ThemeData(
          fontFamilyFallback: const ['Helvetica', 'Arial', 'serif'],
          fontFamily: 'Helvetica Neue',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(245, 245, 245, 1),
            background: const Color.fromRGBO(245, 245, 245, 1),
            secondary: const Color.fromRGBO(119, 119, 119, 1),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteTodoBloc, RemoteTodoState>(
        builder: (_, state) {
          if (state is RemoteTodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is RemoteTodoError) {
            return const Center(
              child: Icon(Icons.refresh),
            );
          }

          if (state is RemoteTodoDone) {
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return TodoItem(
                  item: state.todos![index],
                  onStatusChange: (bool? _) {  },
                  onEdit: (String _) {  },
                  onDelete: () {  },
                );
              },
              itemCount: state.todos!.length,
            );
          }

          return const Center(
            child: Text('Something went wrong!'),
          );
        }
    );


  }
}