
import 'package:test/test.dart';
import 'package:todooo/bloc/todo_list_bloc.dart';
import 'package:todooo/data/local_storage_client_mock.dart';
import 'package:todooo/data/todo.dart';

// ToDoListBloc Tests
void main() {

  test('test for todo creation', () async {
    ToDoListBloc bloc = ToDoListBloc(LocalStorageClientMock());
    ToDo toDo = ToDo("", "everyday", DateTime.now());
    var result = await bloc.createToDo(toDo);
    expect(result, true);
  });

  test('test for todo deletion with empty todolist.', () async {
    ToDoListBloc bloc = ToDoListBloc(LocalStorageClientMock());
    ToDo toDo = ToDo("Test", "today", DateTime.now());
    var result = await bloc.deleteToDo(toDo);
    expect(result, false);
  });

  test('test for existing todo deletion.', () async {
    LocalStorageClientMock localStorageClientMock = LocalStorageClientMock();
    ToDo toDo = ToDo("Test", "today", DateTime.now());
    localStorageClientMock.todoList = [toDo];
    ToDoListBloc bloc = ToDoListBloc(localStorageClientMock);
    var result = await bloc.deleteToDo(toDo);
    expect(result, true);
  });
}