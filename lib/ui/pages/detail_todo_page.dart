import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todooo/states/detail_todo_state.dart';
import 'package:todooo/states/todo_list_state.dart';

class DetailToDoPage extends StatefulWidget {
  @override
  _DetailToDoPageState createState() => _DetailToDoPageState();
}

class _DetailToDoPageState extends State<DetailToDoPage> {
  @override
  Widget build(BuildContext context) {
    final DetailToDoState detailToDoState = Provider.of(context);
    final ToDoListState todoListState =
        Provider.of<ToDoListState>(context, listen: false);
    return Scaffold(
      backgroundColor: detailToDoState.toDo.isOver
          ? Colors.grey
          : Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Builder(
                  builder: (context) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 48),
                          height: 96,
                          child: Row(
                            children: <Widget>[
                              detailToDoState.toDo.isDone
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.check),
                                    )
                                  : Container(),
                              Flexible(
                                child: Text(
                                  detailToDoState.toDo.content,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.apply(fontWeightDelta: 2),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        TextField(
                          controller: detailToDoState.memoEditingController,
                          toolbarOptions: ToolbarOptions(),
                          focusNode: detailToDoState.focusNode,
                          maxLines: 7,
                          decoration: InputDecoration(
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.apply(fontWeightDelta: 2),
                              labelText: "フリースペース",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(24),
                              )),
                          onChanged: (memo) {
                            detailToDoState.editedMemo = memo;
                          },
                        ),
                        SizedBox(height: 32),
                        Text(
                          detailToDoState.toDo.isOver
                              ? "目標の日時を過ぎています。"
                              : "${detailToDoState.toDo.deadlineText}達成することを目標としています。",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.apply(fontWeightDelta: 2),
                        ),
                        SizedBox(height: 32,),
                        Row(
                          children: [
                            Text("• 通知時刻"),
                            detailToDoState
                                        .toDo.notificationDateTimeFromEpoch !=
                                    null
                                ? Text(
                                    "\t ${convertDateTimeFromEpoch(timeInterval: detailToDoState.toDo.notificationDateTimeFromEpoch!)}")
                                : Text("未設定")
                          ],
                        )
                      ],
                    );
                  },
                )),
          ),
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) {
          if (detailToDoState.focusNode.hasFocus) {
            return Container(
              margin: const EdgeInsets.only(bottom: 48),
              child: FloatingActionButton.extended(
                  backgroundColor: Theme.of(context).backgroundColor,
                  heroTag: "hero3",
                  onPressed: () {
                    detailToDoState
                        .updateMemo(detailToDoState.editedMemo)
                        .then((_) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("メモを更新しました"),
                      ));
                    });
                  },
                  label: Text(
                    "更新",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.apply(fontWeightDelta: 2, color: Colors.black),
                  ),
                  icon: Icon(
                    Icons.arrow_downward,
                    color: Colors.black,
                  )),
            );
          }
          return Container(
              margin: const EdgeInsets.only(bottom: 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton.extended(
                    backgroundColor: Theme.of(context).backgroundColor,
                    heroTag: "hero2",
                    icon: Icon(Icons.delete,
                        size: 24, color: Theme.of(context).primaryColor),
                    label: Text(
                      "削除",
                      style: Theme.of(context).textTheme.button?.apply(
                          fontWeightDelta: 2,
                          color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      detailToDoState.deleteToDo().then((_) {
                        todoListState.updateToDos().then((_) {
                          Navigator.of(context).pop();
                        });
                      });
                    },
                  ),
                  SizedBox(width: 32),
                  FloatingActionButton.extended(
                    backgroundColor: Theme.of(context).backgroundColor,
                    heroTag: "hero1",
                    icon: Icon(
                      detailToDoState.toDo.isDone ? Icons.restore : Icons.check,
                      size: 24,
                      color: Colors.black,
                    ),
                    label: Text(
                      detailToDoState.toDo.isDone ? "未完了に戻す" : "完了",
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.apply(color: Colors.black, fontWeightDelta: 2),
                    ),
                    onPressed: () {
                      detailToDoState.toggleToDo().then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(detailToDoState.toDo.isDone
                              ? "完了済み"
                              : "未完了に戻しました"),
                        ));
                      });
                    },
                  ),
                ],
              ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  String convertDateTimeFromEpoch({required int timeInterval}) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeInterval);
    final format = DateFormat.yMd().add_jm();
    return format.format(dateTime);
  }
}
