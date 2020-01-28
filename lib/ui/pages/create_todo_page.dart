import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/bloc/todo_list_bloc.dart';
import 'package:todooo/data/todo.dart';

class CreateToDoPage extends StatefulWidget {
  @override
  _CreateToDoPageState createState() => _CreateToDoPageState();
}

class _CreateToDoPageState extends State<CreateToDoPage> {
  String _deadlineType;

  String _content;

  @override
  Widget build(BuildContext context) {

    ToDoListBloc bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("ToDoooを作成"),
      ),
      body: SafeArea(
        child: Column(
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
                  _content = text;
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
              groupValue: _deadlineType,
              onChanged: (value) {
                setState(() {
                  _deadlineType = value;
                });
              },
            ),
            RadioListTile(
              value: "tomorrow",
              title: Text(
                "明日まで",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              groupValue: _deadlineType,
              onChanged: (value) {
                setState(() {
                  _deadlineType = value;
                });
              },
            ),
            RadioListTile(
              value: "everyday",
              title: Text(
                "毎日",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              groupValue: _deadlineType,
              onChanged: (value) {
                setState(() {
                  _deadlineType = value;
                });
              },
            ),
            FlatButton(
              child: Text(
                "作成",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (_content.isEmpty || _deadlineType.isEmpty) return;
                final todo = ToDo(_content, _deadlineType, DateTime.now());
                print(bloc);
                bloc.createToDo(todo);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
