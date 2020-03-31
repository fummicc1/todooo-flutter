import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/chabge_notifier/app_store.dart';
import 'package:todooo/chabge_notifier/todo_list_store.dart';
import 'package:todooo/models/user.dart';
import 'package:todooo/ui/pages/todo_list_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppStore appStore = Provider.of(context);
    if (appStore.user == null) {
      return Container();
    } else {
      return ChangeNotifierProvider(
        create: (_) => ToDoListStore(),
        child: ToDoListPage(),
      );
    }
  }
}
