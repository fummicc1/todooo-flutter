import 'package:flutter/material.dart';
import 'package:todooo/models/todo.dart';

class ToDoListCell extends StatelessWidget {

  final ToDo toDo;

  ToDoListCell({this.toDo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(toDo.content),
    );
  }
}
