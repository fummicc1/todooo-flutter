import 'package:freezed_annotation/freezed_annotation.dart';

part 'walkthrough_state.freezed.dart';

@freezed
abstract class WalkthroughState with _$WalkthroughState {
  const factory WalkthroughState({@Default(false) isCompleteWalkThrough}) =
      _WalkthroughState;
}
