import 'package:si700_trabalho/model/trip/SearchResponseItem.dart';

class CardContent {
  String? imageUrl;

  final String locationId;
  final String name;
  final String city;
  final String state;
  final String country;
  final String description;

  String? fullDescription;
  String? rating;
  String? webUrl;

  CardContent({
    required this.name,
    required this.country,
    required this.description,
    required this.city,
    required this.state,
    required this.locationId,
    this.imageUrl,
    this.rating,
    this.fullDescription,
    this.webUrl,
  });

  static fromSearchResponseItem(SearchResponseItem item) {
    return CardContent(
        name: item.name,
        country: item.addressObj.country,
        description: item.addressObj.addressString,
        city: item.addressObj.city,
        state: item.addressObj.state,
        locationId: item.locationId);
  }

  setImgUrl(String url) {
    imageUrl = url;
  }

  @override
  String toString() {
    return 'CardContent{imageUrl: $imageUrl, name: $name, city: $city, state: $state, country: $country, description: $description, fullDescription: $fullDescription, rating: $rating, webUrl: $webUrl}';
  }
}
