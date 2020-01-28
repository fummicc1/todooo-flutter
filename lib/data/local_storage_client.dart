import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo.dart';

mixin LocalStorageRepository {
  Future<List<ToDo>> getToDos();
  Future<bool> saveToDo(ToDo toDo);
  Future<bool> updateToDo(ToDo toDo);
  Future<bool> deleteToDo(ToDo toDo);
}

class LocalStorageClient with LocalStorageRepository {

  Future<List<ToDo>> getToDos() async {

    final shared = await SharedPreferences.getInstance();

    final keys = shared.getKeys();
    if (!keys.contains("todo_list")) {
      return Future.value([]);
    }

    final todosJSONData = shared.get("todo_list");
    if (todosJSONData == null) return Future.value([]);

    final List<dynamic> memosMap = json.decode(todosJSONData) as List<dynamic>;

    List<ToDo> todoList = [];

    for (int i = 0; i < memosMap.length; i++) {
      final ToDo todo = ToDo.fromJSON(memosMap[i] as Map<String, dynamic>);
      todoList.add(todo);
    }
    return todoList;
  }

  Future<bool> saveToDo(ToDo todo) async {
    final shared = await SharedPreferences.getInstance();
    final todoList = await getToDos();
    todoList.add(todo);
    List<Map<String, dynamic>> _json = todoList.map((todo) => todo.json).toList();
    String jsonData = json.encode(_json);
    return shared.setString("todo_list", jsonData);
  }

  Future<bool> updateToDo(ToDo todo) async {
    final shared = await SharedPreferences.getInstance();
    final todoList = await getToDos();
    var index = todoList.indexWhere((element) => element.createDate == todo.createDate);
    print(index);
    todoList.removeAt(index);
    todoList.add(todo);
    List<Map<String, dynamic>> _json = todoList.map((todo) => todo.json).toList();
    String jsonData = json.encode(_json);
    return shared.setString("todo_list", jsonData);
  }

  Future<bool> deleteToDo(ToDo todo) async {
    final shared = await SharedPreferences.getInstance();
    final todoList = await getToDos();
    var index = todoList.indexWhere((element) => element.createDate == todo.createDate);
    print(index);
    todoList.removeAt(index);
    List<Map<String, dynamic>> _json = todoList.map((todo) => todo.json).toList();
    String jsonData = json.encode(_json);
    print(jsonData);
    return shared.setString("todo_list", jsonData);
  }
}