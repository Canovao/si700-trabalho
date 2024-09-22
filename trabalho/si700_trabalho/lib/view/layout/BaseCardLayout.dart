import 'package:flutter/material.dart';
import 'package:si700_trabalho/bloc/TravelBloc.dart';
import 'package:si700_trabalho/model/CardContent.dart';

class BaseCardlayout extends StatelessWidget {
  final CardContent? cardContent;
  final bool showDescription;
  final TravelBloc travelBloc = TravelBloc.instance;

  BaseCardlayout({
    super.key,
    required this.cardContent,
    required this.showDescription,
  });

  @override
  Widget build(BuildContext context) {
    return cardContent == null
        ? Container()
        : Container(
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
                  GestureDetector(
                    onTap: () {
                      CardContent.lastSelected = cardContent;
                      travelBloc.add(TravelEvent.Details);
                    },
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network(
                        cardContent!.imageUrl,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Table(
                          children: [
                            TableRow(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    cardContent!.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(cardContent!.country),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.amber, size: 16),
                                      SizedBox(width: 5),
                                      Text(cardContent!.rating.toString()),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        showDescription
                            ? Text(
                                cardContent!.description,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
