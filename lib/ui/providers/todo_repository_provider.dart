import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/repositories/todo_repository.dart';
import 'package:todooo/ui/providers/auth_client_provider.dart';
import 'package:todooo/ui/providers/firestore_client_provider.dart';

final todoRepositoryProvider = Provider<ToDoRepository>((ref) {
  final firestore = ref.read(firestoreProvider);
  final auth = ref.read(authClientProvider);
  final todoRepo = ToDoRepository(firestoreClient: firestore, authClient: auth);
  return todoRepo;
});