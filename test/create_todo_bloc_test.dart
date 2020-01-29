import 'package:test/test.dart';
import 'package:todooo/bloc/create_todo_bloc.dart';
import 'package:todooo/data/local_storage_client_mock.dart';
import 'package:todooo/data/todo.dart';

void main() {

  CreateToDoBloc createToDoBloc;

  setUp(() {
    createToDoBloc = CreateToDoBloc(LocalStorageClientMock());
  });

  test("test for todo creation successfully", () async {
    ToDo toDo = ToDo("Test", "everyday", DateTime.now());
    var result = await createToDoBloc.createToDo(toDo);
    expect(result, true);
  });

  test('test for todo creation because content is empty.', () async {
    ToDo toDo = ToDo("", "today", DateTime.now());
    var result = await createToDoBloc.createToDo(toDo);
    expect(result, false);
  });
}