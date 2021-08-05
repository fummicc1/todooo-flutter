import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/models/user.dart';
import 'package:todooo/repositories/user_repository.dart';
import 'package:todooo/states/home_state.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  final UserRepository _userRepository;

  HomeViewModel(this._userRepository, {required AppUser? user})
      : super(HomeState(user: user)) {
    _userRepository.listenUser().listen((user) {
      state = state.copyWith(user: user);
    });
  }
}
