import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/ui/components/todo_list_cell.dart';
import 'package:todooo/ui/pages/add_todo_page.dart';
import 'package:todooo/ui/providers/add_todo_viewmodel_provider.dart';
import 'package:todooo/ui/providers/todo_list_viewmodel_provider.dart';
import 'package:todooo/ui/providers/user_repository_provider.dart';

class TodoListPage extends HookConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final todoListState = ref.watch(todoListViewModelProvider);

    final scrollController = useScrollController();
    if (!scrollController.hasListeners) {
      scrollController.addListener(() {
        ref.read(todoListViewModelProvider.notifier).onScroll(scrollController.position.pixels);
      });
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Stack(children: [
        Positioned(
            left: -64,
            height: todoListState.topLeftCircleSize.height,
            width: todoListState.topLeftCircleSize.width,
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
                      child: Text("一覧",
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
                child: todoListState.todoList.isNotEmpty
                    ? ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: todoListState.todoList.length,
                    itemBuilder: (context, index) {
                      final todo = todoListState.todoList[index];
                      return ToDoListCell(todo: todo);
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
    Navigator.of(context).push(MaterialPageRoute(
        settings: const RouteSettings(name: "/add_todo_page"),
        fullscreenDialog: true,
        builder: (_) => AddTodoPage()));
  }
}
