import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/bloc/bloc.dart';
import 'package:todooo/ui/todo_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todooo',
      theme: ThemeData(
        primaryColor: Color(0xFFf3d91f),
        backgroundColor: Color(0xFF212ae0),
      ),
      home: Provider(
          create: (_) => Bloc(),
          dispose: (_, bloc) => bloc.dispose,
          child: ToDoListPage()),
    );
  }
}
