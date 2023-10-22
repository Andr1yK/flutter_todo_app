import 'package:flutter/material.dart';

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({
    super.key,
    required this.addTodo,
    required this.onToggleAll,
  });

  final void Function(String title) addTodo;
  final void Function() onToggleAll;

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
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: IconButton(
              onPressed: widget.onToggleAll,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 32,
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.03),
                    offset: Offset(0, 2),
                    blurRadius: 1,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: TextFormField(
                focusNode: _focusNode,
                controller: _controller,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'What needs to be done?',
                  contentPadding: EdgeInsets.all(16), // Padding
                  border: InputBorder.none, // Remove the border
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    color: Color.fromRGBO(230, 230, 230, 1), // Text color
                  ),
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
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal, // or FontWeight.inherit for inheritance
                  color: Colors.black, // Use your desired text color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



