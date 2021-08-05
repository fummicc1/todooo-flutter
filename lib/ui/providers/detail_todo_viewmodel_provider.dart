import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/states/detail_todo_state.dart';
import 'package:todooo/ui/providers/todo_repository_provider.dart';
import 'package:todooo/ui/providers/user_repository_provider.dart';
import 'package:todooo/viewmodels/detail_todo_viewmodel.dart';

final detailTodoViewModelProvider =
    StateNotifierProvider<DetailTodoViewModel, DetailTodoState>((ref) {
  final todoRepo = ref.read(todoRepositoryProvider);
  final userRepo = ref.read(userRepositoryProvider);
  return DetailTodoViewModel(todoRepo, userRepo, uid: null, isDone: false, isOver: false, deadline: Deadline.today, notificationDate: "2021/4/2 15:00");
});
