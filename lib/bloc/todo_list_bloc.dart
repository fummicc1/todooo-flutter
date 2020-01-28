import 'dart:async';
import 'package:todooo/data/local_storage_client.dart';
import 'package:todooo/data/todo.dart';

class ToDoListBloc {

  final LocalStorageRepository localStorageRepository;

  StreamController<List<ToDo>> _controller = StreamController();
  Stream<List<ToDo>> get todoListStream => _controller.stream;

  ToDoListBloc(this.localStorageRepository) {
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