import 'package:flutter/material.dart';
import 'package:si700_trabalho/view/layout/text/ScreenSubTitleTextLayout.dart';
import 'package:si700_trabalho/view/layout/text/ScreenTitleTextLayout.dart';

class ListViewLayout extends StatelessWidget {
  String title;
  String subTitle;
  List<Widget> children;
  ListViewLayout(
      {required this.children,
      required this.subTitle,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenTitleTextlayout(text: title),
          SizedBox(height: 20),
          ScreenSubTitleTextlayout(text: subTitle),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
