import 'package:flutter/material.dart';
import 'package:todo_list_app/todo.dart';

import 'add_todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> todos = [];

  void addTodo(String title) {
    setState(() {
      todos.add(Todo(title: title));
    });
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To_Do_List'),
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(todos[index].title),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteTodo(index),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTodo = await showDialog<String>(
              context: context, builder: (context) => AddTodoDialog());
          if (newTodo != null) {
            addTodo(newTodo);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
