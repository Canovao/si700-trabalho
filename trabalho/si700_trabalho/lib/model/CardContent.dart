class CardContent {
  static CardContent? lastSelected;

  final String imageUrl;
  final String name;
  final String country;
  final double rating;
  final String description;

  CardContent({
    required this.imageUrl,
    required this.name,
    required this.country,
    required this.rating,
    required this.description,
  });
}
