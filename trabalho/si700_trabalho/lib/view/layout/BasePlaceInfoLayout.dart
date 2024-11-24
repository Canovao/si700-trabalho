import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:si700_trabalho/model/CardContent.dart';

class BasePlaceInfoLayout extends StatelessWidget {
  final CardContent? cardContent;
  final double fontSize;

  BasePlaceInfoLayout({
    super.key,
    required this.cardContent,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    Widget rating = Container();

    if (cardContent!.rating != null) {
      rating = Row(
        children: [
          Icon(Icons.star, color: Colors.amber),
          SizedBox(width: 5),
          Text(cardContent!.rating!, style: TextStyle(color: Colors.grey))
        ],
      );
    }

    if (cardContent!.fullDescription != null) {
      children.add(Column(children: [
        Text(
          'Sobre o Destino',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Expanded(
                child: Text(
              overflow: TextOverflow.clip,
              cardContent!.fullDescription!,
            ))
          ],
        ),
      ]));
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(children: [
                Expanded(
                  child: Text(
                    cardContent!.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize + fontSize * 0.1),
                  ),
                ),
              ]),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      cardContent!.city,
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ),
                  Expanded(
                    child: Text(cardContent!.state,
                        style: TextStyle(fontSize: fontSize)),
                  ),
                  Expanded(
                    child: Text(cardContent!.country,
                        style: TextStyle(fontSize: fontSize)),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.grey),
              SizedBox(width: 5),
              Expanded(
                  child: Text(
                overflow: TextOverflow.clip,
                cardContent!.description,
              )),
              rating
            ],
          ),
          ...children
        ],
      ),
    );
  }
}
