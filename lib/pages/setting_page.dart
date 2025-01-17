import 'package:flutter/material.dart';
import 'package:flutter_project/pages/completed_tasks_page.dart';
import 'package:flutter_project/todo_model.dart';

class SettingPage extends StatelessWidget {
  final List<Todo> todos;

  SettingPage({required this.todos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.white)),
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
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.sort, color: Colors.blue.shade700),
              title: Text('Sort by Due Date', style: TextStyle(color: Colors.blue.shade700)),
              onTap: () {
                // Sort todos by due date, null dates go to the end
                List<Todo> sortedTodos = List.from(todos);
                sortedTodos.sort((a, b) {
                  if (a.dueDate == null) return 1; // Moves null dates to the end
                  if (b.dueDate == null) return -1;
                  return a.dueDate!.compareTo(b.dueDate!);
                });

                // Pass the sorted list back to TodoListPage
                Navigator.pop(context, sortedTodos);
              },
            ),
            Divider(color: Colors.blue.shade200), // Add a divider for better visual separation
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.blue.shade700),
              title: Text('Completed Tasks', style: TextStyle(color: Colors.blue.shade700)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompletedTasksPage(todos: todos),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}