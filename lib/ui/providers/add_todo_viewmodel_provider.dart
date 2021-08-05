import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/states/add_todo_state.dart';
import 'package:todooo/ui/providers/local_notification_service_provider.dart';
import 'package:todooo/ui/providers/todo_repository_provider.dart';
import 'package:todooo/ui/providers/user_repository_provider.dart';
import 'package:todooo/viewmodels/add_todo_viewmodel.dart';

final addTodoViewModelProvider = StateNotifierProvider<AddTodoViewModel, AddTodoState>((ref) {
  final localNotificationService = ref.read(localNotificationServiceProvider);
  final todoRepository = ref.read(todoRepositoryProvider);
  final userRepository = ref.read(userRepositoryProvider);
  return AddTodoViewModel(todoRepository, userRepository, localNotificationService);
});