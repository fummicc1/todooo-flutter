import 'package:flutter/material.dart';
import 'package:todooo/ui/components/header_widget.dart';

class ToDoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HeaderWidget(child: Text("A"), title: "ToDoList");
  }
}
