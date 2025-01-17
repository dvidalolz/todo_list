import 'package:flutter/material.dart';
import 'package:flutter_project/pages/add_todo_page.dart';
import 'package:flutter_project/pages/edit_todo_page.dart';
import 'package:flutter_project/pages/setting_page.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Map<String, dynamic>> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(todos[index]['name']),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    todos.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Todo removed")),
                  );
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                child: ListTile(
                  onTap: () async {
                    var updatedTodo = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTodoPage(todoData: todos[index]),
                      ),
                    );
                    if (updatedTodo != null) {
                      setState(() {
                        todos[index] = updatedTodo;
                      });
                    }
                  },
                  leading: Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      setState(() {
                        todos.removeAt(index);
                      });
                    },
                  ),
                  title: Text(todos[index]['name']),
                  subtitle: Text(todos[index]['description']),
                  trailing: Text(todos[index]['dueDate']?.toString() ?? 'No Due Date'),
                ),
              );
            },
          ),
          // Add Settings button
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingPage()),
                  );
                },
                child: Icon(Icons.more_vert),
                backgroundColor: Colors.blue,
                mini: true, // Makes the button smaller
              ),
            ),
          ),
          // Add Todo button
          Align(
            alignment: Alignment.topRight,
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
                      todos.add(newTodo);
                    });
                  }
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}