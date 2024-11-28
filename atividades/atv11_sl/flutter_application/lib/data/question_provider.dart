import '../model/question.dart';
import '../model/questions.dart';

class QuestionProvider {
  static QuestionProvider helper = QuestionProvider._createInstance();
  QuestionProvider._createInstance();
  Questions questions = Questions(questionList: [
    Question(
        titulo: "Primeira",
        subTitulo: "",
        alternatives: ["a", "b", "c", "d"],
        type: QuestionType.multiple),
    Question(
        titulo: "Segunda",
        subTitulo: "Tenho um subtítulo",
        alternatives: ["a", "b", "c", "d"],
        type: QuestionType.singleShort),
    Question(
        titulo: "Terceira",
        subTitulo: "Tenho um subtítulo",
        alternatives: [],
        type: QuestionType.text),
    Question(
        titulo: "Quarta",
        subTitulo: "DROPDOWN",
        alternatives: ["a", "b", "c", "d"],
        type: QuestionType.singleLong),
// Adicione mais perguntas conforme necessário
  ], breakpoints: [
    1, 2, 4, 5 // Defina os pontos de quebra desejados
  ]);
}
