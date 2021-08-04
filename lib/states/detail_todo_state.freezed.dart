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
      required String editMemo,
      required bool isDone}) {
    return _DetailTodoState(
      todoId: todoId,
      editMemo: editMemo,
      isDone: isDone,
    );
  }
}

/// @nodoc
const $DetailTodoState = _$DetailTodoStateTearOff();

/// @nodoc
mixin _$DetailTodoState {
  String? get todoId => throw _privateConstructorUsedError;
  String get editMemo => throw _privateConstructorUsedError;
  bool get isDone => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DetailTodoStateCopyWith<DetailTodoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailTodoStateCopyWith<$Res> {
  factory $DetailTodoStateCopyWith(
          DetailTodoState value, $Res Function(DetailTodoState) then) =
      _$DetailTodoStateCopyWithImpl<$Res>;
  $Res call({String? todoId, String editMemo, bool isDone});
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
    Object? editMemo = freezed,
    Object? isDone = freezed,
  }) {
    return _then(_value.copyWith(
      todoId: todoId == freezed
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String?,
      editMemo: editMemo == freezed
          ? _value.editMemo
          : editMemo // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: isDone == freezed
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
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
  $Res call({String? todoId, String editMemo, bool isDone});
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
    Object? editMemo = freezed,
    Object? isDone = freezed,
  }) {
    return _then(_DetailTodoState(
      todoId: todoId == freezed
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String?,
      editMemo: editMemo == freezed
          ? _value.editMemo
          : editMemo // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: isDone == freezed
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_DetailTodoState implements _DetailTodoState {
  const _$_DetailTodoState(
      {required this.todoId, required this.editMemo, required this.isDone});

  @override
  final String? todoId;
  @override
  final String editMemo;
  @override
  final bool isDone;

  @override
  String toString() {
    return 'DetailTodoState(todoId: $todoId, editMemo: $editMemo, isDone: $isDone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DetailTodoState &&
            (identical(other.todoId, todoId) ||
                const DeepCollectionEquality().equals(other.todoId, todoId)) &&
            (identical(other.editMemo, editMemo) ||
                const DeepCollectionEquality()
                    .equals(other.editMemo, editMemo)) &&
            (identical(other.isDone, isDone) ||
                const DeepCollectionEquality().equals(other.isDone, isDone)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(todoId) ^
      const DeepCollectionEquality().hash(editMemo) ^
      const DeepCollectionEquality().hash(isDone);

  @JsonKey(ignore: true)
  @override
  _$DetailTodoStateCopyWith<_DetailTodoState> get copyWith =>
      __$DetailTodoStateCopyWithImpl<_DetailTodoState>(this, _$identity);
}

abstract class _DetailTodoState implements DetailTodoState {
  const factory _DetailTodoState(
      {required String? todoId,
      required String editMemo,
      required bool isDone}) = _$_DetailTodoState;

  @override
  String? get todoId => throw _privateConstructorUsedError;
  @override
  String get editMemo => throw _privateConstructorUsedError;
  @override
  bool get isDone => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DetailTodoStateCopyWith<_DetailTodoState> get copyWith =>
      throw _privateConstructorUsedError;
}
