import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/ui/providers/detail_todo_viewmodel_provider.dart';
import 'package:todooo/models/todo.dart';

class DetailTodoPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(detailTodoViewModelProvider);

    final textEditController = useTextEditingController();
    final focusNode = useFocusNode();
    final isFocusing = useState(false);

    focusNode.addListener(() {

    });

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                              state.isDone
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.check),
                                    )
                                  : Container(),
                              Flexible(
                                child: Text(
                                  state.content,
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
                          controller: textEditController,
                          toolbarOptions: ToolbarOptions(),
                          focusNode: focusNode,
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
                            ref.read(detailTodoViewModelProvider).copyWith(memo: memo);
                          },
                        ),
                        SizedBox(height: 32),
                        Text(
                          state.isOver
                              ? "目標の日時を過ぎています。"
                              : "${state.deadline.displayText}達成することを目標としています。",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.apply(fontWeightDelta: 2),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            Text("• 通知時刻"),
                            state.notificationDate != null
                                ? Text(
                                    "\t ${state.notificationDate}")
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
          if (focusNode.hasFocus) {
            return Container(
              margin: const EdgeInsets.only(bottom: 48),
              child: FloatingActionButton.extended(
                  backgroundColor: Theme.of(context).backgroundColor,
                  heroTag: "hero3",
                  onPressed: () {
                    ref.read(detailTodoViewModelProvider.notifier)
                        .updateMemo()
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
                    onPressed: () async {
                      await ref.read(detailTodoViewModelProvider.notifier).deleteTodo();
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: 32),
                  FloatingActionButton.extended(
                    backgroundColor: Theme.of(context).backgroundColor,
                    heroTag: "hero1",
                    icon: Icon(
                      state.isDone
                          ? Icons.restore
                          : Icons.check,
                      size: 24,
                      color: Colors.black,
                    ),
                    label: Text(
                      state.isDone ? "未完了に戻す" : "完了",
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.apply(color: Colors.black, fontWeightDelta: 2),
                    ),
                    onPressed: () async {
                      await ref.read(detailTodoViewModelProvider.notifier).toggleTodo();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.isDone
                            ? "完了済み"
                            : "未完了に戻しました"),
                      ));
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
