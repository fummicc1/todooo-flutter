class ToDo {
  String content;
  String deadline;
  DateTime createDate;
  bool isDone;

  ToDo(this.content, this.deadline, this.createDate, this.isDone);

  bool get isOver {

    final current = DateTime.now();

    if (deadline != "today") {
      if (current.day > createDate.day) {
        return true;
      } else {
        return false;
      }
    } else if (deadline == "tomorrow") {
      if (current.day > createDate.day + 1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  ToDo.fromJSON(Map<String, dynamic> json) {
    content = json["content"];
    deadline = json["deadline"];
    createDate = DateTime.fromMillisecondsSinceEpoch(json["create_date"]);
    isDone = json["is_done"];
  }

  Map<String, dynamic> get json => {
    "content": content,
    "deadline": deadline,
    "create_date": createDate.millisecondsSinceEpoch,
    "is_done": isDone
  };

  String get displayDeadline {
    if (deadline == "everyday") {
      return "毎日";
    } else if (deadline == "tomorrow") {
      return "明日まで";
    } else if (deadline == "today") {
      return "今日中";
    }
    return "";
  }
}