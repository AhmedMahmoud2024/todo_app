// lib/main.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'todo.dart';

// ... existing code ...

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  Box<Todo>? todoBox;

  @override
  void initState() {
    super.initState();
    // Open the Hive box
    todoBox = Hive.box<Todo>('todos');
  }

  void addTodo(String task) {
    final newTodo = Todo(title: task);
    todoBox?.add(newTodo); // Add new todo to the box
    setState(() {}); // Refresh the UI
  }

  void editTodo(int index, String newTask) {
    final todo = todoBox?.getAt(index);
    if (todo != null) {
      todo.title = newTask; // Update the task
      todoBox?.putAt(index, todo); // Save changes to the box
      setState(() {}); // Refresh the UI
    }
  }

  void deleteTodo(int index) {
    todoBox?.deleteAt(index); // Delete the todo from the box
    setState(() {}); // Refresh the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: ValueListenableBuilder(
        valueListenable: todoBox!.listenable(),
        builder: (context, Box<Todo> box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final todo = box.getAt(index);
              return ListTile(
                title: Text(todo!.title),
                onTap: () {
                  // Edit todo on tap
                  _showEditDialog(index, todo.title);
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteTodo(index); // Delete todo on button press
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example of adding a todo
          addTodo('New Task');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(int index, String currentTask) {
    final controller = TextEditingController(text: currentTask);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Todo'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter new task'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                editTodo(index, controller.text); // Edit the todo
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
