import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/states/todo_list_state.dart';
import 'package:todooo/ui/providers/todo_repository_provider.dart';
import 'package:todooo/viewmodels/todo_list_viewmodel.dart';

final todoListViewModelProvider = Provider<TodoListViewModel>((ref) {
  final todoRepo = ref.read(todoRepositoryProvider);
  return TodoListViewModel(todoRepo);
});