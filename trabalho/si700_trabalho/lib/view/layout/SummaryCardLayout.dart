import 'package:flutter/material.dart';
import 'package:si700_trabalho/model/CardContent.dart';
import 'package:si700_trabalho/view/layout/BaseCardLayout.dart';

class SummaryCardLayout extends StatelessWidget {
  final CardContent? cardContent;

  const SummaryCardLayout({
    super.key,
    this.cardContent,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCardlayout(cardContent: cardContent, showDescription: false);
  }
}
