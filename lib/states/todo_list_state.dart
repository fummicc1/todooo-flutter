
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todooo/models/todo.dart';

part 'todo_list_state.freezed.dart';

@freezed
abstract class TodoListState with _$TodoListState {
  const factory TodoListState({ @Default([]) List<Todo> todoList }) = _TodoListState;
}