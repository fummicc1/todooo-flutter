import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/ui/providers/todo_repository_provider.dart';
import 'package:todooo/viewmodels/detail_todo_viewmodel.dart';

final detailTodoViewModelProvider =
    Provider<DetailTodoViewModel>((ref) {
  final todoRepo = ref.read(todoRepositoryProvider);
  return DetailTodoViewModel(todoRepo, uid: null, isDone: false);
});
