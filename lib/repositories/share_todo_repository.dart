import 'package:todooo/api/firebase/firestore.dart';
import 'package:todooo/models/share_todo.dart';

class ShareTodoRepository {
  final FirestoreClient _firestoreClient;

  ShareTodoRepository(this._firestoreClient);

  Future<ShareTodo> findWithID(String id) async {
    final response = await _firestoreClient.getDocument(
        collectionName: ShareTodo.collectionName, documentName: id);
    final data = response.data() as Map<String, dynamic>?;
    if (data != null) {
      return ShareTodo.fromMap(data);
    }
    return Future.error("No data found");
  }

  Future create(ShareTodo shareTodo) async {
    await _firestoreClient.createDocument(
        collectionName: ShareTodo.collectionName, data: shareTodo.data);
  }

  Future update(ShareTodo shareTodo) async {
    await _firestoreClient.setDocument(
        collectionName: ShareTodo.collectionName,
        documentName: shareTodo.id!,
        data: shareTodo.data);
  }

  Future delete(String id) async {
    await _firestoreClient.deleteDocument(
        collectionName: ShareTodo.collectionName, documentName: id);
  }
}
