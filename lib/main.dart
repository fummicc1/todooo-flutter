import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todooo/states/app_state.dart';
import 'package:todooo/states/todo_list_state.dart';
import 'package:todooo/ui/pages/home_page.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  runApp(MyApp());
  Intl.defaultLocale = "ja_JP";
  tz.initializeTimeZones();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider<AppState>(
            create: (_) => AppState(),
            child: ChangeNotifierProvider(
              create: (context) {
                final AppState appState = Provider.of(context, listen: false);
                return ToDoListState(
                    toDoRepository: appState.toDoRepository,
                    pageTitle: "リスト",
                    user: appState.user);
              },
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                supportedLocales: [
                  Locale("ja"),
                  Locale("en")
                ],
                title: 'todooo',
                theme: ThemeData(
                    primaryColor: Color(0xFFF2938A),
                    accentColor: Color(0xFFF04F40),
                    backgroundColor: Color(0xFFF0F0F0),
                    highlightColor: Colors.white70),
                home: HomePage(),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
