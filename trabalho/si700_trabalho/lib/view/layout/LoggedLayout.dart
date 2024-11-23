import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si700_trabalho/bloc/TravelBloc.dart';
import 'package:si700_trabalho/model/ProfileContent.dart';
import 'package:si700_trabalho/view/layout/text/ScreenSubTitleTextLayout.dart';
import 'package:si700_trabalho/view/screens/logged/DetailsScreen.dart';
import 'package:si700_trabalho/view/screens/logged/HomeScreen.dart';
import 'package:si700_trabalho/view/screens/logged/ProfileScreen.dart';
import 'package:si700_trabalho/view/screens/logged/SearchScreen.dart';

class LoggedLayout extends StatefulWidget {
  final TravelBloc _travelBloc = TravelBloc.instance;
  LoggedLayout({super.key});

  @override
  State<LoggedLayout> createState() => _LoggedLayoutState();
}

class _LoggedLayoutState extends State<LoggedLayout> {
  int _currentScreen = 0;

  _getUserAvatar() {
    // TODO IMPLEMENTAR UMA LÓGICA DE VERDADE PRA MOSTRAR O AVATAR DO USUÁRIO
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(ProfileContent.self!.profileIcon),
        ),
        SizedBox(width: 10),
        ScreenSubTitleTextlayout(text: 'Leonardo'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.white,
        title: _getUserAvatar(),
      ),
      body: BlocBuilder<TravelBloc, TravelState>(
        bloc: widget._travelBloc,
        builder: (context, state) {
          switch (state) {
            case TravelState.Idle:
              return IndexedStack(
                  index: _currentScreen,
                  children: [HomeScreen(), SearchScreen(), ProfileScreen()]);
            case TravelState.Details:
              return DetailsScreen();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreen,
        onTap: (value) {
          widget._travelBloc.add(TravelEvent.Idle);
          setState(() {
            _currentScreen = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Pesquisar",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Perfil"),
        ],
      ),
    );
  }
}
