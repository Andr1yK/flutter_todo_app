import 'package:flutter/material.dart';

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({super.key, required this.addTodo});

  final void Function(String title) addTodo;

  @override
  AddTodoFormState createState() => AddTodoFormState();
}

class AddTodoFormState extends State<AddTodoForm> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  String todoTitle = '';

  void handleTitleChange(String title) {
    setState(() {
      todoTitle = title;
    });
  }

  void handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (todoTitle.isNotEmpty) {
      widget.addTodo(todoTitle);

      _controller.clear();
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              focusNode: _focusNode,
              controller: _controller,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Enter your todo',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: handleTitleChange,
              onFieldSubmitted: (value) {
                handleSubmit();
              },
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: handleSubmit,
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}



