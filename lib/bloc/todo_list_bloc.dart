import 'dart:async';
import 'package:rxdart/subjects.dart';
import 'package:todooo/data/local_storage_client.dart';
import 'package:todooo/data/todo.dart';

class ToDoListBloc {

  final LocalStorageRepository localStorageRepository;

  BehaviorSubject<List<ToDo>> _controller = BehaviorSubject();
  Stream<List<ToDo>> get todoListStream => _controller.stream;
  BehaviorSubject<void> _updateToDoListController = BehaviorSubject();
  Sink<void> get updateTodoListSink => _updateToDoListController.sink;

  ToDoListBloc(this.localStorageRepository) {
    _getToDoList();
    _updateToDoListController.listen((_) {
      _getToDoList();
    });
  }

  void _getToDoList() {
    localStorageRepository.getToDos().then((list) {
      _controller.add(list);
    });
  }

  Future<bool> deleteToDo(ToDo toDo) async {
    var result = await localStorageRepository.deleteToDo(toDo);
    if (result) {
      var list = await localStorageRepository.getToDos();
      _controller.add(list);
    }
    return Future.value(result);
  }

  Future<bool> createToDo(ToDo toDo) async {
    var result = await localStorageRepository.saveToDo(toDo);
    if (result) {
      var list = await localStorageRepository.getToDos();
      _controller.add(list);
    }
    return Future.value(result);
  }

  Future<bool> updateToDo(ToDo toDo) async {
    var result = await localStorageRepository.updateToDo(toDo);
    if (result) {
      var list = await localStorageRepository.getToDos();
      _controller.add(list);
    }
    return Future.value(result);
  }

  void dispose() {
    _controller.close();
  }
}