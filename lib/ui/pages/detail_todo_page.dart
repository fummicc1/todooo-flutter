import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/states/detail_todo_state.dart';

class DetailToDoPage extends StatefulWidget {
  @override
  _DetailToDoPageState createState() => _DetailToDoPageState();
}

class _DetailToDoPageState extends State<DetailToDoPage> {
  @override
  Widget build(BuildContext context) {
    final DetailToDoState detailToDoState = Provider.of(context);
    return Scaffold(
      backgroundColor: detailToDoState.toDo.isOver
          ? Colors.grey
          : Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
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
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(Icons.check),
                                  )
                                : Container(),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: AutoSizeText(detailToDoState.toDo.content,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .apply(fontWeightDelta: 2)),
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
                                .apply(fontWeightDelta: 2),
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
                            .apply(fontWeightDelta: 2),
                      ),
                    ],
                  );
                },
              )),
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
                        .apply(fontWeightDelta: 2, color: Colors.black),
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
                    icon: Icon(Icons.delete, size: 24, color: Colors.redAccent),
                    label: Text(
                      "削除",
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .apply(fontWeightDelta: 2, color: Colors.redAccent),
                    ),
                    onPressed: () {
                      detailToDoState.deleteToDo().then((_) {
                        Navigator.of(context).pop();
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
                          .apply(color: Colors.black, fontWeightDelta: 2),
                    ),
                    onPressed: () {
                      detailToDoState.toggleToDo().then((_) {
                        Scaffold.of(context).showSnackBar(SnackBar(
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
}
