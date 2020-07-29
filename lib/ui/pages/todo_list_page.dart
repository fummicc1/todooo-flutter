import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/states/add_todo_state.dart';
import 'package:todooo/states/app_state.dart';
import 'package:todooo/states/todo_list_state.dart';
import 'package:todooo/ui/components/todo_list_cell.dart';
import 'package:todooo/ui/pages/add_todo_page.dart';

class ToDoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ToDoListState toDoListState = Provider.of(context);
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
                      child: Text(toDoListState.pageTitle,
                          style: Theme.of(context).textTheme.headline4),
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
                child: toDoListState.todoList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: toDoListState.todoList.length,
                        itemBuilder: (context, index) {
                          final todo = toDoListState.todoList[index];
                          return ToDoListCell(toDo: todo);
                        })
                    : Center(
                        child: FlatButton(
                          child: Text("最初のToDoを作成",
                              style: Theme.of(context).textTheme.headline6),
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
    final AppState appState = Provider.of(context, listen: false);
    Navigator.of(context).push(
      MaterialPageRoute(
        settings: const RouteSettings(name: "/add_todo_page"),
        builder: (_) => ChangeNotifierProvider(
          create: (_) => AddToDoState(uid: appState.user.uid, pageTitle: "登録"),
            child: AddToDoPage()
        )
      )
    );
  }
}
