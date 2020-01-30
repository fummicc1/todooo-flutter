import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/bloc/todo_list_bloc.dart';
import 'package:todooo/ui/pages/create_todo_page.dart';
import 'package:todooo/ui/widgets/list_widget.dart';
import 'package:todooo/data/todo.dart';
import 'package:todooo/ui/widgets/todo_cell_widget.dart';

import '../../bloc/create_todo_bloc.dart';
import '../../bloc/create_todo_bloc.dart';
import '../../data/local_storage_client.dart';

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  String getAppbarTitle() {
    if (_tabController.index == 0) {
      return "今日中";
    } else if (_tabController.index == 1) {
      return "明日まで";
    } else if (_tabController.index == 2) {
      return "毎日";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    ToDoListBloc bloc = Provider.of(context);
    return StreamBuilder<List<ToDo>>(
        stream: bloc.todoListStream,
        initialData: [],
        builder: (context, snapshot) {
          final todoList = snapshot.data;

          final sortHotToDoList =
              todoList.where((todo) => todo.deadline == "today").toList();
          sortHotToDoList.sort((pre, next) => pre
              .createDate.millisecondsSinceEpoch
              .compareTo(next.createDate.millisecondsSinceEpoch));

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                getAppbarTitle(),
                style: Theme.of(context).textTheme.headline4,
              ),
              leading: Container(),
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(40),
                  child: Theme(
                    data: Theme.of(context).copyWith(accentColor: Colors.white),
                    child: Container(
                      height: 40,
                      child: TabPageSelector(
                        controller: _tabController,
                      ),
                    ),
                  )),
              actions: <Widget>[
                FlatButton(
                  child: Icon(
                    Icons.add,
                    size: 48,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Provider<CreateToDoBloc>(
                          create: (_) => CreateToDoBloc(LocalStorageClient()),
                          dispose: (_, _bloc) {
                            bloc.updateTodoListSink.add(null);
                            _bloc.dispose();
                          },
                          child: CreateToDoPage()),
                    ));
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  sortHotToDoList == null || sortHotToDoList.isEmpty
                      ? Container(
                    height: 64,
                          child: Center(
                            child: Text(
                            "ここには期限が近いToDoが表示されます",
                            style: Theme.of(context).textTheme.caption.apply(fontWeightDelta: 3, fontSizeDelta: 1.5),
                        ),
                          ))
                      : Material(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
                    elevation: 8,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(16),
                              alignment: Alignment.centerLeft,
                              child: Text("直近のToDo"),
                            ),
                            ToDoCellWidget(sortHotToDoList.first),
                          ],
                        ),
                      ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                      padding: EdgeInsets.all(16),
                      child: TabBarView(controller: _tabController, children: [
                        ListWidget(todoList
                            .where((todo) =>
                                todo.deadline == "today" && !todo.isOver)
                            .toList()),
                        ListWidget(todoList
                            .where((todo) =>
                                todo.deadline == "tomorrow" && !todo.isOver)
                            .toList()),
                        ListWidget(todoList
                            .where((todo) =>
                                todo.deadline == "everyday" && !todo.isOver)
                            .toList()),
                      ])),
                ],
              ),
            ),
          );
        });
  }
}
