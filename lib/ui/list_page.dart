import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/data/todo.dart';
import '../bloc/bloc.dart';

class ListPage extends StatefulWidget {
  final List<ToDo> todoList;

  ListPage(this.todoList);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Bloc bloc = Provider.of(context);
    return ListView.builder(
      itemCount: widget.todoList.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Card(
            child: ListTile(
              leading: widget.todoList[index].isDone ? Icon(Icons.done) : null,
              title: Text(
                widget.todoList[index].content,
                style: Theme.of(context).textTheme.title,
                maxLines: 3,
              ),
              trailing: Text(
                widget.todoList[index].displayDeadline,
                style: Theme.of(context).textTheme.subtitle,
              ),
              onTap: () {
                 showModalBottomSheet(
                   shape: OutlineInputBorder(
                     borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                   ),
                    context: context,
                    builder: (context) {

                     if (widget.todoList.isEmpty) return Container();

                      return Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 8, left: 40, right: 40, bottom: 24),
                            child: Center(
                              child: ListTile(
                                title: Text(
                              widget.todoList[index].content,
                              style: Theme.of(context).textTheme.title,
                              maxLines: 3,
                                ),
                                trailing: Text(
                              widget.todoList[index].displayDeadline,
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
                                      bloc.deleteToDo(widget.todoList[index]);
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
                                    child: Text( widget.todoList[index].isDone ? "未完了" : "完了",
                                      style: Theme.of(context)
                                          .textTheme
                                          .button
                                          .apply(fontWeightDelta: 2),
                                    ),
                                    onPressed: () {
                                      var todo = widget.todoList[index];
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
      },
    );
  }
}
