import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si700_trabalho/bloc/ProfileContentBloc.dart';
import 'package:si700_trabalho/model/ProfileContent.dart';
import 'package:si700_trabalho/view/layout/text/ScreenSubTitleTextLayout.dart';
import 'package:si700_trabalho/view/screens/logged/HomeScreen.dart';
import 'package:si700_trabalho/view/screens/logged/ProfileScreen.dart';
import 'package:si700_trabalho/view/screens/logged/SearchScreen.dart';

class LoggedLayout extends StatefulWidget {
  Widget homeScreen = HomeScreen();
  ProfileContentBloc profileContentBloc = ProfileContentBloc();
  LoggedLayout({super.key});

  @override
  State<LoggedLayout> createState() => _LoggedLayoutState();
}

class _LoggedLayoutState extends State<LoggedLayout> {
  int _currentScreen = 0;

  _getUserAvatar() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage((ProfileContent.self != null)
              ? ProfileContent.self!.profileIcon
              : ''),
        ),
        SizedBox(width: 10),
        ScreenSubTitleTextlayout(
            text:
                (ProfileContent.self != null) ? ProfileContent.self!.name : ''),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileContentBloc, ProfileContentState>(
      bloc: widget.profileContentBloc,
      builder: (BuildContext context, ProfileContentState state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            backgroundColor: Colors.white,
            title: _getUserAvatar(),
          ),
          body: IndexedStack(
              index: _currentScreen,
              children: [widget.homeScreen, SearchScreen(), ProfileScreen()]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentScreen,
            onTap: (value) {
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
      },
      listener: (BuildContext context, ProfileContentState state) {
        switch (state) {
          case ProfileContentState.Idle:
            break;
          case ProfileContentState.Update:
            setState(() {});
            widget.profileContentBloc.add(ProfileContentEvent.Idle);
            break;
        }
      },
    );
  }
}
