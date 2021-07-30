import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todooo/models/user.dart';
import 'package:todooo/repositories/user_repository.dart';

class OnBoardingState extends ChangeNotifier {


  final UserRepository _userRepository;

  OnBoardingState(this._userRepository);

  String? email;
  String? password;
  String? confirmPassword;

  signInAsGuest() async {
    final user = await _userRepository.signInAnonymously();
    await _userRepository.createUser(user: user);
  }

  signInWithEmail() async {
    final email = this.email;
    final password = this.password;
    if (email == null || password == null) {
      return;
    }
    final user = await _userRepository.signInWithEmail(email: email, password: password);
    final AppUser? appUser = await _userRepository.fetchUser(cache: false);
    if (appUser == null) {
      await _userRepository.createUser(user: user);
    } else {
      appUser.signedInAt = user.metadata.lastSignInTime;
      await await _userRepository.updateUser(newUser: appUser);
    }
  }

  Future signUpWithEmail() async {
    final email = this.email;
    final password = this.password;
    if (email == null || password == null) {
      return;
    }
    if (confirmPassword != password) {
      return Future.error("入力されたパスワードが一致しません");
    }
    final user = await _userRepository.signUpWithEmail(email: email, password: password);
    await _userRepository.createUser(user: user);
    return user;
  }
}