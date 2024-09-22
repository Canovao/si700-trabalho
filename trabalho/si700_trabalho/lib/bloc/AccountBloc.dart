import 'package:flutter_bloc/flutter_bloc.dart';

enum AccountState { Idle, Editing, Favorites, History }

enum AccountEvent { Idle, Editing, Favorites, History }

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountState.Idle) {
    on<AccountEvent>((event, emit) {
      switch (event) {
        case AccountEvent.Idle:
          emit(AccountState.Idle);
          break;
        case AccountEvent.Editing:
          emit(AccountState.Editing);
          break;
        case AccountEvent.Favorites:
          emit(AccountState.Favorites);
          break;
        case AccountEvent.History:
          emit(AccountState.History);
          break;
      }
    });
  }
}
