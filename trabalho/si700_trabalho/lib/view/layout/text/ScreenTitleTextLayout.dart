import 'package:flutter/material.dart';
import 'package:si700_trabalho/view/layout/text/BaseTextLayout.dart';

class ScreenTitleTextlayout extends BaseTextLayout {
  const ScreenTitleTextlayout({super.key, required super.text})
      : super(
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold));
}
