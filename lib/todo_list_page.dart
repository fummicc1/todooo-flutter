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
        child: Container(
          padding: EdgeInsets.all(16),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 60,
                child: Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        todoList[index].content,
                        maxLines: 3,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      subtitle: Text(
                        todoList[index].displayDeadline,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 24, right: 16),
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
