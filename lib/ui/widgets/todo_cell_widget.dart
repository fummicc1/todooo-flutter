import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/bloc/todo_list_bloc.dart';
import 'package:todooo/data/todo.dart';
import 'package:todooo/ui/widgets/modal_bottom_sheet_widget.dart';

class ToDoCellWidget extends StatelessWidget {

  final ToDo todo;

  ToDoCellWidget(this.todo);

  @override
  Widget build(BuildContext context) {

    ToDoListBloc bloc = Provider.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Card(
        child: ListTile(
          leading: todo.isDone ? Icon(Icons.done) : null,
          title: Text(
            todo.content,
            style: Theme.of(context).textTheme.headline4,
            maxLines: 3,
          ),
          trailing: Text(
            todo.displayDeadline,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          onTap: () {
            showModalBottomSheet(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                ),
                context: context,
                builder: (context) {
                  return TodoModalBottomSheetWidget(todo);
                });
          },
        ),
      ),
    );
  }
}
