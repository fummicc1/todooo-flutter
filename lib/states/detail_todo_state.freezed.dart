// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'detail_todo_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DetailTodoStateTearOff {
  const _$DetailTodoStateTearOff();

  _DetailTodoState call(
      {required String? todoId,
      required String content,
      required String memo,
      required bool isDone,
      required Deadline deadline,
      required String? notificationDate,
      required bool isOver}) {
    return _DetailTodoState(
      todoId: todoId,
      content: content,
      memo: memo,
      isDone: isDone,
      deadline: deadline,
      notificationDate: notificationDate,
      isOver: isOver,
    );
  }
}

/// @nodoc
const $DetailTodoState = _$DetailTodoStateTearOff();

/// @nodoc
mixin _$DetailTodoState {
  String? get todoId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get memo => throw _privateConstructorUsedError;
  bool get isDone => throw _privateConstructorUsedError;
  Deadline get deadline => throw _privateConstructorUsedError;
  String? get notificationDate => throw _privateConstructorUsedError;
  bool get isOver => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DetailTodoStateCopyWith<DetailTodoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailTodoStateCopyWith<$Res> {
  factory $DetailTodoStateCopyWith(
          DetailTodoState value, $Res Function(DetailTodoState) then) =
      _$DetailTodoStateCopyWithImpl<$Res>;
  $Res call(
      {String? todoId,
      String content,
      String memo,
      bool isDone,
      Deadline deadline,
      String? notificationDate,
      bool isOver});
}

/// @nodoc
class _$DetailTodoStateCopyWithImpl<$Res>
    implements $DetailTodoStateCopyWith<$Res> {
  _$DetailTodoStateCopyWithImpl(this._value, this._then);

  final DetailTodoState _value;
  // ignore: unused_field
  final $Res Function(DetailTodoState) _then;

  @override
  $Res call({
    Object? todoId = freezed,
    Object? content = freezed,
    Object? memo = freezed,
    Object? isDone = freezed,
    Object? deadline = freezed,
    Object? notificationDate = freezed,
    Object? isOver = freezed,
  }) {
    return _then(_value.copyWith(
      todoId: todoId == freezed
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String?,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: isDone == freezed
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      deadline: deadline == freezed
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as Deadline,
      notificationDate: notificationDate == freezed
          ? _value.notificationDate
          : notificationDate // ignore: cast_nullable_to_non_nullable
              as String?,
      isOver: isOver == freezed
          ? _value.isOver
          : isOver // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$DetailTodoStateCopyWith<$Res>
    implements $DetailTodoStateCopyWith<$Res> {
  factory _$DetailTodoStateCopyWith(
          _DetailTodoState value, $Res Function(_DetailTodoState) then) =
      __$DetailTodoStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? todoId,
      String content,
      String memo,
      bool isDone,
      Deadline deadline,
      String? notificationDate,
      bool isOver});
}

/// @nodoc
class __$DetailTodoStateCopyWithImpl<$Res>
    extends _$DetailTodoStateCopyWithImpl<$Res>
    implements _$DetailTodoStateCopyWith<$Res> {
  __$DetailTodoStateCopyWithImpl(
      _DetailTodoState _value, $Res Function(_DetailTodoState) _then)
      : super(_value, (v) => _then(v as _DetailTodoState));

  @override
  _DetailTodoState get _value => super._value as _DetailTodoState;

  @override
  $Res call({
    Object? todoId = freezed,
    Object? content = freezed,
    Object? memo = freezed,
    Object? isDone = freezed,
    Object? deadline = freezed,
    Object? notificationDate = freezed,
    Object? isOver = freezed,
  }) {
    return _then(_DetailTodoState(
      todoId: todoId == freezed
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String?,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: isDone == freezed
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      deadline: deadline == freezed
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as Deadline,
      notificationDate: notificationDate == freezed
          ? _value.notificationDate
          : notificationDate // ignore: cast_nullable_to_non_nullable
              as String?,
      isOver: isOver == freezed
          ? _value.isOver
          : isOver // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_DetailTodoState implements _DetailTodoState {
  const _$_DetailTodoState(
      {required this.todoId,
      required this.content,
      required this.memo,
      required this.isDone,
      required this.deadline,
      required this.notificationDate,
      required this.isOver});

  @override
  final String? todoId;
  @override
  final String content;
  @override
  final String memo;
  @override
  final bool isDone;
  @override
  final Deadline deadline;
  @override
  final String? notificationDate;
  @override
  final bool isOver;

  @override
  String toString() {
    return 'DetailTodoState(todoId: $todoId, content: $content, memo: $memo, isDone: $isDone, deadline: $deadline, notificationDate: $notificationDate, isOver: $isOver)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DetailTodoState &&
            (identical(other.todoId, todoId) ||
                const DeepCollectionEquality().equals(other.todoId, todoId)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.memo, memo) ||
                const DeepCollectionEquality().equals(other.memo, memo)) &&
            (identical(other.isDone, isDone) ||
                const DeepCollectionEquality().equals(other.isDone, isDone)) &&
            (identical(other.deadline, deadline) ||
                const DeepCollectionEquality()
                    .equals(other.deadline, deadline)) &&
            (identical(other.notificationDate, notificationDate) ||
                const DeepCollectionEquality()
                    .equals(other.notificationDate, notificationDate)) &&
            (identical(other.isOver, isOver) ||
                const DeepCollectionEquality().equals(other.isOver, isOver)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(todoId) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(memo) ^
      const DeepCollectionEquality().hash(isDone) ^
      const DeepCollectionEquality().hash(deadline) ^
      const DeepCollectionEquality().hash(notificationDate) ^
      const DeepCollectionEquality().hash(isOver);

  @JsonKey(ignore: true)
  @override
  _$DetailTodoStateCopyWith<_DetailTodoState> get copyWith =>
      __$DetailTodoStateCopyWithImpl<_DetailTodoState>(this, _$identity);
}

abstract class _DetailTodoState implements DetailTodoState {
  const factory _DetailTodoState(
      {required String? todoId,
      required String content,
      required String memo,
      required bool isDone,
      required Deadline deadline,
      required String? notificationDate,
      required bool isOver}) = _$_DetailTodoState;

  @override
  String? get todoId => throw _privateConstructorUsedError;
  @override
  String get content => throw _privateConstructorUsedError;
  @override
  String get memo => throw _privateConstructorUsedError;
  @override
  bool get isDone => throw _privateConstructorUsedError;
  @override
  Deadline get deadline => throw _privateConstructorUsedError;
  @override
  String? get notificationDate => throw _privateConstructorUsedError;
  @override
  bool get isOver => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DetailTodoStateCopyWith<_DetailTodoState> get copyWith =>
      throw _privateConstructorUsedError;
}
