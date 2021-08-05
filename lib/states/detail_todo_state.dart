import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todooo/models/todo.dart';

part 'detail_todo_state.freezed.dart';

@freezed
abstract class DetailTodoState with _$DetailTodoState {
  const factory DetailTodoState(
      {required String? todoId,
      required String memo,
      required bool isDone,
      required Deadline deadline,
        required String? notificationDate,
      required bool isOver}) = _DetailTodoState;
}
