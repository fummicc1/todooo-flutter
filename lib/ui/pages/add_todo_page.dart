import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/ui/providers/add_todo_viewmodel_provider.dart';

class AddTodoPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final addTodoState = ref.watch(addTodoViewModelProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 96,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 48,
                        left: 0,
                        child: Text("登録",
                            style: Theme.of(context).textTheme.headline4),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        height: 48,
                        child: BackButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        height: 48,
                        child: IconButton(
                            icon: Icon(Icons.create, size: 32),
                            onPressed: addTodoState.content.isNotEmpty
                                ? () async {
                              try {
                                await ref.read(addTodoViewModelProvider.notifier).create();
                                Navigator.of(context).pop();
                              } catch (error) {
                                if (error == "Processing") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                      content:
                                      Text("処理中ですので少しお待ちください。")));
                                  return;
                                }
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("保存に失敗しました。もう一度お試しください。"),
                                ));
                              }
                            }
                                : null),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: "なにをしますか？",
                  ),
                  onChanged: (content) {
                    ref.watch(addTodoViewModelProvider.notifier).updateContent(content);
                  },
                ),
                SizedBox(height: 48),
                Text("いつまでにやりますか？",
                    style: Theme.of(context).textTheme.subtitle1),
                Wrap(
                  children: <Widget>[
                    RadioListTile(
                      title: Text("今日中"),
                      value: Deadline.values[0],
                      groupValue: addTodoState.deadline,
                      onChanged: (deadline) {
                        ref.watch(addTodoViewModelProvider.notifier)
                            .updateDeadline(deadline as Deadline);
                      },
                    ),
                    RadioListTile(
                      title: Text("明日まで"),
                      value: Deadline.values[1],
                      groupValue: addTodoState.deadline,
                      onChanged: (deadline) {
                        ref.watch(addTodoViewModelProvider.notifier)
                            .updateDeadline(deadline as Deadline);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  "通知をする",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Theme.of(context).colorScheme.primary))),
                    child: InkWell(
                      onTap: () {
                        onChangeNotificationRadioButton(context,
                            shouldNotificate: true, onSelectDate: (dateTime) {
                              ref.watch(addTodoViewModelProvider.notifier).updateNotificationDate(dateTime);
                            });
                      },
                      child: Row(
                        children: [
                          Text("通知時刻: "),
                          SizedBox(
                            width: 16,
                          ),
                          DateTextLabelIfNeeded(addTodoState.notificationDate)
                        ],
                      ),
                    ),
                  ),
                ),
                Wrap(
                  children: <Widget>[
                    RadioListTile(
                      title: Text("はい"),
                      value: true,
                      groupValue: addTodoState.notificationDate != null,
                      onChanged: (shouldNotificate) {
                        onChangeNotificationRadioButton(context,
                            shouldNotificate: shouldNotificate as bool,
                            onSelectDate: (dateTime) {
                              ref.watch(addTodoViewModelProvider.notifier).updateNotificationDate(dateTime);
                            });
                      },
                    ),
                    RadioListTile(
                      title: Text("いいえ"),
                      value: false,
                      groupValue: addTodoState.notificationDate != null,
                      onChanged: (shouldNotificate) async {
                        onChangeNotificationRadioButton(context,
                            shouldNotificate: shouldNotificate as bool,
                            onSelectDate: (dateTime) {
                              ref.watch(addTodoViewModelProvider.notifier).updateNotificationDate(dateTime);
                            });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  onChangeNotificationRadioButton(BuildContext context,
      {required bool shouldNotificate,
        required Function(DateTime?) onSelectDate}) async {
    if (shouldNotificate) {
      await DatePicker.showDateTimePicker(context,
          showTitleActions: true,
          minTime: DateTime.now(),
          maxTime: DateTime(2025),
          locale: LocaleType.jp, onConfirm: (dateTime) {
            onSelectDate(dateTime);
          });
    } else {
      onSelectDate(null);
    }
  }

  Widget DateTextLabelIfNeeded(DateTime? dateTime) {
    if (dateTime == null) {
      return SizedBox.shrink();
    }
    final formattedDate = DateFormat.yMd().add_jm();
    return Text(formattedDate.format(dateTime));
  }
}