import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/repositories/user_repository.dart';
import 'package:todooo/states/walkthrough_state.dart';

class WalkthroughViewModel extends StateNotifier<WalkthroughState> {

  final UserRepository _userRepository;

  WalkthroughViewModel(this._userRepository , {required bool isCompleteWalkThrough}) : super(WalkthroughState(isCompleteWalkThrough: isCompleteWalkThrough));

  Future updateIsCompleteWalkThrough({required bool isCompleteWalkthrough}) async {
    final current = await _userRepository.fetchUser(cache: true);
    if (current == null) {
      return Future.error("No Current User");
    }
    current.isCompleteWalkThrough = isCompleteWalkthrough;
    await _userRepository.updateUser(newUser: current);
    state = state.copyWith(isCompleteWalkThrough: isCompleteWalkthrough);
  }
}