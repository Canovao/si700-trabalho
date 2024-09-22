import 'package:flutter_bloc/flutter_bloc.dart';

enum SearchState { idle, updateList }

enum SearchEvent { idle, updateList }

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState.idle) {
    on<SearchEvent>((event, emit) {
      switch (event) {
        case SearchEvent.idle:
          emit(SearchState.idle);
          break;
        case SearchEvent.updateList:
          emit(SearchState.updateList);
          break;
      }
    });
  }
}
