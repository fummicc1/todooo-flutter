import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todooo/costants.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/repositories/todo_repository.dart';
import 'package:todooo/services/local_notification_service.dart';
import "package:timezone/timezone.dart" as tz;

part 'add_todo_state.freezed.dart';

@freezed
abstract class AddTodoState with _$AddTodoState {
  const factory AddTodoState({
    @Default(null) String? userId,
    @Default("") String content,
    @Default(false) bool isProcessing,
    @Default(Deadline.today) Deadline deadline,
    @Default(null) DateTime? createDate,
    @Default(null) DateTime? notificationDate,
  }) = _AddTodoState;
}
