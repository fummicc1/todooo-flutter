import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/chabge_notifier/add_todo_store.dart';
import 'package:todooo/chabge_notifier/app_store.dart';
import 'package:todooo/chabge_notifier/todo_list_store.dart';
import 'package:todooo/ui/components/todo_list_cell.dart';
import 'package:todooo/ui/pages/add_todo_page.dart';

class ToDoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ToDoListStore toDoListStore = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 96,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 48,
                      left: 0,
                      child: Text(toDoListStore.pageTitle,
                          style: Theme.of(context).textTheme.display1),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      height: 48,
                      child: IconButton(
                          icon: Icon(Icons.add, size: 32), onPressed: () {
                            _moveToAddToDoPage(context);
                      }),
                    )
                  ],
                ),
              ),
              Expanded(
                child: toDoListStore.todoList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: toDoListStore.todoList.length,
                        itemBuilder: (context, index) {
                          final todo = toDoListStore.todoList[index];
                          return ToDoListCell(toDo: todo);
                        })
                    : Center(
                        child: FlatButton(
                          child: Text("最初のToDoを作成",
                              style: Theme.of(context).textTheme.title),
                          onPressed: () {
                            _moveToAddToDoPage(context);
                          },
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _moveToAddToDoPage(BuildContext context) {
    final AppStore appStore = Provider.of(context, listen: false);
    Navigator.of(context).push(
      MaterialPageRoute(
        settings: const RouteSettings(name: "/add_todo_page"),
        builder: (_) => ChangeNotifierProvider(
          create: (_) => AddToDoStore(uid: appStore.user.uid, pageTitle: "登録"),
            child: AddToDoPage()
        )
      )
    );
  }
}
