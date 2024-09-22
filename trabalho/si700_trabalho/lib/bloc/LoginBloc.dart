import 'package:flutter_bloc/flutter_bloc.dart';

enum LoginState { Logged, NotLogged, CreateAccount }

enum LoginEvent { Login, NotLogged, CreateAccount }

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.NotLogged) {
    on<LoginEvent>((event, emit) {
      switch (event) {
        case LoginEvent.Login:
          emit(LoginState.Logged);
          break;
        case LoginEvent.NotLogged:
          emit(LoginState.NotLogged);
          break;
        case LoginEvent.CreateAccount:
          emit(LoginState.CreateAccount);
          break;
      }
    });
  }
}
