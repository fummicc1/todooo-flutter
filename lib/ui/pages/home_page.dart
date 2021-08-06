import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/ui/pages/detail_todo_page.dart';
import 'package:todooo/ui/pages/on_boarding_page.dart';
import 'package:todooo/ui/pages/setting_page.dart';
import 'package:todooo/ui/pages/todo_list_page.dart';
import 'package:todooo/ui/pages/walk_through_page.dart';
import 'package:todooo/ui/providers/detail_todo_viewmodel_provider.dart';
import 'package:todooo/ui/providers/home_viewmodel_provider.dart';
import 'package:todooo/ui/providers/local_notification_service_provider.dart';
import 'package:todooo/ui/providers/walkthrough_viewmodel_provider.dart';

class HomePage extends HookConsumerWidget {

  final List<Widget> pages = [
    TodoListPage(),
    SettingPage()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localNotificationService = ref.read(localNotificationServiceProvider);
    localNotificationService.initializeSetting((payload) {
      return onSelectNotification(context, ref, payload);
    });
    final homeState = ref.watch(homeViewModelProvider);
    final tabController = useTabController(initialLength: 2);
    final walkthroughState = ref.watch(walkThroughViewModelProvider);
    final index = useState(0);

    tabController.addListener(() {
      index.value = tabController.index;
    });

    if (homeState.user == null) {
      return OnBoardingPage();
    } else if (walkthroughState.isCompleteWalkThrough) {
      return Scaffold(
        body: pages[tabController.index],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "一覧"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "設定"),
          ],
          currentIndex: index.value,
          onTap: (index) {
            tabController.index = index;
          },
        ),
      );
    } else {
      return WalkThroughPage();
    }
  }

  Future onSelectNotification(BuildContext context, WidgetRef ref, String? payload) async {
    print(payload);
    final Map<String, dynamic> map = json.decode(payload ?? "");
    print(map);
    final String todoId = map["todo_id"] as String? ?? "";
    try {
      ref.read(detailTodoViewModelProvider.notifier).setId(todoId);
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailTodoPage()));
    } catch (e) {
      print(e);
    }
  }
}