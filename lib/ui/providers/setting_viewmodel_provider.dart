import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/states/setting_state.dart';
import 'package:todooo/ui/providers/user_repository_provider.dart';
import 'package:todooo/viewmodels/setting_viewmodel.dart';

final settingViewModelProvider = StateNotifierProvider<SettingViewModel, SettingState>((ref) {
  final userRepo = ref.read(userRepositoryProvider);
  return SettingViewModel(userRepo);
});