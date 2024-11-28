class Answer {
  late int numQuestions;
  List answerList = [];

  Answer({required int numQuestions}) {
    this.numQuestions = numQuestions;
    for (int i = 0; i < numQuestions; i++) {
      this.answerList.add([]);
    }
  }

  Answer.withData({required List answerList}) {
    this.answerList = answerList;
    this.numQuestions = answerList.length;
  }

  List getAnswer(int i) {
    return answerList[i];
  }

  setAnswer(int i, int j) {
    answerList[i] = [j];
  }

  writeAnswer(int i, String j) {
    answerList[i] = [j];
  }

  swapAnswer(int i, int j) {
    if (answerList[i].contains(j)) {
      answerList[i].remove(j);
    } else {
      List answer = answerList[i];
      answer.add(j);
      answerList[i] = answer;
    }
  }

  @override
  String toString() {
    List<String> strArray = [];
    for (int i = 0; i < answerList.length; i++) {
      String strElement = '"${answerList[i].join(",")}"';
      strArray.add(strElement);
    }
    return strArray.join(";");
  }
}
