import 'package:flutter/material.dart';
import 'package:si700_trabalho/model/ProfileContent.dart';
import 'package:si700_trabalho/provider/TripAdvisorProvider.dart';
import 'package:si700_trabalho/view/layout/PopularCardLayout.dart';
import 'package:si700_trabalho/view/layout/text/ScreenTitleTextLayout.dart';

class Favoritesscreen extends StatefulWidget {
  Favoritesscreen({super.key});

  @override
  State<Favoritesscreen> createState() => _FavoritesscreenState();
}

class _FavoritesscreenState extends State<Favoritesscreen> {
  List<Widget> favorites = [];

  _buildFavorites() async {
    List<PopularCardLayout> widgets = [];

    for (var item in ProfileContent.self!.favoritePlaces) {
      widgets.add(PopularCardLayout(
          cardContent:
              await Tripadvisorprovider.helper.getDetails(item, null)));
    }

    favorites = widgets;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _buildFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: Column(children: [
                    Row(children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ]),
                    ScreenTitleTextlayout(text: 'Favoritos'),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: favorites,
                      ),
                    )
                  ]))),
            );
          }
        });
  }
}
