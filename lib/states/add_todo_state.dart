import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todooo/models/todo.dart';

part 'add_todo_state.freezed.dart';

@freezed
abstract class AddTodoState with _$AddTodoState {
  const factory AddTodoState({
    @Default("") String content,
    @Default(false) bool isProcessing,
    @Default(Deadline.today) Deadline deadline,
    @Default(null) DateTime? createDate,
    @Default(null) DateTime? notificationDate,
  }) = _AddTodoState;
}
