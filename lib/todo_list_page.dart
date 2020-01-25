import 'package:flutter/material.dart';
import 'package:todooo/create_todo_page.dart';
import 'package:todooo/main.dart';
import 'package:todooo/repository/local_storage_client.dart';

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage>
    with SingleTickerProviderStateMixin {
  List<ToDo> todoList = [];
  List<TabChoice> choices = [
    TabChoice("All"),
    TabChoice("ToDooo"),
    TabChoice("Dooone"),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: choices.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    setState(() {
      _tabController.animateTo(newIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color firstColor = Color(0xFF5bc6ff);
    final Color secondColor = Color(0xFF4da7db);

    LocalStorageClient().getToDos().then((list) {
      setState(() {
        todoList = list;
      });
    });
    return Scaffold(
      backgroundColor: Color(0xFF55b9f3),
      appBar: AppBar(
        centerTitle: true,
        title: Text(choices[_tabController.index].name),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: Container(
              height: 48,
              alignment: Alignment.center,
              child: TabPageSelector(
                controller: _tabController,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xFF55b9f3),
            padding: EdgeInsets.all(16),
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                getContent(_tabController.index),
                getContent(_tabController.index),
                getContent(_tabController.index)
              ],
            )),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 24, right: 16),
        width: 64,
        height: 64,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(-5, -5),
                end: Alignment(5, 5),
                colors: [firstColor, secondColor]),
            borderRadius: BorderRadius.circular(145),
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF489dcf),
                  offset: Offset(10.0, 10.0),
                  blurRadius: 32,
                  spreadRadius: 4),
              BoxShadow(
                  color: Color(0xFF62d5ff),
                  offset: Offset(-10.0, -10.0),
                  blurRadius: 32,
                  spreadRadius: 4)
            ]),
        child: FloatingActionButton(
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

  Widget getContent(int tabIndex) {
    final Color firstColor = Color(0xFF5bc6ff);
    final Color secondColor = Color(0xFF4da7db);

    if (tabIndex == 0) {
      return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(-5, -5),
                    end: Alignment(5, 5),
                    colors: [firstColor, secondColor]),
                borderRadius: BorderRadius.circular(145),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF489dcf),
                      offset: Offset(3.0, 3.0),
                      blurRadius: 4,
                      spreadRadius: 1),
                  BoxShadow(
                      color: Color(0xFF62d5ff),
                      offset: Offset(-1.0, -1.0),
                      blurRadius: 4,
                      spreadRadius: 1)
                ]),
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
              trailing: FlatButton(
                child: todoList[index].isDone ? Text("未完了") : Text("完了"),
                onPressed: () {
                  final todo = todoList[index];
                  if (todo.isDone == true) {
                    todo.isDone = false;
                  } else {
                    todo.isDone = true;
                  }
                  LocalStorageClient()
                      .updateToDo(index: index, newToDo: todo)
                      .then((isSuccess) {
                    if (isSuccess) setState(() {});
                  });
                },
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}

class TabChoice {
  final String name;

  TabChoice(this.name);
}
