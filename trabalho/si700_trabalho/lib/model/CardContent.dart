import 'package:si700_trabalho/model/trip/SearchResponseItem.dart';

class CardContent {
  static CardContent? lastSelected;

  final String locationId;

  final String imageUrl;

  final String name;
  final String city;
  final String state;
  final String country;
  final String description; // address_obj.string

  final double rating;

  CardContent({
    required this.imageUrl,
    required this.name,
    required this.country,
    required this.rating,
    required this.description,
    required this.city,
    required this.state,
    required this.locationId,
  });

  static fromSearchResponseItem(SearchResponseItem item) {
    return CardContent(
        imageUrl: '',
        name: item.name,
        country: item.addressObj.country,
        rating: 0,
        description: item.addressObj.addressString,
        city: item.addressObj.city,
        state: item.addressObj.state,
        locationId: item.locationId);
  }
}
