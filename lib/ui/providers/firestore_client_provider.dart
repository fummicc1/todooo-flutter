import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/api/firebase/firestore.dart';

final firestoreProvider = Provider<FirestoreClient>((_) => FirestoreClient());