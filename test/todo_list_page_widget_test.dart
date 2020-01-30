import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todooo/main.dart';
import 'package:todooo/ui/widgets/list_widget.dart';

void main() {
  testWidgets("test for ToDoListPage to have a PlusButton.", (WidgetTester widgetTester) async {

    final GlobalKey globalKey = GlobalKey();

    final Provider myAppProvider = Provider(
      key: globalKey,
      create: (_) => null,
      child: MyApp(),
    );

    await widgetTester.pumpWidget(myAppProvider);
    expect(find.widgetWithIcon(FlatButton, Icons.add), findsOneWidget);
  });

  testWidgets("test for ToDoListPage to have 1 active ListWidget.", (WidgetTester widgetTester) async {
    final GlobalKey globalKey = GlobalKey();

    final Provider myAppProvider = Provider(
      key: globalKey,
      create: (_) => null,
      child: MyApp(),
    );

    await widgetTester.pumpWidget(myAppProvider);
    expect(find.byWidgetPredicate((widget) => widget is ListWidget), findsOneWidget);
  });
  
  
  testWidgets("test for todoListPage to tap ToDoCellWidget And ShowModalBottomSheet", (WidgetTester widgetTester) async {
    final GlobalKey globalKey = GlobalKey();

    final Provider myAppProvider = Provider(
      key: globalKey,
      create: (_) => null,
      child: MyApp(),
    );
    await widgetTester.pumpWidget(myAppProvider);

  });
}