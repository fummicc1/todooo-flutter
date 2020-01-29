import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/bloc/todo_list_bloc.dart';
import 'package:todooo/data/todo.dart';

class ToDoCellWidget extends StatelessWidget {

  final ToDo todo;

  ToDoCellWidget(this.todo);

  @override
  Widget build(BuildContext context) {

    ToDoListBloc bloc = Provider.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Card(
        child: ListTile(
          leading: todo.isDone ? Icon(Icons.done) : null,
          title: Text(
            todo.content,
            style: Theme.of(context).textTheme.title,
            maxLines: 3,
          ),
          trailing: Text(
            todo.displayDeadline,
            style: Theme.of(context).textTheme.subtitle,
          ),
          onTap: () {
            showModalBottomSheet(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                ),
                context: context,
                builder: (context) {

                  return Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 8, left: 40, right: 40, bottom: 24),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              todo.content,
                              style: Theme.of(context).textTheme.title,
                              maxLines: 3,
                            ),
                            trailing: Text(
                              todo.displayDeadline,
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 8,
                                        spreadRadius: 4,
                                        color: Colors.grey[300])
                                  ]),
                              margin: EdgeInsets.only(right: 40, left: 40, bottom: 64),
                              child: FlatButton(
                                child: Text(
                                  "削除",
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      .apply(fontWeightDelta: 2, color: Colors.red),
                                ),
                                onPressed: () {
                                  bloc.deleteToDo(todo);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 8,
                                        spreadRadius: 4,
                                        color: Colors.grey[300])
                                  ]),
                              margin:
                              EdgeInsets.only(right: 40, left: 40, bottom: 64),
                              child: FlatButton(
                                child: Text(todo.isDone ? "未完了" : "完了",
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      .apply(fontWeightDelta: 2),
                                ),
                                onPressed: () {
                                  todo.isDone = !todo.isDone;
                                  bloc.updateToDo(todo);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
