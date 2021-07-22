import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todooo/repositories/user_repository.dart';

class OnBoardingState extends ChangeNotifier {


  final UserRepository _userRepository;

  OnBoardingState(this._userRepository);

  String? email = null;
  String? password = null;
  String? confirmPassword = null;

  signInAsGuest() async {
    await _userRepository.signInAnonymously();
  }

  signInWithEmail() async {
    final email = this.email;
    final password = this.password;
    if (email == null || password == null) {
      return;
    }
    await _userRepository.signInWithEmail(email: email, password: password);
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
    return await _userRepository.signUpWithEmail(email: email, password: password);
  }
}