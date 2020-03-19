import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/chabge_notifier/app_store.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppStore appStore = Provider.of(context);
    if (appStore.user == null) {

    }
  }
}
