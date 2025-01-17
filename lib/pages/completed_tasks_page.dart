import 'package:flutter/material.dart';
import 'package:flutter_project/todo_model.dart';

class CompletedTasksPage extends StatelessWidget {
  final List<Todo> todos;

  CompletedTasksPage({required this.todos});

  @override
  Widget build(BuildContext context) {
    // Filter todos to show only completed ones
    List<Todo> completedTodos = todos.where((todo) => todo.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blue[50]!],
          ),
        ),
        child: completedTodos.isEmpty
            ? Center(
                child: Text(
                  'No completed tasks yet.',
                  style: TextStyle(color: Colors.blue.shade700),
                ),
              )
            : ListView.builder(
                itemCount: completedTodos.length,
                itemBuilder: (context, index) {
                  final todo = completedTodos[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    child: Dismissible(
                      key: Key(todo.name),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {
                        // Find the todo and mark it as incomplete
                        int todoIndex = todos.indexWhere((element) => element.name == todo.name);
                        if (todoIndex != -1) {
                          todos[todoIndex].isCompleted = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Todo marked as incomplete", style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.blue,
                            ),
                          );
                          Navigator.pop(context); // Return to previous page which rebuilds with new state
                        }
                      },
                      background: Container(
                        color: Colors.blue,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20.0),
                        child: Icon(Icons.undo, color: Colors.white),
                      ),
                      child: ListTile(
                        title: Text(todo.name, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(todo.description, style: TextStyle(color: Colors.grey[600])),
                        trailing: Text(
                          todo.dueDate != null 
                            ? todo.dueDate!.toIso8601String().substring(0, 10)
                            : 'No Due Date',
                          style: TextStyle(color: Colors.blue.shade700),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}