import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si700_trabalho/bloc/LoginBloc.dart';
import 'package:si700_trabalho/view/screens/notLogged/CreateAccountScreen.dart';
import 'package:si700_trabalho/view/layout/LoggedLayout.dart';
import 'package:si700_trabalho/view/screens/notLogged/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LoginBloc loginBloc = LoginBloc();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App de viagens',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: GoogleFonts.abhayaLibre().fontFamily,
        ),
        home: BlocBuilder<LoginBloc, LoginState>(
            bloc: loginBloc,
            builder: (context, state) {
              switch (state) {
                case LoginState.NotLogged:
                  return LoginScreen(loginBloc: loginBloc);
                case LoginState.Logged:
                  return LoggedLayout();
                case LoginState.CreateAccount:
                  return CreateAccountScreen(loginBloc: loginBloc);
              }
            }));
  }
}
