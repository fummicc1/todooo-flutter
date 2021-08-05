import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todooo/states/setting_state.dart';
import 'package:todooo/ui/pages/home_page.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  runApp(ProviderScope(child: MyApp()));
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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: [Locale("ja"), Locale("en")],
            title: 'todooo',
            theme: ThemeData(
                primarySwatch: MaterialColor(Color(0xFFF2938A).value, {
                  50: Color(0xFFffe9eb),
                  100: Color(0xFFffc8c9),
                  200: Color(0xFFf2938a),
                  300: Color(0xFFe5695e),
                  400: Color(0xFFea4935),
                  500: Color(0xFFeb3b11),
                  600: Color(0xFFdd2f14),
                  700: Color(0xFFcc240f),
                  800: Color(0xFFbf1c07),
                  900: Color(0xFFaf0f00),
                }),
                backgroundColor: Color(0xFFFEEAE6),
                scaffoldBackgroundColor: Color(0xFFFEEAE6),
                highlightColor: Colors.white70),
            home: HomePage(),
          );
        } else {
        return CircularProgressIndicator();
        }
      },
    );
  }
}
