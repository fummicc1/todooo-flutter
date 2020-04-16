import 'package:flutter/cupertino.dart';
import 'package:todooo/api/firestore_client.dart';
import 'package:todooo/models/todo.dart';

class DetailToDoStore extends ChangeNotifier {
  FirestoreClient _firestoreClient = FirestoreClient();
  ToDo toDo;
  String editedMemo;
  final FocusNode focusNode;
  final TextEditingController memoEditingController;

  DetailToDoStore({@required this.toDo}) : focusNode = FocusNode(), memoEditingController = TextEditingController() {
    focusNode.addListener(() {
      notifyListeners();
    });
    if (toDo.memo?.isNotEmpty ?? false) {
      memoEditingController.text = toDo.memo;
    }
  }

  Future<void> deleteToDo() {
    return _firestoreClient.deleteToDo(toDo);
  }

  Future<void> toggleToDo() {
    toDo.isDone = !toDo.isDone;
    return _firestoreClient.updateToDo(toDo).then((v) {
      _firestoreClient.getToDo(toDo).listen((todo) {
        this.toDo = toDo;
        notifyListeners();
      });
    });
  }

  Future<void> updateMemo(String memo) {
    toDo.memo = memo;
    return _firestoreClient.updateToDo(toDo).then((_) {
      _firestoreClient.getToDo(toDo).listen((todo) {
        this.toDo = todo;
        notifyListeners();
      });
    });
  }

  @override
  void dispose() {
    memoEditingController.dispose();
    super.dispose();
  }
}
