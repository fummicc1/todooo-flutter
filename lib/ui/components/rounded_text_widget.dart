import 'package:flutter/material.dart';

class RoundedTextWidget extends StatelessWidget {
  RoundedTextWidget(
      {Key? key,
      required this.message,
      this.borderRadius = 8,
      required this.color,
      required this.textColor})
      : super(key: key);

  final String message;
  final double borderRadius;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
