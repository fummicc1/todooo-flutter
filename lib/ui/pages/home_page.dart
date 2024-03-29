import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/services/local_notification_service.dart';
import 'package:todooo/states/app_state.dart';
import 'package:todooo/states/detail_todo_state.dart';
import 'package:todooo/ui/pages/detail_todo_page.dart';
import 'package:todooo/ui/pages/on_boarding_page.dart';
import 'package:todooo/ui/pages/setting_page.dart';
import 'package:todooo/ui/pages/todo_list_page.dart';
import 'package:todooo/ui/pages/walk_through_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  final List<Widget> pages = [
    ToDoListPage(),
    SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    final AppState appState = Provider.of(context);

    final LocalNotificationService localNotificationService =
        appState.localNotificationService;

    localNotificationService.initializeSetting((payload) {
      return onSelectNotification(context, payload);
    });

    if (appState.user == null) {
      return OnBoardingPage();
    } else if (appState.user!.isCompleteWalkThrough) {
      return Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "一覧"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "設定"),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      );
    } else {
      return WalkThroughPage();
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
                    final AppState appState =
                        Provider.of(context, listen: false);
                    return DetailToDoState(
                        localNotificationService:
                            appState.localNotificationService,
                        toDoRepository: appState.toDoRepository,
                        toDo: todo);
                  },
                  child: DetailToDoPage())));
    } catch (e) {
      print(e);
    }
  }
}
