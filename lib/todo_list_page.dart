import 'package:flutter/material.dart';
import 'package:todooo/create_todo_page.dart';
import 'package:todooo/main.dart';
import 'package:todooo/repository/local_storage_client.dart';

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<ToDo> todoList = [];

  @override
  Widget build(BuildContext context) {

    LocalStorageClient().getToDos().then((list) {
      setState(() {
        todoList = list;
      });
    });
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
                      title: Text(
                        todoList[index].content,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateToDoPage(),
            ));
          },
        ),
      ),
    );
  }
}
