import 'package:flutter/material.dart';
import 'package:todooo/main.dart';
import 'package:todooo/repository/local_storage_client.dart';

class ToDoDetailPage extends StatelessWidget {

  final ToDo todo;

  ToDoDetailPage(this.todo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDooo"),
      ),
      body: SafeArea(
        child: ListTile(
          title: Text(
            todo.content,
            maxLines: 3,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          leading: Text(
            todo.displayDeadline,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            children: <Widget>[
              FlatButton(
                child: Text("削除"),
                onPressed: () {
                  LocalStorageClient().deleteToDo(todo);
                }
              ),
              FlatButton(
                child: Text("編集"),
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
