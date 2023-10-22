import 'package:flutter/material.dart';

import 'src/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}