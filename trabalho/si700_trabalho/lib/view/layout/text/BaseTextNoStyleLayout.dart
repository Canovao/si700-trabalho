import 'package:flutter/material.dart';
import 'package:si700_trabalho/view/layout/text/BaseTextLayout.dart';

class BaseTextNoStyleLayout extends BaseTextLayout {
  const BaseTextNoStyleLayout({super.key, required super.text})
      : super(style: const TextStyle());
}
