import 'dart:async';

import 'package:todooo/data/local_storage_client.dart';
import 'package:todooo/data/todo.dart';

class Bloc {
  StreamController<List<ToDo>> _controller = StreamController();
  Stream<List<ToDo>> get todoListStream => _controller.stream;

  Bloc() {
    LocalStorageClient().getToDos().then((list) {
      _controller.add(list);
    });
  }

  void deleteToDo(ToDo toDo) {
    LocalStorageClient().deleteToDo(toDo).then((_) {
      LocalStorageClient().getToDos().then((list) {
        _controller.add(list);
      });
    });
  }

  void createToDo(ToDo toDo) {
    LocalStorageClient().saveToDo(toDo).then((_) {
      LocalStorageClient().getToDos().then((list) {
        _controller.add(list);
      });
    });
  }

  void dispose() {
    _controller.close();
  }
}