import 'dart:async';

import 'package:flutter_application/model/answer.dart';
import 'package:flutter_application/model/answer_collection.dart';

class GenericDataProvider {
  int numInsertions = 0;
  Map<String, List> _database = {};
  StreamController _controller = StreamController();

  static GenericDataProvider helper = GenericDataProvider._createInstance();

  GenericDataProvider._createInstance();

  Future<String> insertAnswer(Answer answer) async {
    String answerId = numInsertions.toString();

    _database.addAll({answerId: answer.answerList});

    numInsertions++;

    notify(answerId, answer);

    return answerId;
  }

  Future<String> updateAnswer(String answerId, Answer answer) async {
    _database[answerId] = answer.answerList;

    notify(answerId, answer);

    return answerId;
  }

  Future<String> deleteAnswer(String answerId) async {
    _database.remove(answerId);

    notify(answerId, null);

    return answerId;
  }

  Future<Answer> getAnswer(String answerId) async {
    if (_database.containsKey(answerId)) {
      return Answer.withData(answerList: _database[answerId]!);
    } else {
      return Answer(numQuestions: 0);
    }
  }

  Future<AnswerCollection> getAllAnswers() async {
    AnswerCollection answerCollection = AnswerCollection();

    _database.forEach((key, value) {
      answerCollection.insertAnswerOfId(
          key, Answer.withData(answerList: value));
    });

    return answerCollection;
  }

  notify(String answerId, Answer? answer) async {
    _controller.sink.add([answerId, answer]);
  }

  Stream get stream {
    return _controller.stream;
  }
}
