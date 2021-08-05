
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/repositories/user_repository.dart';
import 'package:todooo/states/setting_state.dart';

class SettingViewModel extends StateNotifier<SettingState> {

  final UserRepository _userRepository;

  SettingViewModel(this._userRepository) : super (SettingState());

  Future deleteUser() async {
    await _userRepository.deleteUser();
  }
}