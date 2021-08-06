import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/ui/pages/detail_todo_page.dart';
import 'package:todooo/ui/providers/detail_todo_viewmodel_provider.dart';

class ToDoListCell extends HookConsumerWidget {

  final Todo todo;

  ToDoListCell({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Card(
      color: todo.isOver
          ? Theme.of(context).disabledColor.withAlpha(0)
          : Theme.of(context).cardColor,
      child: ListTile(
        title: Row(
          children: <Widget>[
            todo.isDone
                ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.check, color: Colors.black),
            )
                : Container(),
            Flexible(
              child: Text(
                todo.content,
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
                ref.read(detailTodoViewModelProvider.notifier).setId(todo.uid);
                return DetailTodoPage();
              }));
        },
      ),
    );
  }

}
