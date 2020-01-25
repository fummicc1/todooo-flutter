import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todooo/main.dart';

class LocalStorageClient {

  Future<List<ToDo>> getToDos() async {

    final shared = await SharedPreferences.getInstance();

    final keys = shared.getKeys();
    if (!keys.contains("todo_list")) {
      return Future.value([]);
    }

    final memosJsonData = shared.get("todo_list");
    if (memosJsonData == null) return Future.value([]);

    final List<dynamic> memosMap = json.decode(memosJsonData) as List<dynamic>;

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

  Future<bool> deleteToDo(ToDo todo) async {
    final shared = await SharedPreferences.getInstance();
    final todoList = await getToDos();
    todoList.remove(todo);
    List<Map<String, dynamic>> _json = todoList.map((todo) => todo.json).toList();
    String jsonData = json.encode(_json);
    return shared.setString("todo_list", jsonData);
  }
  Future<bool> updateToDo({int index, ToDo newToDo}) async {
    final shared = await SharedPreferences.getInstance();
    final todoList = await getToDos();
    todoList.removeAt(index);
    todoList.add(newToDo);
    List<Map<String, dynamic>> _json = todoList.map((todo) => todo.json).toList();
    String jsonData = json.encode(_json);
    return shared.setString("todo_list", jsonData);
  }
}