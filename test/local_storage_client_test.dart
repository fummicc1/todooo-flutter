import 'package:test/test.dart';
import 'package:todooo/data/local_storage_client.dart';
import 'package:todooo/data/todo.dart';

void main() {

  test("test for LocalStorageClient to save todo", () async {
    LocalStorageClient client = LocalStorageClient();
    List<ToDo> beforeToDoList = await client.getToDos(isTesting: true);
    ToDo todo = ToDo("test", "everyday", DateTime.now());
    await client.saveToDo(todo);
    List<ToDo> afterToDoList = await client.getToDos();
    await client.deleteToDo(todo);
    expect(afterToDoList.length, beforeToDoList.length + 1);
  });

  test("test for LocalStorageClinet to delete todo properly", () {
  });

  test("test for LoalStorageClient to update todo properly", () {
  });
}