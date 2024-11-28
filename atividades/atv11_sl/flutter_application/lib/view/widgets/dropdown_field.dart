import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/bloc/answer_manager.dart';
import 'package:flutter_application/model/question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionDropDownField extends StatelessWidget {
  final Question question;
  final int questionIndex;

  const QuestionDropDownField({
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
        _buildDropdown(),
      ],
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ManageBloc, ManageState>(
        builder: (context, state) {
          // Obtenha a resposta atual para a questão
          List answer = state.answers.getAnswer(questionIndex);
          int? selectedValue = answer.isNotEmpty ? answer.first : null;

          return InputDecorator(
            decoration: InputDecoration(
              labelText: question.subTitulo,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: DropdownButton<int>(
              value: selectedValue,
              isExpanded: true,
              hint: Text("Selecione uma opção"),
              items: List<DropdownMenuItem<int>>.generate(
                question.alternatives.length,
                (index) => DropdownMenuItem(
                  value: index,
                  child: Text(question.alternatives[index]),
                ),
              ),
              onChanged: (int? newValue) {
                if (newValue != null) {
                  BlocProvider.of<ManageBloc>(context).add(
                      SwapAnswer(question: questionIndex, value: newValue));
                }
              },
              underline: SizedBox(),
            ),
          );
        },
      ),
    );
  }
}
