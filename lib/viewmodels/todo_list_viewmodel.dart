import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/repositories/todo_repository.dart';
import 'package:todooo/states/todo_list_state.dart';

class TodoListViewModel extends StateNotifier<TodoListState> {

  final ToDoRepository _toDoRepository;

  TodoListViewModel(this._toDoRepository) : super( const TodoListState()) {
    _toDoRepository.listenTodoList(cache: false).listen((todoList) {
      if (hasListeners) {
        state = state.copyWith(todoList: todoList);
      }
    });
  }
}