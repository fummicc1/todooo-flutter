import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/states/setting_state.dart';
import 'package:todooo/ui/components/setting_card_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final settingState = Provider.of<SettingState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("設定"),
      ),
      body: ListView(
        children: [
          SettingCardWidget(title: "アカウント削除", onTap: () {
            settingState.deleteUser();
          }),
        ],
      ),
    );
  }
}
