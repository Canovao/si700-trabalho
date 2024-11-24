import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:si700_trabalho/model/CardContent.dart';
import 'package:si700_trabalho/model/ProfileContent.dart';
import 'package:si700_trabalho/provider/ProfileContentProvider.dart';
import 'package:si700_trabalho/provider/TripAdvisorProvider.dart';
import 'package:si700_trabalho/view/layout/BasePlaceInfoLayout.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  CardContent cardContent;

  DetailsScreen({required this.cardContent, super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future<CardContent> updateCardDetails() async {
    widget.cardContent = await Tripadvisorprovider.helper
        .getDetails(widget.cardContent.locationId, widget.cardContent);
    return widget.cardContent;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: updateCardDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                (widget.cardContent.imageUrl != null &&
                        widget.cardContent.imageUrl != '')
                    ? Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                widget.cardContent.imageUrl!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Center(
                        heightFactor: 1,
                        child: SizedBox(
                          height: 300,
                          width: 300,
                          child: CircularProgressIndicator.adaptive(),
                        )),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 260),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BasePlaceInfoLayout(
                              cardContent: widget.cardContent,
                              fontSize: 18,
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Column(children: [
                                ElevatedButton(
                                  onPressed: _launchURL,
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 80, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    'Reservar',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        ProfileContentProvider.helper
                            .toggleFavorite(widget.cardContent.locationId);
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.favorite,
                          color: ProfileContent.self!.favoritePlaces
                                  .contains(widget.cardContent.locationId)
                              ? Colors.red
                              : Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  _launchURL() async {
    String? url = widget.cardContent.webUrl;
    if (url != null) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildGalleryItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
