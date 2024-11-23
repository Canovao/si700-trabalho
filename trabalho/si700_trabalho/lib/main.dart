import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si700_trabalho/bloc/AuthBloc.dart';
import 'package:si700_trabalho/bloc/LoginBloc.dart';
import 'package:si700_trabalho/view/screens/notLogged/CreateAccountScreen.dart';
import 'package:si700_trabalho/view/layout/LoggedLayout.dart';
import 'package:si700_trabalho/view/screens/notLogged/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBqmIBCW4Bf8OFelG4TUjotHJea4KwhUW0",
          authDomain: "si700-aulas.firebaseapp.com",
          databaseURL: "https://si700-aulas-default-rtdb.firebaseio.com",
          projectId: "si700-aulas",
          storageBucket: "si700-aulas.firebasestorage.app",
          messagingSenderId: "457935667667",
          appId: "1:457935667667:web:67465cc634aa6eef696f26",
          measurementId: "G-NFMHJ3D7FR"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LoginBloc loginBloc = LoginBloc();
  final AuthBloc authBloc = AuthBloc();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return authBloc;
            },
          ),
          BlocProvider(
            create: (context) {
              return loginBloc;
            },
          )
        ],
        child: MaterialApp(
            title: 'App de viagens',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              fontFamily: GoogleFonts.abhayaLibre().fontFamily,
            ),
            home: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
              if (state is AuthError) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Erro de Autenticação"),
                        content: Text(state.message),
                      );
                    });
              }
              if (state is Authenticated) {
                loginBloc.add(LoginEvent.Login);
              }
            }, builder: (context, state) {
              return BlocBuilder<LoginBloc, LoginState>(
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
                  });
            })));
  }
}
