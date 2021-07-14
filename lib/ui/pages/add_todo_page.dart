import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/states/add_todo_state.dart';
import 'package:todooo/states/todo_list_state.dart';

class AddToDoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddToDoState addToDoState = Provider.of(context);
    final ToDoListState todoListState =
        Provider.of<ToDoListState>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
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
                        child: Text(addToDoState.pageTitle,
                            style: Theme.of(context).textTheme.headline4),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        height: 48,
                        child: IconButton(
                            icon: Icon(Icons.create, size: 32),
                            onPressed: (addToDoState.isDataInputted
                                ? () async {
                                    try {
                                      final result =
                                          await addToDoState.createToDo(
                                              createDate: DateTime.now());
                                      if (result) {
                                        await todoListState.updateToDos();
                                        Navigator.of(context).pop();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text("保存に失敗しました。もう一度お試しください。"),
                                        ));
                                      }
                                    } catch (erorr) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("保存に失敗しました。もう一度お試しください。"),
                                      ));
                                    }
                                  }
                                : null)),
                      )
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
                    addToDoState.updateContent(content);
                  },
                ),
                SizedBox(height: 48),
                Text("いつまでにやりますか？",
                    style: Theme.of(context).textTheme.subtitle1),
                Wrap(
                  children: <Widget>[
                    RadioListTile(
                      title: Text("今日中"),
                      value: Deadline.values[0],
                      groupValue: addToDoState.deadline,
                      onChanged: (deadline) {
                        addToDoState.updateSelectingDeadline(deadline as Deadline);
                      },
                    ),
                    RadioListTile(
                      title: Text("明日まで"),
                      value: Deadline.values[1],
                      groupValue: addToDoState.deadline,
                      onChanged: (deadline) {
                        addToDoState.updateSelectingDeadline(deadline as Deadline);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text("期限が過ぎたら自動で削除をする", style: Theme.of(context).textTheme.subtitle1,),
                Wrap(
                  children: <Widget>[
                    RadioListTile(
                      title: Text("はい"),
                      value: true,
                      groupValue: addToDoState.shouldDeleteAutomatically,
                      onChanged: (shouldDeleteAutomatically) {
                        addToDoState.updateShouldDeleteAutomatically(shouldDeleteAutomatically as bool);
                      },
                    ),
                    RadioListTile(
                      title: Text("いいえ"),
                      value: false,
                      groupValue: addToDoState.shouldDeleteAutomatically,
                      onChanged: (shouldDeleteAutomatically) {
                        addToDoState.updateShouldDeleteAutomatically(shouldDeleteAutomatically as bool);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text("通知をする", style: Theme.of(context).textTheme.subtitle1,),
                Wrap(
                  children: <Widget>[
                    RadioListTile(
                      title: Text("はい"),
                      value: true,
                      groupValue: addToDoState.shouldNotificate,
                      onChanged: (shouldDeleteAutomatically) {
                        addToDoState.updateShouldNotificate(shouldDeleteAutomatically as bool);
                      },
                    ),
                    RadioListTile(
                      title: Text("いいえ"),
                      value: false,
                      groupValue: addToDoState.shouldNotificate,
                      onChanged: (shouldDeleteAutomatically) {
                        addToDoState.updateShouldNotificate(shouldDeleteAutomatically as bool);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
