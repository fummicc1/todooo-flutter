import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/ui/components/setting_card_widget.dart';
import 'package:todooo/ui/providers/setting_viewmodel_provider.dart';

class SettingPage extends HookConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final settingState = ref.read(settingViewModelProvider.notifier);

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
