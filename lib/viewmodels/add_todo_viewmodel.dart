import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todooo/costants.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/models/user.dart';
import 'package:todooo/repositories/todo_repository.dart';
import 'package:todooo/repositories/user_repository.dart';
import 'package:todooo/services/local_notification_service.dart';
import 'package:todooo/states/add_todo_state.dart';
import 'package:timezone/timezone.dart' as tz;

class AddTodoViewModel extends StateNotifier<AddTodoState> {
  final ToDoRepository _toDoRepository;
  final LocalNotificationService _localNotificationService;

  bool get isDataInputted => state.userId!.isNotEmpty && state.content.isNotEmpty;

  AddTodoViewModel(this._toDoRepository, this._localNotificationService)
      : super(const AddTodoState());

  updateContent(String content) {
    state = state.copyWith(content: content);
  }

  updateDeadline(Deadline deadline) {
    state = state.copyWith(deadline: deadline);
  }

  updateNotificationDate(DateTime? dateTime) {
    state = state.copyWith(notificationDate: dateTime);
  }

  Future create() async {
    if (state.isProcessing) {
      return Future.error("isProcessing = true");
    }

    state = state.copyWith(isProcessing: true);

    final todoRef = _toDoRepository.generateDocumentRef(
        collectionName: UserCollectionName,
        documentId: state.userId!,
        subCollectionName: Todo.CollectionName);

    int? notificationId;

    if (state.notificationDate != null) {
      try {
        final formatNotificationDate =
            DateFormat.yMMMd().format(state.notificationDate!);
        notificationId = await _localNotificationService.sendNotification(
            title: "${state.content}を完了しましょう",
            body: "提出期限は$formatNotificationDateです",
            scheduledDate: tz.TZDateTime.from(
                state.notificationDate!, tz.getLocation(TokyoLocation)),
            details: NotificationDetails(
                android: AndroidNotificationDetails("0", "TOD_NOTIFICATION", "",
                    importance: Importance.high)),
            payload: '{ "todo_id": "${todoRef.id}" }');
      } catch (e) {
        return Future.error(e);
      }
    }

    final todo = Todo(
        uid: todoRef.id,
        content: state.content,
        memo: "",
        deadline: state.deadline.toString(),
        createDate: DateTime.now(),
        isDone: false,
        owner: state.userId!,
        notificationDateTimeFromEpoch:
            state.notificationDate?.millisecondsSinceEpoch,
        notificationId: notificationId);

    await _toDoRepository.createTodoWithId(todo);
  }
}
