import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';

import 'bloc/manage_bloc.dart';

import 'view/add_note.dart';
import 'view/list_note.dart';
import 'view/wrapper.dart';

import 'package:firebase_core/firebase_core.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return ManageBloc(InsertState(noteList: []))
              ..add(
                GetNoteListEvent(),
              );
          },
        ),
        BlocProvider(
          create: (context) {
            return AuthBloc();
          },
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
