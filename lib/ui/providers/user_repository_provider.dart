import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/repositories/user_repository.dart';
import 'package:todooo/ui/providers/auth_client_provider.dart';
import 'package:todooo/ui/providers/firestore_client_provider.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final authClient = ref.read(authClientProvider);
  final firestoreClient = ref.read(firestoreProvider);
  return UserRepository(authClient, firestoreClient);
});