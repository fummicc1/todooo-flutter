import 'package:flutter/material.dart';
import 'package:todooo/main.dart';

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<ToDo> todoList = [
    ToDo("テスト1", DateTime(2020, 1, 27)),
    ToDo("テスト2", DateTime(2020, 1, 27)),
    ToDo("テスト3", DateTime(2020, 1, 27)),
    ToDo("テスト4", DateTime(2020, 1, 28)),
    ToDo("テスト5", DateTime(2020, 1, 28)),
    ToDo("テスト6", DateTime(2020, 1, 28)),
    ToDo("テスト7", DateTime(2020, 1, 29)),
    ToDo("テスト8", DateTime(2020, 1, 29)),
    ToDo("テスト9", DateTime(2020, 1, 29)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ToDooo"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 150,
                child: Card(
                  elevation: 4,
                    child: ListTile(
                  title: Text(todoList[index].content, style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
                )),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          elevation: 12,
          child: Icon(
            Icons.add,
            size: 48,
          ),
        ),
      ),
    );
  }
}
