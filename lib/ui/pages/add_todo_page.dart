import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/chabge_notifier/add_todo_store.dart';
import 'package:todooo/models/todo.dart';

class AddToDoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddToDoStore addToDoStore = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 96,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 48,
                      left: 0,
                      child: Text(addToDoStore.pageTitle,
                          style: Theme.of(context).textTheme.headline4),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      height: 48,


                      child: IconButton(
                          icon: Icon(Icons.create, size: 32),
                          onPressed: addToDoStore.isDataInputted
                              ? () {
                                  addToDoStore.createToDo(createDate: DateTime.now()).then((success) {
                                    if (success) {
                                      Navigator.of(context).pop();
                                    } else {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text("保存に失敗しました。もう一度お試しください。"),
                                      ));
                                    }
                                  });
                                }
                              : null),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: "なにをしますか？",
                ),
                onChanged: (content) {
                  addToDoStore.updateContent(content);
                },
              ),
              SizedBox(height: 48),
              Text("いつまでにやりますか？", style: Theme.of(context).textTheme.subtitle1),
              Wrap(
                children: <Widget>[
                  RadioListTile(
                    title: Text("今日中"),
                    value: Deadline.values[0],
                    groupValue: addToDoStore.deadline,
                    onChanged: (deadline) {
                      addToDoStore.updateSelectingDeadline(deadline);
                    },
                  ),
                  RadioListTile(
                    title: Text("明日まで"),
                    value: Deadline.values[1],
                    groupValue: addToDoStore.deadline,
                    onChanged: (deadline) {
                      addToDoStore.updateSelectingDeadline(deadline);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
