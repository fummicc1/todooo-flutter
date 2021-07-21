import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/states/app_state.dart';
import 'package:todooo/states/detail_todo_state.dart';
import 'package:todooo/ui/pages/detail_todo_page.dart';

class ToDoListCell extends StatelessWidget {
  final ToDo toDo;

  ToDoListCell({required this.toDo});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: toDo.isOver
          ? Theme.of(context).disabledColor.withAlpha(0)
          : Theme.of(context).cardColor,
      child: ListTile(
        title: Row(
          children: <Widget>[
            toDo.isDone
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.check, color: Colors.black),
                  )
                : Container(),
            Flexible(
              child: Text(
                toDo.content,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              settings: const RouteSettings(name: "/detail_todo_page"),
              builder: (context) {
                final AppState appState = Provider.of(context, listen: false);
                return ChangeNotifierProvider(
                  create: (_) => DetailToDoState(
                      localNotificationService:
                          appState.localNotificationService,
                      toDoRepository: appState.toDoRepository,
                      toDo: toDo),
                  child: DetailToDoPage(),
                );
              }));
        },
      ),
    );
  }
}
