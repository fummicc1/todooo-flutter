import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:todooo/data/local_storage_client.dart';
import 'package:todooo/data/todo.dart';

class CreateToDoBloc {
  final LocalStorageRepository _repository;

  StreamController<void> _saveButtonTapController = StreamController();
  Sink<void> get saveButtonTapSink => _saveButtonTapController.sink;

  BehaviorSubject<String> _contentTextController = BehaviorSubject();
  Sink<String> get contentTextSink => _contentTextController.sink;
  BehaviorSubject<String> _deadlineRadioButtonController = BehaviorSubject();
  Sink<String> get deadlineRadioButtonSink =>
      _deadlineRadioButtonController.sink;
  String get deadlineRadioButton => _deadlineRadioButtonController.value;

  StreamController<void> _updateUIStreamController = StreamController();
  Stream<void> get updateUIStream => _updateUIStreamController.stream;

  CreateToDoBloc(this._repository) {
    _saveButtonTapController.stream.listen((_) async {
      ToDo toDo = ToDo(_contentTextController.value,
          _deadlineRadioButtonController.value, DateTime.now());
      await createToDo(toDo);
    });

    Stream stream = CombineLatestStream.combine2(
        _contentTextController.stream.shareValueSeeded(""),
        _deadlineRadioButtonController.stream.shareValueSeeded(""),
        (a, b) => null);
    _updateUIStreamController.addStream(stream);
  }

  Future<bool> createToDo(ToDo todo) {
    if (todo.content.isEmpty || todo.isDone || todo.isOver || todo.deadline.isEmpty)
      return Future.value(false);
    return _repository.saveToDo(todo);
  }

  void dispose() {
    _updateUIStreamController.close();
    _saveButtonTapController.close();
    _contentTextController.close();
    _deadlineRadioButtonController.close();
  }
}
