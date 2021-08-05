// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'add_todo_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AddTodoStateTearOff {
  const _$AddTodoStateTearOff();

  _AddTodoState call(
      {String content = "",
      bool isProcessing = false,
      Deadline deadline = Deadline.today,
      DateTime? createDate = null,
      DateTime? notificationDate = null}) {
    return _AddTodoState(
      content: content,
      isProcessing: isProcessing,
      deadline: deadline,
      createDate: createDate,
      notificationDate: notificationDate,
    );
  }
}

/// @nodoc
const $AddTodoState = _$AddTodoStateTearOff();

/// @nodoc
mixin _$AddTodoState {
  String get content => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  Deadline get deadline => throw _privateConstructorUsedError;
  DateTime? get createDate => throw _privateConstructorUsedError;
  DateTime? get notificationDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddTodoStateCopyWith<AddTodoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddTodoStateCopyWith<$Res> {
  factory $AddTodoStateCopyWith(
          AddTodoState value, $Res Function(AddTodoState) then) =
      _$AddTodoStateCopyWithImpl<$Res>;
  $Res call(
      {String content,
      bool isProcessing,
      Deadline deadline,
      DateTime? createDate,
      DateTime? notificationDate});
}

/// @nodoc
class _$AddTodoStateCopyWithImpl<$Res> implements $AddTodoStateCopyWith<$Res> {
  _$AddTodoStateCopyWithImpl(this._value, this._then);

  final AddTodoState _value;
  // ignore: unused_field
  final $Res Function(AddTodoState) _then;

  @override
  $Res call({
    Object? content = freezed,
    Object? isProcessing = freezed,
    Object? deadline = freezed,
    Object? createDate = freezed,
    Object? notificationDate = freezed,
  }) {
    return _then(_value.copyWith(
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isProcessing: isProcessing == freezed
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      deadline: deadline == freezed
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as Deadline,
      createDate: createDate == freezed
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notificationDate: notificationDate == freezed
          ? _value.notificationDate
          : notificationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$AddTodoStateCopyWith<$Res>
    implements $AddTodoStateCopyWith<$Res> {
  factory _$AddTodoStateCopyWith(
          _AddTodoState value, $Res Function(_AddTodoState) then) =
      __$AddTodoStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String content,
      bool isProcessing,
      Deadline deadline,
      DateTime? createDate,
      DateTime? notificationDate});
}

/// @nodoc
class __$AddTodoStateCopyWithImpl<$Res> extends _$AddTodoStateCopyWithImpl<$Res>
    implements _$AddTodoStateCopyWith<$Res> {
  __$AddTodoStateCopyWithImpl(
      _AddTodoState _value, $Res Function(_AddTodoState) _then)
      : super(_value, (v) => _then(v as _AddTodoState));

  @override
  _AddTodoState get _value => super._value as _AddTodoState;

  @override
  $Res call({
    Object? content = freezed,
    Object? isProcessing = freezed,
    Object? deadline = freezed,
    Object? createDate = freezed,
    Object? notificationDate = freezed,
  }) {
    return _then(_AddTodoState(
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isProcessing: isProcessing == freezed
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      deadline: deadline == freezed
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as Deadline,
      createDate: createDate == freezed
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notificationDate: notificationDate == freezed
          ? _value.notificationDate
          : notificationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_AddTodoState implements _AddTodoState {
  const _$_AddTodoState(
      {this.content = "",
      this.isProcessing = false,
      this.deadline = Deadline.today,
      this.createDate = null,
      this.notificationDate = null});

  @JsonKey(defaultValue: "")
  @override
  final String content;
  @JsonKey(defaultValue: false)
  @override
  final bool isProcessing;
  @JsonKey(defaultValue: Deadline.today)
  @override
  final Deadline deadline;
  @JsonKey(defaultValue: null)
  @override
  final DateTime? createDate;
  @JsonKey(defaultValue: null)
  @override
  final DateTime? notificationDate;

  @override
  String toString() {
    return 'AddTodoState(content: $content, isProcessing: $isProcessing, deadline: $deadline, createDate: $createDate, notificationDate: $notificationDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AddTodoState &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.isProcessing, isProcessing) ||
                const DeepCollectionEquality()
                    .equals(other.isProcessing, isProcessing)) &&
            (identical(other.deadline, deadline) ||
                const DeepCollectionEquality()
                    .equals(other.deadline, deadline)) &&
            (identical(other.createDate, createDate) ||
                const DeepCollectionEquality()
                    .equals(other.createDate, createDate)) &&
            (identical(other.notificationDate, notificationDate) ||
                const DeepCollectionEquality()
                    .equals(other.notificationDate, notificationDate)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(isProcessing) ^
      const DeepCollectionEquality().hash(deadline) ^
      const DeepCollectionEquality().hash(createDate) ^
      const DeepCollectionEquality().hash(notificationDate);

  @JsonKey(ignore: true)
  @override
  _$AddTodoStateCopyWith<_AddTodoState> get copyWith =>
      __$AddTodoStateCopyWithImpl<_AddTodoState>(this, _$identity);
}

abstract class _AddTodoState implements AddTodoState {
  const factory _AddTodoState(
      {String content,
      bool isProcessing,
      Deadline deadline,
      DateTime? createDate,
      DateTime? notificationDate}) = _$_AddTodoState;

  @override
  String get content => throw _privateConstructorUsedError;
  @override
  bool get isProcessing => throw _privateConstructorUsedError;
  @override
  Deadline get deadline => throw _privateConstructorUsedError;
  @override
  DateTime? get createDate => throw _privateConstructorUsedError;
  @override
  DateTime? get notificationDate => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AddTodoStateCopyWith<_AddTodoState> get copyWith =>
      throw _privateConstructorUsedError;
}
