import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:todooo/data/local_storage_client.dart';

class CreateToDoBloc {

  final LocalStorageRepository _repository;

  BehaviorSubject<bool> _isPersistingSubject = BehaviorSubject();
  Stream<bool> get isPersisting => _isPersistingSubject.stream;

  CreateToDoBloc(this._repository);


}