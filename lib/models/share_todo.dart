class ShareTodo {
  final String? id;
  final List<String> sharedUsers;
  final String todoId;
  final List<String> completedUsers;

  static const collectionName = "share_todos";

  ShareTodo(
      {required this.id,
      required this.sharedUsers,
      required this.todoId,
      required this.completedUsers});

  Map<String, dynamic> get data =>
      {"id": id, "shared_users": sharedUsers, "todo_id": todoId};

  factory ShareTodo.fromMap(Map<String, dynamic> map) {
    final id = map["id"];
    final sharedUsers = map["shared_users"];
    final todoId = map["todo_id"];
    final completedUsers = map["completed_users"];
    return ShareTodo(
        id: id,
        sharedUsers: sharedUsers,
        todoId: todoId,
        completedUsers: completedUsers);
  }
}
