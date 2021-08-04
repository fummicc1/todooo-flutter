import 'package:freezed_annotation/freezed_annotation.dart';

part 'on_boarding_state.freezed.dart';

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState(
      {@Default("") String email,
      @Default("") String password,
      @Default("") String confirmPassword}) = _OnboardingState;
}
