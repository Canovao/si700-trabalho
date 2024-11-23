import 'package:flutter/material.dart';
import 'package:si700_trabalho/provider/TripAdvisorProvider.dart';
import 'package:si700_trabalho/view/layout/ListViewLayout.dart';
import 'package:si700_trabalho/view/layout/PopularCardLayout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PopularCardLayout>>(
      future: Tripadvisorprovider.helper.getPopularList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          return ListViewLayout(
            title: 'Home',
            subTitle: 'Populares',
            children: snapshot.data!,
          );
        }
      },
    );
  }
}
