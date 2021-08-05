import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/repositories/todo_repository.dart';
import 'package:todooo/repositories/user_repository.dart';
import 'package:todooo/states/todo_list_state.dart';

class TodoListViewModel extends StateNotifier<TodoListState> {

  final ToDoRepository _toDoRepository;
  final UserRepository _userRepository;

  StreamSubscription? _streamSubscription;

  TodoListViewModel(this._toDoRepository, this._userRepository) : super( const TodoListState()) {
    _userRepository.listenUser().listen((user) {
      _streamSubscription?.cancel();
      _streamSubscription = _toDoRepository.listenTodoList(userID: user!.uid, cache: false).listen((todoList) {
        if (hasListeners) {
          state = state.copyWith(todoList: todoList);
        }
      });
    });
  }

  onScroll(double scrollPosition) {
    final topLeftCircleSize = Size(200 + scrollPosition * 0.3,
        200 + scrollPosition * 0.3);
    state = state.copyWith(topLeftCircleSize: topLeftCircleSize);
  }
}