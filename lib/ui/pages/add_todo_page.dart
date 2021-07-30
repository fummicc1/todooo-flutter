import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/states/add_todo_state.dart';
import 'package:todooo/states/todo_list_state.dart';
import "package:timezone/timezone.dart" as tz;

class AddToDoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddToDoState addToDoState = Provider.of(context);
    final ToDoListState todoListState =
        Provider.of<ToDoListState>(context, listen: false);
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
                        child: Text(addToDoState.pageTitle,
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
                            onPressed: (addToDoState.isDataInputted
                                ? () async {
                                    try {
                                      final result =
                                          await addToDoState.createToDo(
                                              createDate: DateTime.now());
                                      if (result) {
                                        await todoListState.updateToDos();
                                        Navigator.of(context).pop();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text("保存に失敗しました。もう一度お試しください。"),
                                        ));
                                      }
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
                                : null)),
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
                    addToDoState.updateContent(content);
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
                      groupValue: addToDoState.deadline,
                      onChanged: (deadline) {
                        addToDoState
                            .updateSelectingDeadline(deadline as Deadline);
                      },
                    ),
                    RadioListTile(
                      title: Text("明日まで"),
                      value: Deadline.values[1],
                      groupValue: addToDoState.deadline,
                      onChanged: (deadline) {
                        addToDoState
                            .updateSelectingDeadline(deadline as Deadline);
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
                          addToDoState.updateNotificationDate(dateTime);
                        });
                      },
                      child: Row(
                        children: [
                          Text("通知時刻: "),
                          SizedBox(
                            width: 16,
                          ),
                          DateTextLabelIfNeeded(addToDoState.notificateDate)
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
                      groupValue: addToDoState.notificateDate != null,
                      onChanged: (shouldNotificate) {
                        onChangeNotificationRadioButton(context,
                            shouldNotificate: shouldNotificate as bool,
                            onSelectDate: (dateTime) {
                          addToDoState.updateNotificationDate(dateTime);
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("いいえ"),
                      value: false,
                      groupValue: addToDoState.notificateDate != null,
                      onChanged: (shouldNotificate) async {
                        onChangeNotificationRadioButton(context,
                            shouldNotificate: shouldNotificate as bool,
                            onSelectDate: (dateTime) {
                          addToDoState.updateNotificationDate(dateTime);
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
      final result = await DatePicker.showDateTimePicker(context,
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

  Widget DateTextLabelIfNeeded(tz.TZDateTime? dateTime) {
    if (dateTime == null) {
      return SizedBox.shrink();
    }
    final formattedDate = DateFormat.yMd().add_jm();
    return Text(formattedDate.format(dateTime));
  }
}
