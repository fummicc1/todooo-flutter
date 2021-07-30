import 'package:flutter/material.dart';

class SettingCardWidget extends StatelessWidget {
  const SettingCardWidget({Key? key, required this.title, required this.onTap})
      : super(key: key);

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
