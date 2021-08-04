import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/api/firebase/auth.dart';

final authClientProvider = Provider((_) => AuthClient());