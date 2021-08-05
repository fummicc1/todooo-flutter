// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'walkthrough_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$WalkthroughStateTearOff {
  const _$WalkthroughStateTearOff();

  _WalkthroughState call({dynamic isCompleteWalkThrough = false}) {
    return _WalkthroughState(
      isCompleteWalkThrough: isCompleteWalkThrough,
    );
  }
}

/// @nodoc
const $WalkthroughState = _$WalkthroughStateTearOff();

/// @nodoc
mixin _$WalkthroughState {
  dynamic get isCompleteWalkThrough => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalkthroughStateCopyWith<WalkthroughState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalkthroughStateCopyWith<$Res> {
  factory $WalkthroughStateCopyWith(
          WalkthroughState value, $Res Function(WalkthroughState) then) =
      _$WalkthroughStateCopyWithImpl<$Res>;
  $Res call({dynamic isCompleteWalkThrough});
}

/// @nodoc
class _$WalkthroughStateCopyWithImpl<$Res>
    implements $WalkthroughStateCopyWith<$Res> {
  _$WalkthroughStateCopyWithImpl(this._value, this._then);

  final WalkthroughState _value;
  // ignore: unused_field
  final $Res Function(WalkthroughState) _then;

  @override
  $Res call({
    Object? isCompleteWalkThrough = freezed,
  }) {
    return _then(_value.copyWith(
      isCompleteWalkThrough: isCompleteWalkThrough == freezed
          ? _value.isCompleteWalkThrough
          : isCompleteWalkThrough // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$WalkthroughStateCopyWith<$Res>
    implements $WalkthroughStateCopyWith<$Res> {
  factory _$WalkthroughStateCopyWith(
          _WalkthroughState value, $Res Function(_WalkthroughState) then) =
      __$WalkthroughStateCopyWithImpl<$Res>;
  @override
  $Res call({dynamic isCompleteWalkThrough});
}

/// @nodoc
class __$WalkthroughStateCopyWithImpl<$Res>
    extends _$WalkthroughStateCopyWithImpl<$Res>
    implements _$WalkthroughStateCopyWith<$Res> {
  __$WalkthroughStateCopyWithImpl(
      _WalkthroughState _value, $Res Function(_WalkthroughState) _then)
      : super(_value, (v) => _then(v as _WalkthroughState));

  @override
  _WalkthroughState get _value => super._value as _WalkthroughState;

  @override
  $Res call({
    Object? isCompleteWalkThrough = freezed,
  }) {
    return _then(_WalkthroughState(
      isCompleteWalkThrough: isCompleteWalkThrough == freezed
          ? _value.isCompleteWalkThrough
          : isCompleteWalkThrough,
    ));
  }
}

/// @nodoc

class _$_WalkthroughState implements _WalkthroughState {
  const _$_WalkthroughState({this.isCompleteWalkThrough = false});

  @JsonKey(defaultValue: false)
  @override
  final dynamic isCompleteWalkThrough;

  @override
  String toString() {
    return 'WalkthroughState(isCompleteWalkThrough: $isCompleteWalkThrough)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WalkthroughState &&
            (identical(other.isCompleteWalkThrough, isCompleteWalkThrough) ||
                const DeepCollectionEquality().equals(
                    other.isCompleteWalkThrough, isCompleteWalkThrough)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isCompleteWalkThrough);

  @JsonKey(ignore: true)
  @override
  _$WalkthroughStateCopyWith<_WalkthroughState> get copyWith =>
      __$WalkthroughStateCopyWithImpl<_WalkthroughState>(this, _$identity);
}

abstract class _WalkthroughState implements WalkthroughState {
  const factory _WalkthroughState({dynamic isCompleteWalkThrough}) =
      _$_WalkthroughState;

  @override
  dynamic get isCompleteWalkThrough => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WalkthroughStateCopyWith<_WalkthroughState> get copyWith =>
      throw _privateConstructorUsedError;
}
