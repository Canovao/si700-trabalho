import 'package:flutter/material.dart';
import 'package:flutter_application/bloc/answer_manager.dart';
import 'package:flutter_application/bloc/answers_monitor.dart';
import 'package:flutter_application/data/question_provider.dart';
import 'package:flutter_application/model/answer_collection.dart';
import 'package:flutter_application/model/question.dart';
import 'package:flutter_application/model/questions.dart';
import 'package:flutter_application/view/screen/answers_list_view.dart';
import 'package:flutter_application/view/screen/questions_screen.dart';
import 'package:flutter_application/view/widgets/checkbox_field.dart';
import 'package:flutter_application/view/widgets/dropdown_field.dart';
import 'package:flutter_application/view/widgets/radio_field.dart';
import 'package:flutter_application/view/widgets/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late int numQuestions;
  AnswerCollection answerCollection = AnswerCollection();

  late ManageBloc manageBloc;
  late MonitorBloc monitorBloc;

  AppRouter() {
    numQuestions = QuestionProvider.helper.questions.questionList.length;
    manageBloc = ManageBloc(numQuestions: numQuestions);
    monitorBloc = MonitorBloc(answerCollection: answerCollection);
  }

  Route onGenerateRoute(RouteSettings route) {
    switch (route.name) {
      case "/":
        return MaterialPageRoute(builder: (BuildContext context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: monitorBloc),
              BlocProvider.value(value: manageBloc),
            ],
            child: AnswerList(monitorBloc: monitorBloc),
          );
        });
      case "/create":
        List<Widget> localBucket = [];
        Questions questions = QuestionProvider.helper.questions;
        for (int i = 0; i < questions.questionList.length; i++) {
          Question e = questions.questionList[i];
          switch (e.type) {
            case QuestionType.singleShort:
              localBucket.add(QuestionRadioButtonField(
                  question: questions.questionList[i], questionIndex: i));
            case QuestionType.singleLong:
              localBucket.add(QuestionDropDownField(
                  question: questions.questionList[i], questionIndex: i));
            case QuestionType.multiple:
              localBucket.add(QuestionCheckBoxField(
                  question: questions.questionList[i], questionIndex: i));
            case QuestionType.text:
              localBucket.add(QuestionTextField(
                  question: questions.questionList[i], questionIndex: i));
            default:
              localBucket.add(Container());
          }
        }
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: manageBloc),
            ],
            child: QuestionsScreen(children: localBucket),
          );
        });
      case "/update":
        List<Widget> localBucket = [];
        Questions questions = QuestionProvider.helper.questions;

        for (int i = 0; i < questions.questionList.length; i++) {
          Question e = questions.questionList[i];
          switch (e.type) {
            case QuestionType.singleShort:
              localBucket.add(QuestionRadioButtonField(
                  question: questions.questionList[i], questionIndex: i));
            case QuestionType.singleLong:
              localBucket.add(QuestionDropDownField(
                  question: questions.questionList[i], questionIndex: i));
            case QuestionType.multiple:
              localBucket.add(QuestionCheckBoxField(
                  question: questions.questionList[i], questionIndex: i));
            case QuestionType.text:
              localBucket.add(QuestionTextField(
                  question: questions.questionList[i], questionIndex: i));
            default:
              localBucket.add(Container());
          }
        }
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: manageBloc),
            ],
            child: QuestionsScreen(children: localBucket),
          );
        });
      default:
        return MaterialPageRoute(builder: (_) {
          return const Text("ASDF");
        });
    }
  }

  void dispose() {
    manageBloc.close();
    monitorBloc.close();
  }
}
