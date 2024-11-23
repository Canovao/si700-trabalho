import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:si700_trabalho/model/CardContent.dart';
import 'package:si700_trabalho/model/trip/SearchResponseItem.dart';
import 'package:si700_trabalho/view/layout/PopularCardLayout.dart';

class Tripadvisorprovider {
  String key = "CE0333CC20B0488B98C99695AC0E67A4";
  static Tripadvisorprovider helper = Tripadvisorprovider._createInstance();

  Tripadvisorprovider._createInstance();
  bool MOCK = true;
  List<PopularCardLayout> MOCK_DATA = [
    PopularCardLayout(
      cardContent: CardContent(
          imageUrl:
              'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
          name: 'Local Z Local Z',
          country: 'País Y',
          rating: 4.8,
          description: 'Descrição do Local Z Local Z Local Z Local Z Local Z',
          city: 'cidade',
          state: 'estado',
          locationId: '1'),
    )
  ];

  Future<List<PopularCardLayout>> search(String searchQuery) async {
    if (MOCK) {
      return MOCK_DATA;
    }
    final response = await http.get(Uri.parse(
        "https://api.content.tripadvisor.com/api/v1/location/search?searchQuery=$searchQuery&language=pt&key=$key&category=hotels"));

    List<SearchResponseItem> searchResponse = [];
    (jsonDecode(response.body) as Map<String, dynamic>)["data"]
        .forEach((element) {
      searchResponse.add(SearchResponseItem.fromJson(element));
    });

    List<PopularCardLayout> cards = [];

    searchResponse.forEach((element) {
      cards.add(PopularCardLayout(
          cardContent: CardContent.fromSearchResponseItem(element)));
    });

    return cards;
  }

  Future<List<PopularCardLayout>> getPopularList() async {
    if (MOCK) {
      return MOCK_DATA;
    }

    return [];
  }
}
