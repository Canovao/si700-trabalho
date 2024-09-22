import 'package:flutter_bloc/flutter_bloc.dart';

enum TravelEvent { Idle, Details }

enum TravelState { Idle, Details }

class TravelBloc extends Bloc<TravelEvent, TravelState> {
  static final TravelBloc instance = TravelBloc._(TravelState.Idle);

  TravelBloc._(super.initialState) {
    on<TravelEvent>((event, emit) {
      switch (event) {
        case TravelEvent.Idle:
          emit(TravelState.Idle);
          break;
        case TravelEvent.Details:
          emit(TravelState.Details);
          break;
      }
    });
  }
}
