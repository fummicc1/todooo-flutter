import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/states/app_state.dart';
import 'package:todooo/ui/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'todooo',
        home: HomePage(),
    ),
    );
  }
}
