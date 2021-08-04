import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/repositories/todo_repository.dart';
import 'package:todooo/states/detail_todo_state.dart';

class DetailTodoViewModel extends StateNotifier<DetailTodoState> {
  final ToDoRepository _toDoRepository;

  DetailTodoViewModel(this._toDoRepository, {required String? uid, required bool isDone})
      : super(DetailTodoState(
            todoId: uid, editMemo: "", isDone: isDone));

  Future toggleTodo() async {
    final todoId = state.todoId;
    if (todoId == null) return;
    final todo = await _toDoRepository.fetchToDo(uid: todoId, preferCache: true);
    todo.isDone = !state.isDone;
    await _toDoRepository.updateToDo(todo);
    state = state.copyWith(isDone: todo.isDone);
  }

  Future updateMemo(String memo) async {
    final todoId = state.todoId;
    if (todoId == null) return;
    final todo = await _toDoRepository.fetchToDo(uid: todoId, preferCache: true);
    todo.memo = memo;
    await _toDoRepository.updateToDo(todo);
    state = state.copyWith(editMemo: memo);
  }

  Future deleteTodo() async {
    final todoId = state.todoId;
    if (todoId == null) return;
    final todo = await _toDoRepository.fetchToDo(uid: todoId, preferCache: true);
    await _toDoRepository.deleteToDo(todo);
    state = state.copyWith(todoId: null);
  }
}
