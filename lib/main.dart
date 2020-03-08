import 'package:flutter/material.dart';

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
    );
  }
}
