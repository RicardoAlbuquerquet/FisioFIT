import 'package:flutter/material.dart';

// CustomSearchDelegate pode ser definido para personalizar a pesquisa
class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Voce pode mostrar os resultados da pesquisa aqui
    return Center(
      child: Text('Nenhum resultado para "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugestoes enquanto o usuario digita
    final suggestions = query.isEmpty
        ? []
        : ['Sugestao 1', 'Sugestao 2']
            .where((sug) => sug.startsWith(query))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {},
        );
      },
    );
  }
}
