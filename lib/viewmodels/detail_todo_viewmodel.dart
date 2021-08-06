import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/repositories/todo_repository.dart';
import 'package:todooo/repositories/user_repository.dart';
import 'package:todooo/states/detail_todo_state.dart';

class DetailTodoViewModel extends StateNotifier<DetailTodoState> {
  final ToDoRepository _toDoRepository;

  DetailTodoViewModel(this._toDoRepository,
      {required String? uid,
      required String content,
      required bool isDone,
      required bool isOver,
      required Deadline deadline,
      required String notificationDate})
      : super(DetailTodoState(
            todoId: uid,
            content: content,
            memo: "",
            deadline: deadline,
            isDone: isDone,
            isOver: isOver,
            notificationDate: notificationDate)) {
    setId(uid);
  }

  setId(String? uid) async {
    if (uid != null) {
      _toDoRepository.fetchToDo(uid: uid, preferCache: true).then((todo) {
        final String? notificationDateStr;
        if (todo.notificationDateTimeFromEpoch != null) {
          notificationDateStr = _convertDateTimeFromEpoch(
              timeInterval: todo.notificationDateTimeFromEpoch!);
        } else {
          notificationDateStr = null;
        }
        state = state.copyWith(
            todoId: uid,
            memo: todo.memo,
            content: todo.content,
            isDone: todo.isDone,
            isOver: todo.isOver,
            notificationDate: notificationDateStr,
            deadline: Deadline.values
                .firstWhere((element) => element.toString() == todo.deadline));
      });
    }
  }

  Future toggleTodo() async {
    final todoId = state.todoId;
    if (todoId == null) return;
    final todo =
        await _toDoRepository.fetchToDo(uid: todoId, preferCache: true);
    todo.isDone = !state.isDone;
    await _toDoRepository.updateToDo(todo);
    state = state.copyWith(isDone: todo.isDone);
  }

  Future updateMemo() async {
    final todoId = state.todoId;
    if (todoId == null) return;
    final todo =
        await _toDoRepository.fetchToDo(uid: todoId, preferCache: true);
    todo.memo = state.memo;
    await _toDoRepository.updateToDo(todo);
  }

  Future deleteTodo() async {
    final todoId = state.todoId;
    if (todoId == null) return;
    final todo =
        await _toDoRepository.fetchToDo(uid: todoId, preferCache: true);
    await _toDoRepository.deleteToDo(todo);
    state = state.copyWith(todoId: null);
  }

  String _convertDateTimeFromEpoch({required int timeInterval}) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeInterval);
    final format = DateFormat.yMd().add_jm();
    return format.format(dateTime);
  }
}
