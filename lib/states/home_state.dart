import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todooo/models/user.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({@Default(null) AppUser? user}) = _HomeState;
}
