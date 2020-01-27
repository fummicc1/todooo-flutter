import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/data/todo.dart';
import '../bloc/bloc.dart';
import '../data/local_storage_client.dart';

class ListPage extends StatefulWidget {
  final List<ToDo> todoList;


  ListPage(this.todoList);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  PersistentBottomSheetController _bottomSheet;

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
              leading: widget.todoList[index].isOver ? Text("x", style: Theme.of(context).textTheme.title.apply(color: Theme.of(context).primaryColor),) : null,
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
                _bottomSheet = showBottomSheet(context: context, builder: (context) {
                  return Container(
                    height: 240,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8, spreadRadius: 4, color: Colors.grey[300]
                              )
                            ]
                          ),
                          margin: EdgeInsets.only(top: 24, right: 40, left: 40),
                          width: 160,
                          height: 64,
                          child: FlatButton(
                            child: Text("完了", style: Theme.of(context).textTheme.button.apply(fontWeightDelta: 2),),
                            onPressed: () {
                              var todo = widget.todoList[index];
                              todo.isDone = !todo.isDone;
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8, spreadRadius: 4, color: Colors.grey[300]
                              )
                            ]
                          ),
                          margin: EdgeInsets.only(top: 24, right: 40, left: 40, bottom: 24),
                          width: 160,
                          height: 64,
                          child: FlatButton(
                            child: Text("削除", style: Theme.of(context).textTheme.button.apply(fontWeightDelta: 2),),
                            onPressed: () {
                              bloc.deleteToDo(widget.todoList[index]);
                              _bottomSheet.close();
                            },
                          ),
                        ),
                      ],
                    ),
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
