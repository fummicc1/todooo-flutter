import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/chabge_notifier/app_store.dart';
import 'package:todooo/ui/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppStore(),
      child: MaterialApp(
        title: 'todooo',
        theme: ThemeData(
          primaryColor: Color(0xFFf3d91f),
          backgroundColor: Color(0xFF212ae0),
        ),
        home: HomePage(),
    ),
    );
  }
}
