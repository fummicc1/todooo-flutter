import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/chabge_notifier/detail_todo_store.dart';
import 'package:todooo/chabge_notifier/todo_list_store.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/ui/pages/detail_todo_page.dart';

class ToDoListCell extends StatelessWidget {

  final ToDo toDo;

  ToDoListCell({this.toDo});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: toDo.isOver ? Theme.of(context).disabledColor.withAlpha(0) : Theme.of(context).cardColor,
      child: ListTile(
        title: Row(
          children: <Widget>[
            toDo.isDone ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.check, color: Colors.black),
            ) : Container(),
            Text(toDo.content, style: Theme.of(context).textTheme.title,)
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            settings: const RouteSettings(name: "/detail_todo_page"),
            builder: (context) {
              return ChangeNotifierProvider(
                create: (_) => DetailToDoStore(toDo: toDo),
                child: DetailToDoPage(),
              );
            }
          ));
        },
      ),
    );
  }
}
