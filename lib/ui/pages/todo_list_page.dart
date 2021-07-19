import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/states/add_todo_state.dart';
import 'package:todooo/states/app_state.dart';
import 'package:todooo/states/todo_list_state.dart';
import 'package:todooo/ui/components/todo_list_cell.dart';
import 'package:todooo/ui/pages/add_todo_page.dart';

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  late ScrollController _scrollController;

  Size topLeftCircleSize = Size(200, 240);

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    _scrollController.addListener(() {
      topLeftCircleSize = Size(200 + _scrollController.position.pixels * 0.3,
          200 + _scrollController.position.pixels * 0.3);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final ToDoListState toDoListState = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(children: [
          Positioned(
              left: -64,
              height: topLeftCircleSize.height,
              width: topLeftCircleSize.width,
              top: -80,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 96,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 48,
                        left: 0,
                        child: Text(toDoListState.pageTitle,
                            style: Theme.of(context).textTheme.headline4),
                      ),
                      Positioned(
                        top: 48,
                        right: 0,
                        height: 48,
                        child: IconButton(
                            icon: Icon(Icons.add, size: 32),
                            onPressed: () {
                              _moveToAddToDoPage(context);
                            }),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: toDoListState.todoList.isNotEmpty
                      ? ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: toDoListState.todoList.length,
                          itemBuilder: (context, index) {
                            final todo = toDoListState.todoList[index];
                            return ToDoListCell(toDo: todo);
                          })
                      : Center(
                          child: TextButton(
                            child: Text("最初のToDoを作成",
                                style: Theme.of(context).textTheme.headline6),
                            onPressed: () {
                              _moveToAddToDoPage(context);
                            },
                          ),
                        ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  List<Widget> additionalWidgets(BuildContext context) {
    return [
      Positioned(
          right: -40,
          height: 200,
          width: 200,
          bottom: -80,
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(offset: Offset(0, 1), blurRadius: 2)],
                shape: BoxShape.circle,
                color: Theme.of(context).scaffoldBackgroundColor),
          )),
      Positioned(
          right: 32,
          bottom: 32,
          child: Wrap(
            children: [
              IconButton(
                icon: Icon(
                  Icons.calendar_today,
                  size: 56,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {},
              ),
              SizedBox(width: 16),
              IconButton(
                icon: Icon(
                  Icons.online_prediction,
                  size: 56,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {},
              )
            ],
          )),
    ];
  }

  void _moveToAddToDoPage(BuildContext context) {
    final AppState appState = Provider.of(context, listen: false);

    Navigator.of(context).push(MaterialPageRoute(
        settings: const RouteSettings(name: "/add_todo_page"),
        builder: (_) => ChangeNotifierProvider(
            create: (_) {
              final AppState appState = Provider.of(context, listen: false);
              return AddToDoState(
                  toDoRepository: appState.toDoRepository,
                  userID: appState.user!.uid,
                  pageTitle: "登録",
                  localNotificationService: appState.localNotificationService);
            },
            child: AddToDoPage())));
  }
}
