import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/models/user.dart';
import 'package:todooo/repositories/user_repository.dart';
import 'package:todooo/states/on_boarding_state.dart';

class OnboardingViewModel extends StateNotifier<OnboardingState> {
  final UserRepository _userRepository;

  OnboardingViewModel(this._userRepository,
      {required String email,
      required String password,
      required String confirmPassword})
      : super(OnboardingState(
            email: email,
            password: password,
            confirmPassword: confirmPassword));

  signInAsGuest() async {
    try {
      final user = await _userRepository.signInAnonymously();
      await _userRepository.createUser(user: user);
    } catch (e) {
      print(e);
    }
  }

  signInWithEmail() async {
    final email = state.email;
    final password = state.password;
    if (email.isEmpty || password.isEmpty) {
      return;
    }
    final user =
        await _userRepository.signInWithEmail(email: email, password: password);
    final AppUser? appUser = await _userRepository.fetchUser(cache: false);
    if (appUser == null) {
      await _userRepository.createUser(user: user);
    } else {
      appUser.signedInAt = user.metadata.lastSignInTime;
      await await _userRepository.updateUser(newUser: appUser);
    }
  }

  Future signUpWithEmail() async {
    final email = state.email;
    final password = state.password;
    if (email.isEmpty || password.isEmpty) {
      return;
    }
    if (state.confirmPassword != password) {
      return Future.error("入力されたパスワードが一致しません");
    }
    final user =
        await _userRepository.signUpWithEmail(email: email, password: password);
    await _userRepository.createUser(user: user);
    return user;
  }

  updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword);
  }
}
