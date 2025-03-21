// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/task_provider.dart';
import 'package:todolist/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider()..fetchTasks(),
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Colors.grey[100],
            textTheme: TextTheme(
                headlineMedium: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black))),
        title: 'Tareas',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
