import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/answer_manager.dart';
import '../../bloc/answers_monitor.dart';
import '../../model/answer_collection.dart';

class AnswerList extends StatelessWidget {
  MonitorBloc monitorBloc;
  AnswerList({required this.monitorBloc, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Registros'),
      ),
      body: _buildAnswersList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          BlocProvider.of<ManageBloc>(context).add(CreateRecord());
          BlocProvider.of<MonitorBloc>(context).add(AskNewList());
          Navigator.pushNamed(context, "/create");
        },
      ),
    );
  }

  Widget _buildAnswersList() {
    return BlocBuilder<MonitorBloc, MonitorState>(
      builder: (context, state) {
        AnswerCollection answerCollection = state.answerCollection;

        if (answerCollection.length() == 0) {
          return const Center(
            child: Text('Nenhuma resposta encontrada.'),
          );
        }

        return _buildAnswerTile(answerCollection);
      },
    );
  }

  Widget _buildAnswerTile(AnswerCollection answerCollection) {
    return ListView.builder(
      itemCount: answerCollection.length(),
      itemBuilder: (context, index) {
        String id = answerCollection.getIdAtIndex(index);

        return ListTile(
          title: Text(id),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              BlocProvider.of<ManageBloc>(context)
                  .add(DeleteRecord(answerId: id));
              BlocProvider.of<MonitorBloc>(context).add(UpdateList());
              BlocProvider.of<MonitorBloc>(context)
                  .answerCollection
                  .deleteAnswerOfId(id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$id removida')),
              );
            },
          ),
          onTap: () {
            BlocProvider.of<ManageBloc>(context)
                .add(UpdateRecord(answerId: id));
            Navigator.pushNamed(
              context,
              "/update",
            );
          },
        );
      },
    );
  }
}
