import 'package:flutter/material.dart';
import 'package:si700_trabalho/model/CardContent.dart';
import 'package:si700_trabalho/view/layout/BaseCardLayout.dart';

class PopularCardLayout extends StatelessWidget {
  final CardContent cardContent;

  const PopularCardLayout({
    super.key,
    required this.cardContent,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCardlayout(
      cardContent: cardContent,
      showDescription: true,
    );
  }
}
