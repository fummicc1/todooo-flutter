import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/chabge_notifier/todo_list_store.dart';
import 'package:todooo/models/todo.dart';

class ToDoListCell extends StatelessWidget {

  final ToDo toDo;

  ToDoListCell({this.toDo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(toDo.content, style: Theme.of(context).textTheme.title,),
        onTap: () {
          Scaffold.of(context).showBottomSheet((context) {
            final ToDoListStore store = Provider.of(context);
            return Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                color: Theme.of(context).hoverColor
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Flexible(child: Text(toDo.content, style: Theme.of(context).textTheme.headline)),
                        Text(toDo.displayDeadline)
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Text("削除", style: Theme.of(context).textTheme.button.apply(color: Colors.red, fontSizeDelta: 4, fontWeightDelta: 2),),
                          onPressed: () {
                            store.deleteToDo(toDo).then((v) {
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                        FlatButton(
                          child: Text("完了", style: Theme.of(context).textTheme.button.apply(fontSizeDelta: 4, fontWeightDelta: 2)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
