import 'package:flutter_application/model/answer.dart';

class AnswerCollection {
  List<String> idList = [];
  List<Answer> answerList = [];

  length() {
    return answerList.length;
  }

  getAnswerAtIndex(int index) {
    return answerList[index];
  }

  getIdAtIndex(int index) {
    return idList[index];
  }

  getIndexOfId(String id) {
    return idList.indexOf(id);
  }

  updateAnswerOfId(String id, Answer answer) {
    int? idx = getIndexOfId(id);
    if (idx! != -1) {
      answerList[idx] = answer;
    }
  }

  deleteAnswerOfId(String id) {
    int? idx = getIndexOfId(id);
    if (idx! != -1) {
      idList.removeAt(idx);
      answerList.removeAt(idx);
    }
  }

  void insertAnswerOfId(String id, Answer answer) {
    int? idx = getIndexOfId(id);
    if (idx == -1) {
      idList.add(id);
      answerList.add(answer);
    }
  }

  void updateOrInsertAnswerOfId(String id, Answer answer) {
    int index = getIndexOfId(id);
    if (index != -1) {
      answerList[index] = answer;
    } else {
      idList.add(id);
      answerList.add(answer);
    }
  }
}
