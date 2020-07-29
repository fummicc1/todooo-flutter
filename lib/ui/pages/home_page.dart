import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/states/app_state.dart';
import 'package:todooo/states/todo_list_state.dart';
import 'package:todooo/ui/pages/todo_list_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppState appState = Provider.of(context);
    if (appState.user == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ToDoListPage();
    }
  }
}
