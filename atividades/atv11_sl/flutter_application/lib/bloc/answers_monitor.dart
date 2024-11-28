import 'package:flutter_application/data/generic_data_provider.dart';
import 'package:flutter_application/model/answer_collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MonitorEvent {}

class AskNewList extends MonitorEvent {}

class UpdateList extends MonitorEvent {}

class MonitorState {
  AnswerCollection answerCollection;
  MonitorState({required this.answerCollection});
}

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  late AnswerCollection answerCollection;

  MonitorBloc({required this.answerCollection})
      : super(MonitorState(answerCollection: answerCollection)) {
    this.answerCollection = AnswerCollection();
    GenericDataProvider.helper.stream.listen((event) {
      add(UpdateList());
    });

    on<AskNewList>((event, emit) async {
      answerCollection = (await GenericDataProvider.helper.getAllAnswers());
      emit(MonitorState(answerCollection: answerCollection));
    });

    on<UpdateList>((event, emit) {
      emit(MonitorState(answerCollection: answerCollection));
    });

    add(AskNewList());
  }
}
