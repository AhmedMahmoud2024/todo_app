import 'package:flutter/material.dart';

class AddTodoDialog extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  AddTodoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add To_Do'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Enter task title'),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
            child: Text('Add'))
      ],
    );
  }
}
