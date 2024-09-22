import 'package:flutter/material.dart';
import 'package:si700_trabalho/model/CardContent.dart';
import 'package:si700_trabalho/view/layout/PopularCardLayout.dart';
import 'package:si700_trabalho/view/layout/text/ScreenSubTitleTextLayout.dart';
import 'package:si700_trabalho/view/layout/text/ScreenTitleTextLayout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenTitleTextlayout(text: 'Home'),
          SizedBox(height: 20),
          ScreenSubTitleTextlayout(text: 'Populares'),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                PopularCardLayout(
                  cardContent: CardContent(
                    imageUrl:
                        'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
                    name: 'Local Z',
                    country: 'País Y',
                    rating: 4.8,
                    description: 'Descrição do local Z',
                  ),
                ),
                PopularCardLayout(
                  cardContent: CardContent(
                    imageUrl:
                        'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
                    name: 'Local Z',
                    country: 'País Y',
                    rating: 4.8,
                    description: 'Descrição do local Z',
                  ),
                ),
                PopularCardLayout(
                  cardContent: CardContent(
                    imageUrl:
                        'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
                    name: 'Local Z',
                    country: 'País Y',
                    rating: 4.8,
                    description: 'Descrição do local Z',
                  ),
                ),
                PopularCardLayout(
                  cardContent: CardContent(
                    imageUrl:
                        'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
                    name: 'Local Z',
                    country: 'País Y',
                    rating: 4.8,
                    description: 'Descrição do local Z',
                  ),
                ),
                PopularCardLayout(
                  cardContent: CardContent(
                    imageUrl:
                        'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
                    name: 'Local Z',
                    country: 'País Y',
                    rating: 4.8,
                    description: 'Descrição do local Z',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
