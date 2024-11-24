import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si700_trabalho/model/ProfileContent.dart';
import 'package:si700_trabalho/provider/ProfileContentProvider.dart';

enum ProfileContentState { Idle, Update }

enum ProfileContentEvent { Idle, Update }

class ProfileContentBloc
    extends Bloc<ProfileContentEvent, ProfileContentState> {
  ProfileContentBloc() : super(ProfileContentState.Idle) {
    ProfileContentProvider.helper.stream.listen((onData) {
      ProfileContent.self = onData;
      add(ProfileContentEvent.Update);
    });

    ProfileContentProvider.helper.profileCollection
        .doc(ProfileContentProvider.helper.uid)
        .snapshots()
        .listen((onData) {
      ProfileContent.self = ProfileContent.fromMap(onData.data()!);
      add(ProfileContentEvent.Update);
    });

    on<ProfileContentEvent>((event, emit) {
      switch (event) {
        case ProfileContentEvent.Idle:
          emit(ProfileContentState.Idle);
          break;
        case ProfileContentEvent.Update:
          emit(ProfileContentState.Update);
          break;
      }
    });
  }
}
