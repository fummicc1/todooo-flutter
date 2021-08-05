import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/states/walkthrough_state.dart';
import 'package:todooo/ui/providers/user_repository_provider.dart';
import 'package:todooo/viewmodels/walkthrough_viewmodel.dart';

final walkThroughViewModelProvider = StateNotifierProvider<WalkthroughViewModel, WalkthroughState>((ref) {
  final userRepo = ref.read(userRepositoryProvider);
  return WalkthroughViewModel(userRepo, isCompleteWalkThrough: false);
});