import 'package:flutter/cupertino.dart';
import 'package:todooo/repositories/user_repository.dart';

class SettingState extends ChangeNotifier {

  final UserRepository userRepository;

  SettingState({required this.userRepository});

  Future deleteUser() => userRepository.deleteUser();

}