import 'package:flutter_application/data/generic_data_provider.dart';
import 'package:flutter_application/model/answer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ManageEvent {}

class SwapAnswer extends ManageEvent {
  int question;
  int value;
  SwapAnswer({required this.question, required this.value});
}

class SetAnswer extends ManageEvent {
  int question;
  int value;
  SetAnswer({required this.question, required this.value});
}

class WriteAnswer extends ManageEvent {
  int question;
  String value;
  WriteAnswer({required this.question, required this.value});
}

class CreateRecord extends ManageEvent {}

class UpdateRecord extends ManageEvent {
  String answerId;
  UpdateRecord({required this.answerId});
}

class DeleteRecord extends ManageEvent {
  String answerId;
  DeleteRecord({required this.answerId});
}

class ManageState {
  late Answer answers;
  late String answerId;
  ManageState({required this.answers, required this.answerId});
  ManageState.build(int numQuestions) {
    answers = Answer(numQuestions: numQuestions);
    answerId = "";
  }
}

class ManageBloc extends Bloc<ManageEvent, ManageState> {
  String? answerId;
  int numQuestions;

  ManageBloc({required this.numQuestions})
      : super(ManageState.build(numQuestions)) {
    on<SwapAnswer>((event, emit) async {
      Answer answers = await GenericDataProvider.helper.getAnswer(answerId!);
      answers.swapAnswer(event.question, event.value);
      GenericDataProvider.helper.updateAnswer(answerId!, answers);
      emit(ManageState(answers: answers, answerId: answerId!));
    });
    on<SetAnswer>((event, emit) async {
      Answer answers = await GenericDataProvider.helper.getAnswer(answerId!);
      answers.setAnswer(event.question, event.value);
      GenericDataProvider.helper.updateAnswer(answerId!, answers);
      emit(ManageState(answers: answers, answerId: answerId!));
    });
    on<WriteAnswer>((event, emit) async {
      Answer answers = await GenericDataProvider.helper.getAnswer(answerId!);
      answers.writeAnswer(event.question, event.value);
      GenericDataProvider.helper.updateAnswer(answerId!, answers);
      emit(ManageState(answers: answers, answerId: answerId!));
    });

    on<CreateRecord>((event, emit) async {
      Answer answers = Answer(numQuestions: numQuestions);
      answerId = await GenericDataProvider.helper
          .insertAnswer(Answer.withData(answerList: answers.answerList));
      emit(ManageState(answers: answers, answerId: answerId!));
    });
    on<UpdateRecord>((event, emit) async {
      answerId = event.answerId;
      Answer answer = await GenericDataProvider.helper.getAnswer(answerId!);
      emit(ManageState(answers: answer, answerId: answerId!));
    });
    on<DeleteRecord>((event, emit) async {
      answerId = event.answerId;
      GenericDataProvider.helper.deleteAnswer(answerId!);
      emit(ManageState(
          answers: Answer(numQuestions: numQuestions), answerId: answerId!));
    });
  }
}
