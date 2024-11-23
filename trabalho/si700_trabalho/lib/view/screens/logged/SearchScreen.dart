import 'package:flutter/material.dart';
import 'package:si700_trabalho/provider/TripAdvisorProvider.dart';
import 'package:si700_trabalho/view/layout/ListViewLayout.dart';
import 'package:si700_trabalho/view/layout/PopularCardLayout.dart';
import 'package:si700_trabalho/view/layout/text/ScreenSubTitleTextLayout.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Widget _pesquisePorDestinosNovos =
      const ScreenSubTitleTextlayout(text: 'Pesquise por destinos novos!');

  List<PopularCardLayout> contentFound = [];

  String? searchText = "";

  void _search(context) async {
    if (searchText == null || searchText!.isEmpty) {
      return;
    }
    List<PopularCardLayout> content =
        await Tripadvisorprovider.helper.search(searchText!);

    setState(() {
      contentFound = content;
    });
  }

  List<Widget> _buildTableContent() {
    return contentFound.isNotEmpty ? contentFound : [_pesquisePorDestinosNovos];
  }

  @override
  Widget build(BuildContext context) {
    return ListViewLayout(
      title: 'Pesquisar',
      subTitle: '',
      children: [
        Row(
          children: [
            Expanded(
              // Para ajustar o TextFormField corretamente
              child: TextFormField(
                onChanged: (value) => searchText = value,
                onSaved: (value) => searchText = value,
                decoration: InputDecoration(
                  hintText: 'Pesquisar destinos',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
                _search(context);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              label: const Text(''),
            ),
          ],
        ),
        ..._buildTableContent()
      ],
    );
  }
}
