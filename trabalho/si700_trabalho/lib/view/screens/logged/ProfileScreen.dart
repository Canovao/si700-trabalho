import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:si700_trabalho/model/ProfileContent.dart';
import 'package:si700_trabalho/provider/AuthProvider.dart';
import 'package:si700_trabalho/provider/ProfileContentProvider.dart';
import 'package:si700_trabalho/view/layout/text/BaseTextLayout.dart';
import 'package:si700_trabalho/view/layout/text/ScreenTitleTextLayout.dart';
import 'package:si700_trabalho/view/screens/logged/EditingProfileScreen.dart';
import 'package:si700_trabalho/view/screens/logged/FavoritesScreen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  List<Widget> favorites = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ScreenTitleTextlayout(text: 'Perfil'),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Editingprofilescreen()),
                    );
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
            Column(children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage((ProfileContent.self != null)
                    ? ProfileContent.self!.profileIcon
                    : ''),
              ),
              ScreenTitleTextlayout(
                  text: (ProfileContent.self != null)
                      ? ProfileContent.self!.name
                      : ''),
              BaseTextLayout(
                text: (ProfileContent.self != null)
                    ? ProfileContent.self!.email
                    : '',
              ),
              BaseTextLayout(
                text: (ProfileContent.self != null)
                    ? ProfileContent.self!.phone
                    : '',
              )
            ]),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite, color: Colors.red),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Favoritesscreen()),
                      );
                    },
                    child: BaseTextLayout(text: 'Favoritos'))
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.logout, color: Colors.red),
              TextButton(
                  onPressed: () {
                    FirebaseAuthenticationService.helper.signOut();
                  },
                  child: BaseTextLayout(text: 'Sair'))
            ])
          ],
        ),
      ),
    );
  }
}
