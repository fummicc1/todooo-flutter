import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bloc/create_todo_bloc.dart';

class CreateToDoPage extends StatefulWidget {
  @override
  _CreateToDoPageState createState() => _CreateToDoPageState();
}

class _CreateToDoPageState extends State<CreateToDoPage> {
  @override
  Widget build(BuildContext context) {
    CreateToDoBloc bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("ToDoooを作成"),
      ),
      body: SafeArea(
        child: StreamBuilder<void>(
          stream: bloc.updateUIStream,
          builder: (context, _) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 24, right: 16, left: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "やることを決めよう",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onChanged: (text) {
                      bloc.contentTextSink.add(text);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, top: 24),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "期限",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                RadioListTile(
                  value: "today",
                  title: Text(
                    "今日まで",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  groupValue: bloc.deadlineRadioButton,
                  onChanged: (value) {
                    bloc.deadlineRadioButtonSink.add(value);
                  },
                ),
                RadioListTile(
                  value: "tomorrow",
                  title: Text(
                    "明日まで",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  groupValue: bloc.deadlineRadioButton,
                  onChanged: (value) {
                    bloc.deadlineRadioButtonSink.add(value);
                  },
                ),
                RadioListTile(
                  value: "everyday",
                  title: Text(
                    "毎日",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  groupValue: bloc.deadlineRadioButton,
                  onChanged: (value) {
                    bloc.deadlineRadioButtonSink.add(value);
                  },
                ),
                FlatButton(
                  child: Text(
                    "作成",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    bloc.saveButtonTapSink.add(null);
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
