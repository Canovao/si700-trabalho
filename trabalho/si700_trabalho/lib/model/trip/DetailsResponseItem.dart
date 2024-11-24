class DetailsResponseItem {
  String description;
  String webUrl;
  String ranking;
  String rating;

  DetailsResponseItem(
      {required this.description,
      required this.webUrl,
      required this.ranking,
      required this.rating});

  static DetailsResponseItem fromJson(jsonDecode) {
    return DetailsResponseItem(
        description: (jsonDecode['description'] == null)
            ? ''
            : jsonDecode['description'].replaceAll('.', '\n'),
        webUrl: (jsonDecode['web_url'] == null) ? '' : jsonDecode['web_url'],
        ranking: (jsonDecode['ranking_data'] == null)
            ? ''
            : (jsonDecode['ranking_data']['ranking_string'] == null)
                ? ''
                : jsonDecode['ranking_data']['ranking_string'],
        rating: (jsonDecode['rating'] == null) ? '' : jsonDecode['rating']);
  }
}
