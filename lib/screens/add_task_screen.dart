// lib/screens/add_task_screen.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/task_provider.dart';
import 'package:todolist/models/task.dart';

class AddTaskScreen extends StatelessWidget {
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Agregar tareas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff265047), Color(0xff265047)],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(30.0),
                labelText: 'Nombre de la tarea',
                labelStyle: TextStyle(color: Color(0xff848484)),
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xffe1e1e1), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xffe1e1e1), width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xffe3e3e3), width: 1.5),
                ),
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                if (title.isNotEmpty) {
                  final task = Task(title: title);
                  Provider.of<TaskProvider>(context, listen: false)
                      .addTask(task);

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      Future.delayed(const Duration(seconds: 3), () {
                        if (Navigator.canPop(context)) {
                          Navigator.of(context).pop();
                        }
                      });

                      return AlertDialog(
                        title: Row(
                          children: const [
                            Icon(Icons.check,
                                color: Color(0xff008912), size: 30),
                            SizedBox(width: 10),
                            Text(
                              'Éxito',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff265047),
                              ),
                            ),
                          ],
                        ),
                        content: Text(
                          'Nombre de tarea creada: $title',
                          style: const TextStyle(
                              fontSize: 18, color: Color(0xff265047)),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Icon(Icons.warning, color: Colors.amber, size: 30),
                            SizedBox(width: 10),
                            Text('Advertencia',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff272727))),
                          ],
                        ),
                        content: Text(
                            'Debe ingresar un nombre válido para la tarea, le sugerimos crear un nombre con más de un caracter por lo menos.',
                            style: TextStyle(
                                fontSize: 18, color: Color(0xff272727))),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Aceptar',
                                style: TextStyle(color: Colors.amber)),
                            style: TextButton.styleFrom(
                                textStyle: TextStyle(
                                    decorationColor: Color(
                                      0xff272727,
                                    ),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text('Guardar'),
            )
          ],
        ),
      ),
    );
  }
}
