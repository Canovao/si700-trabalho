import 'package:flutter/material.dart';
import 'package:si700_trabalho/view/layout/text/BaseTextLayout.dart';

class ScreenSubTitleTextlayout extends BaseTextLayout {
  const ScreenSubTitleTextlayout({super.key, required super.text})
      : super(
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
}
