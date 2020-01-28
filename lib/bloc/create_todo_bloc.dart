import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:todooo/data/local_storage_client.dart';
import 'package:todooo/data/todo.dart';

class CreateToDoBloc {

  final LocalStorageRepository _repository;

  BehaviorSubject<bool> _isPersistingSubject = BehaviorSubject();
  Stream<bool> get isPersisting => _isPersistingSubject.stream;

  StreamController<void> _saveButtonTapController = StreamController();
  Sink<void> get saveButtonTapSink => _saveButtonTapController.sink;

  BehaviorSubject<String> _contentTextController = BehaviorSubject();
  Sink<String> get contentTextStream => _contentTextController.sink;
  BehaviorSubject<String> _deadlineRadioButtonController = BehaviorSubject();
  Sink<String> get deadlineRadioButtonSink => _deadlineRadioButtonController.sink;

  CreateToDoBloc(this._repository) {
    _saveButtonTapController.stream.listen((_) async {
      _isPersistingSubject.add(true);
      ToDo toDo = ToDo(_contentTextController.value, _deadlineRadioButtonController.value, DateTime.now());
      await createToDo(toDo);
      _isPersistingSubject.add(false);
    });
  }

  Future<bool> createToDo(ToDo todo) {
    if (todo.content.isEmpty || todo.isDone || todo.isOver) return Future.value(false);
    return _repository.saveToDo(todo);
  }
}