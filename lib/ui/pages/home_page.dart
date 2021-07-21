import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/services/local_notification_service.dart';
import 'package:todooo/states/app_state.dart';
import 'package:todooo/states/detail_todo_state.dart';
import 'package:todooo/ui/pages/detail_todo_page.dart';
import 'package:todooo/ui/pages/todo_list_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppState appState = Provider.of(context);

    final LocalNotificationService localNotificationService =
        appState.localNotificationService;

    localNotificationService.initializeSetting((payload) {
      return onSelectNotification(context, payload);
    });

    if (appState.user == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ToDoListPage();
    }
  }

  Future onSelectNotification(BuildContext context, String? payload) async {
    final AppState appState = Provider.of(context, listen: false);
    print(payload);
    final Map<String, dynamic> map = json.decode(payload ?? "");
    print(map);
    final String todoId = map["todo_id"] as String? ?? "";
    try {
      final ToDo todo = await appState.fetchToDo(id: todoId);
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (_) {
                    final AppState appState = Provider.of(context, listen: false);
                    return DetailToDoState(
                      localNotificationService: appState.localNotificationService,
                        toDoRepository: appState.toDoRepository, toDo: todo);
                  },
                  child: DetailToDoPage())));
    } catch (e) {
      print(e);
    }
  }
}
