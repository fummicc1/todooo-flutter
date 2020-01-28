
import 'package:todooo/data/local_storage_client.dart';
import 'package:todooo/data/todo.dart';

class LocalStorageClientMock with LocalStorageRepository {

  List<ToDo> todoList = [];

  @override
  Future<bool> deleteToDo(ToDo toDo) {
    int index = todoList.indexWhere((todo) => toDo.createDate == toDo.createDate);
    if (index == null) return Future.value(false);
    todoList.removeAt(index);
    return Future.value(true);
  }

  @override
  Future<List<ToDo>> getToDos() {
    return Future.value(todoList);
  }

  @override
  Future<bool> saveToDo(ToDo toDo) {
    int index = todoList.indexWhere((todo) => toDo.createDate == toDo.createDate);
    if (index != null) return Future.value(false);
    todoList.add(toDo);
    return Future.value(true);
  }

  @override
  Future<bool> updateToDo(ToDo toDo) {
    throw UnimplementedError();
  }
}