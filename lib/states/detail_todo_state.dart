import 'package:flutter/cupertino.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/repositories/todo_repository.dart';
import 'package:todooo/services/local_notification_service.dart';

class DetailToDoState extends ChangeNotifier {
  ToDo toDo;
  String editedMemo;
  final FocusNode focusNode;
  final TextEditingController memoEditingController;
  final LocalNotificationService localNotificationService;
  final ToDoRepository toDoRepository;

  DetailToDoState(
      {required this.toDoRepository, required this.localNotificationService, required this.toDo, this.editedMemo = ""})
      : focusNode = FocusNode(),
        memoEditingController = TextEditingController() {
    focusNode.addListener(() {
      notifyListeners();
    });
    if (toDo.memo.isNotEmpty) {
      memoEditingController.text = toDo.memo;
    }
  }

  Future<void> deleteToDo() async {
    try {
      await toDoRepository.deleteToDo(toDo);
      await toDoRepository.fetchToDos(cache: false);
      if (toDo.notificationId != null) {
        await localNotificationService.deleteNotification(id: toDo.notificationId!);
      }
      return Future.value(null);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<void> toggleToDo() async {
    toDo.isDone = !toDo.isDone;
    try {
      await toDoRepository.updateToDo(this.toDo);
      final toDo = await toDoRepository.fetchToDo(uid: this.toDo.uid!);
      this.toDo = toDo;
      notifyListeners();
      return Future.value(null);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<void> updateMemo(String memo) async {
    toDo.memo = memo;
    try {
      await toDoRepository.updateToDo(this.toDo);
      final toDo = await toDoRepository.fetchToDo(uid: this.toDo.uid!);
      this.toDo = toDo;
      notifyListeners();
      return Future.value(null);
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  void dispose() {
    memoEditingController.dispose();
    super.dispose();
  }
}
