import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si700_trabalho/model/ProfileContent.dart';
import 'package:si700_trabalho/model/UserModel.dart';
import 'package:si700_trabalho/provider/AuthProvider.dart';
import 'package:si700_trabalho/provider/ProfileContentProvider.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(Unauthenticated()) {
    FirebaseAuthenticationService.helper.stream.listen(
      (event) {
        add(AuthServerEvent(event));
      },
    );

    on<AuthServerEvent>((event, emit) async {
      if (event.userModel == null) {
        ProfileContentProvider.helper.uid = "default";
        emit(Unauthenticated());
      } else {
        ProfileContentProvider.helper.uid = event.userModel!.uid;
        await ProfileContentProvider.helper.get();
        emit(Authenticated(username: event.userModel!.uid));
      }
    });

    on<RegisterUser>((RegisterUser event, Emitter emit) async {
      try {
        await FirebaseAuthenticationService.helper
            .createUserWithEmailAndPassword(
          event.username,
          event.password,
        );
        ProfileContentProvider.helper.insert(event.profileContent);
      } catch (e) {
        ProfileContentProvider.helper.uid = "default";
        emit(AuthError(message: "Impossível Registrar: ${e.toString()}"));
      }
    });
    on<LoginUser>((LoginUser event, Emitter emit) async {
      try {
        await FirebaseAuthenticationService.helper.signInWithEmailAndPassword(
          event.username,
          event.password,
        );
      } catch (e) {
        ProfileContentProvider.helper.uid = "default";
        emit(AuthError(message: "Impossível Logar: ${e.toString()}"));
      }
    });
    on<Logout>((Logout event, Emitter emit) async {
      try {
        FirebaseAuthenticationService.helper.signOut();
      } catch (e) {
        emit(AuthError(message: "Impossível Deslogar: ${e.toString()}"));
      }
    });
  }
}

abstract class AuthEvent {}

class LoginUser extends AuthEvent {
  String username;
  String password;

  LoginUser({required this.username, required this.password});
}

class RegisterUser extends AuthEvent {
  ProfileContent profileContent;
  String username;
  String password;

  RegisterUser(
      {required this.username,
      required this.password,
      required this.profileContent});
}

class Logout extends AuthEvent {}

class AuthServerEvent extends AuthEvent {
  UserModel? userModel;
  AuthServerEvent(this.userModel);
}

abstract class AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  String username;
  Authenticated({required this.username});
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}
