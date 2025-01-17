import 'package:flutter/material.dart';
import 'package:flutter_project/pages/add_todo_page.dart';
import 'package:flutter_project/pages/edit_todo_page.dart';
import 'package:flutter_project/pages/setting_page.dart';
import 'package:flutter_project/todo_model.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List', style: TextStyle(color: Colors.white)),
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
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: ListView.builder(
                itemCount: todos.where((todo) => !todo.isCompleted).length,
                itemBuilder: (context, index) {
                  final filteredTodos = todos.where((todo) => !todo.isCompleted).toList();
                  final todo = filteredTodos[index];

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
                        setState(() {
                          todo.isCompleted = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Todo marked as completed", style: TextStyle(color: Colors.white)), backgroundColor: Colors.blue),
                        );
                      },
                      background: Container(
                        color: Colors.green,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.done, color: Colors.white),
                      ),
                      child: ListTile(
                        onTap: () async {
                          var updatedTodo = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditTodoPage(todo: todo),
                            ),
                          );
                          if (updatedTodo != null) {
                            setState(() {
                              int todoIndex = todos.indexOf(todo);
                              todos[todoIndex] = Todo.fromMap(updatedTodo);
                            });
                          }
                        },
                        leading: Checkbox(
                          value: todo.isCompleted,
                          onChanged: (bool? value) {
                            setState(() {
                              todo.toggleCompletion();
                            });
                          },
                          activeColor: Colors.blue,
                        ),
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
            // Settings button
            Positioned(
              top: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingPage(todos: todos),
                      ),
                    ).then((result) {
                      if (mounted) {
                        setState(() {
                          if (result != null) {
                            todos = result;
                          }
                          // Even if result is null, this setState will trigger a refresh
                        });
                      }
                    });
                  },
                  child: Icon(Icons.more_vert, color: Colors.white),
                  backgroundColor: Colors.blue,
                  mini: true,
                ),
              ),
            ),
            // Add Todo button
            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () async {
                    var newTodo = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTodoPage()),
                    );
                    if (newTodo != null) {
                      setState(() {
                        todos.add(Todo.fromMap(newTodo));
                      });
                    }
                  },
                  child: Icon(Icons.add, color: Colors.white),
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}