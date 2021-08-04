import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/repositories/todo_repository.dart';
import 'package:todooo/ui/providers/firestore_client_provider.dart';

final todoRepositoryProvider = Provider<ToDoRepository>((ref) {
  final firestore = ref.read(firestoreProvider);
  return ToDoRepository(firestoreClient: firestore);
});