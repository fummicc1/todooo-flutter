import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/repositories/todo_repository.dart';
import 'package:todooo/repositories/user_repository.dart';
import 'package:todooo/states/detail_todo_state.dart';

class DetailTodoViewModel extends StateNotifier<DetailTodoState> {
  final ToDoRepository _toDoRepository;
  final UserRepository _userRepository;

  DetailTodoViewModel(this._toDoRepository, this._userRepository,
      {required String? uid,
        required bool isDone,
        required bool isOver,
        required Deadline deadline,
        required String notificationDate})
      : super(DetailTodoState(
      todoId: uid,
      memo: "",
      deadline: deadline,
      isDone: isDone,
      isOver: isOver,
      notificationDate: notificationDate)) {
    setId(uid);
  }

  setId(String? uid) async {
    if (uid != null) {
      final user = await _userRepository.fetchUser(cache: true);
      _toDoRepository.fetchToDo(userID: user!.uid, uid: uid, preferCache: true).then((todo) {
        final String? notificationDateStr;
        if (todo.notificationDateTimeFromEpoch != null) {
          notificationDateStr = _convertDateTimeFromEpoch(
              timeInterval: todo.notificationDateTimeFromEpoch!);
        } else {
          notificationDateStr = null;
        }
        state = state.copyWith(
            memo: todo.memo,
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
    final user = await _userRepository.fetchUser(cache: true);
    final todo =
    await _toDoRepository.fetchToDo(userID: user!.uid, uid: todoId, preferCache: true);
    todo.isDone = !state.isDone;
    await _toDoRepository.updateToDo(user.uid, todo);
    state = state.copyWith(isDone: todo.isDone);
  }

  Future updateMemo(String memo) async {
    final todoId = state.todoId;
    if (todoId == null) return;
    final user = await _userRepository.fetchUser(cache: true);
    final todo =
    await _toDoRepository.fetchToDo(userID: user!.uid, uid: todoId, preferCache: true);
    todo.memo = memo;
    await _toDoRepository.updateToDo(user.uid, todo);
    state = state.copyWith(memo: memo);
  }

  Future deleteTodo() async {
    final user = await _userRepository.fetchUser(cache: true);
    final todoId = state.todoId;
    if (todoId == null) return;
    final todo =
    await _toDoRepository.fetchToDo(userID: user!.uid, uid: todoId, preferCache: true);
    await _toDoRepository.deleteToDo(user.uid, todo);
    state = state.copyWith(todoId: null);
  }

  String _convertDateTimeFromEpoch({required int timeInterval}) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeInterval);
    final format = DateFormat.yMd().add_jm();
    return format.format(dateTime);
  }
}
