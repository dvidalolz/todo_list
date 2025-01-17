import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.sort),
            title: Text('Sort by'),
            onTap: () {
              // Placeholder for sort by functionality
            },
          ),
          ListTile(
            leading: Icon(Icons.check_circle),
            title: Text('Completed Tasks'),
            onTap: () {
              // Placeholder for showing completed tasks
            },
          ),
          ListTile(
            leading: Icon(Icons.brightness_6),
            title: Text('Light/Dark Theme'),
            onTap: () {
              // Placeholder for theme switching
            },
          ),
        ],
      ),
    );
  }
}