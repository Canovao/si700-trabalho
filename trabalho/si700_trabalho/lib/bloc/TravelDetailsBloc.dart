import 'package:flutter_bloc/flutter_bloc.dart';

enum TravelDetailsEvent { Idle, ReserveFinished }

enum TravelDetailsState { Idle, ReserveFinished }

class TravelDetailsBloc extends Bloc<TravelDetailsEvent, TravelDetailsState> {
  static final TravelDetailsBloc instance =
      TravelDetailsBloc._(TravelDetailsState.Idle);

  TravelDetailsBloc._(super.initialState) {
    on<TravelDetailsEvent>((event, emit) {
      switch (event) {
        case TravelDetailsEvent.Idle:
          emit(TravelDetailsState.Idle);
          break;
        case TravelDetailsEvent.ReserveFinished:
          emit(TravelDetailsState.ReserveFinished);
          break;
      }
    });
  }
}
