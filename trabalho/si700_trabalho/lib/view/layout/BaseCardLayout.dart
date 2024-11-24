import 'package:flutter/material.dart';
import 'package:si700_trabalho/model/CardContent.dart';
import 'package:si700_trabalho/view/layout/BasePlaceInfoLayout.dart';
import 'package:si700_trabalho/view/screens/logged/DetailsScreen.dart';

class BaseCardlayout extends StatelessWidget {
  final CardContent? cardContent;
  final bool showDescription;

  BaseCardlayout({
    super.key,
    required this.cardContent,
    required this.showDescription,
  });

  @override
  Widget build(BuildContext context) {
    return cardContent == null
        ? Container()
        : GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailsScreen(cardContent: cardContent!)),
              );
            },
            child: Container(
              width: 215,
              margin: EdgeInsets.only(right: 10),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (cardContent!.imageUrl != null &&
                            cardContent!.imageUrl != '')
                        ? ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.network(
                              cardContent!.imageUrl!,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(),
                    BasePlaceInfoLayout(
                      cardContent: cardContent,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
