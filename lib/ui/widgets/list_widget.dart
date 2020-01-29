import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/data/todo.dart';
import 'package:todooo/ui/widgets/todo_cell_widget.dart';
import '../../bloc/todo_list_bloc.dart';

class ListWidget extends StatefulWidget {
  final List<ToDo> todoList;

  ListWidget(this.todoList);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToDoListBloc bloc = Provider.of(context);
    return ListView.builder(
      itemCount: widget.todoList.length,
      itemBuilder: (context, index) {
        return ToDoCellWidget(widget.todoList[index]);
      },
    );
  }
}
