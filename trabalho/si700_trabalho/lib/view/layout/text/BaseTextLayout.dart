import 'package:flutter/material.dart';

class BaseTextLayout extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const BaseTextLayout(
      {super.key, required this.text, this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: (style != null) ? style : TextStyle(fontSize: 24),
        textAlign: (textAlign != null) ? textAlign : TextAlign.start);
  }
}
