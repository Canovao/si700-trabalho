import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/bloc/answer_manager.dart';
import 'package:flutter_application/model/question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionTextField extends StatelessWidget {
  final Question question;
  final int questionIndex;

  const QuestionTextField({
    super.key,
    required this.question,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return _buildQuestion();
  }

  Widget _buildQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (question.titulo != "")
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              question.titulo,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        _buildTextFormField(),
      ],
    );
  }

  Widget _buildTextFormField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ManageBloc, ManageState>(
        builder: (context, state) {
          // Obtenha a resposta atual para a questão, se existir
          List answer = state.answers.getAnswer(questionIndex);
          String? initialValue = answer.isNotEmpty ? answer.first : null;

          return TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              labelText: question.subTitulo,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (value) {
              BlocProvider.of<ManageBloc>(context)
                  .add(WriteAnswer(question: questionIndex, value: value));
            },
          );
        },
      ),
    );
  }
}
