import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/states/home_state.dart';
import 'package:todooo/ui/providers/user_repository_provider.dart';
import 'package:todooo/viewmodels/home_viewmodel.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  final userRepo = ref.read(userRepositoryProvider);
  return HomeViewModel(userRepo, user: null);
});