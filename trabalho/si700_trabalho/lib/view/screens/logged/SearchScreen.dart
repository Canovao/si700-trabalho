import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si700_trabalho/bloc/SearchBloc.dart';
import 'package:si700_trabalho/model/CardContent.dart';
import 'package:si700_trabalho/view/layout/SummaryCardLayout.dart';
import 'package:si700_trabalho/view/layout/text/ScreenSubTitleTextLayout.dart';
import 'package:si700_trabalho/view/layout/text/ScreenTitleTextLayout.dart';

class SearchScreen extends StatelessWidget {
  final Widget _pesquisePorDestinosNovos =
      const ScreenSubTitleTextlayout(text: 'Pesquise por destinos novos!');
  final SearchBloc _searchBloc = SearchBloc();
  final _formKey = GlobalKey<FormState>();
  List<CardContent> contentFound = [];
  String? searchText = "";

  SearchScreen({super.key});

  void _search() {
    if (searchText == null || searchText!.isEmpty) {
      return;
    }
    // TODO ALIMENTAR contentFound COM O RESULTADO DA API

    // MOCK TEMPORÁRIO
    contentFound = [
      CardContent(
        imageUrl:
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
        name: 'Local Z',
        country: 'País Y',
        rating: 4.8,
        description: 'Descrição do local Z',
      ),
      CardContent(
        imageUrl:
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
        name: 'Local Z',
        country: 'País Y',
        rating: 4.8,
        description: 'Descrição do local Z',
      ),
      CardContent(
        imageUrl:
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
        name: 'Local Z',
        country: 'País Y',
        rating: 4.8,
        description: 'Descrição do local Z',
      ),
      CardContent(
        imageUrl:
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
        name: 'Local Z',
        country: 'País Y',
        rating: 4.8,
        description: 'Descrição do local Z',
      ),
      CardContent(
        imageUrl:
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
        name: 'Local Z',
        country: 'País Y',
        rating: 4.8,
        description: 'Descrição do local Z',
      ),
      CardContent(
        imageUrl:
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
        name: 'Local Z',
        country: 'País Y',
        rating: 4.8,
        description: 'Descrição do local Z',
      ),
      CardContent(
        imageUrl:
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
        name: 'Local Z',
        country: 'País Y',
        rating: 4.8,
        description: 'Descrição do local Z',
      ),
      CardContent(
        imageUrl:
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
        name: 'Local Z',
        country: 'País Y',
        rating: 4.8,
        description: 'Descrição do local Z',
      ),
      CardContent(
        imageUrl:
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
        name: 'Local Z',
        country: 'País Y',
        rating: 4.8,
        description: 'Descrição do local Z',
      ),
      CardContent(
        imageUrl:
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/60/88/b3/fenix-hotel-limeira.jpg?w=700&h=-1&s=1',
        name: 'Local Z',
        country: 'País Y',
        rating: 4.8,
        description: 'Descrição do local Z',
      ),
    ];
    _searchBloc.add(SearchEvent.updateList);
  }

  List<List<T>> _groupToTwoColumns<T>(List<T> list) {
    List<List<T>> groups = [];
    for (int i = 0; i < list.length; i += 2) {
      if (i + 1 < list.length) {
        groups.add([list[i], list[i + 1]]);
      } else {
        groups.add([list[i]]);
      }
    }
    return groups;
  }

  Widget _buildTableContent() {
    List<List<CardContent>> groups = _groupToTwoColumns(contentFound);

    List<Row> rows = [];

    for (var group in groups) {
      List<SummaryCardLayout> rowChildren = [];
      for (var cardContent in group) {
        rowChildren.add(SummaryCardLayout(cardContent: cardContent));
      }
      if (rowChildren.length == 1) {
        rowChildren.add(SummaryCardLayout());
      }
      rows.add(Row(children: rowChildren));
    }

    return contentFound.isNotEmpty
        ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const ScreenSubTitleTextlayout(text: 'Destinos encontrados'),
            const SizedBox(height: 8),
            Container(
                height: 470,
                child: ListView(scrollDirection: Axis.vertical, children: rows))
          ])
        : _pesquisePorDestinosNovos;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            const ScreenTitleTextlayout(text: 'Pesquisar'),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Expanded(
                          // Para ajustar o TextFormField corretamente
                          child: TextFormField(
                            onSaved: (value) => searchText = value,
                            decoration: InputDecoration(
                              hintText: 'Pesquisar destinos',
                              hintStyle: const TextStyle(color: Colors.grey),
                              prefixIcon:
                                  const Icon(Icons.search, color: Colors.grey),
                              filled: true,
                              fillColor: Colors.grey[300],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _search();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                          ),
                          label: const Text(''),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<SearchBloc, SearchState>(
                  bloc: _searchBloc,
                  builder: (context, state) {
                    switch (state) {
                      case SearchState.idle:
                        return _pesquisePorDestinosNovos;
                      case SearchState.updateList:
                        return _buildTableContent();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
