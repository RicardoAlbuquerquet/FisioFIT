import 'package:flutter/material.dart';
import '../widgets/CustomSearchDelegate.dart';

class HomeScreenSearch extends StatelessWidget {
  final String title;
  HomeScreenSearch({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profissionais'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://via.placeholder.com/150'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Nome do Profissional: Fulano',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(title, style: TextStyle(color: Colors.grey))
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.star, color: Color(0xFF66FFCC)),
                        onPressed: () {}, // Placeholder para  de avaliacao
                      ),
                      const Text('4.5'), // Valor de avaliacao de exemplo
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                Image.network('https://via.placeholder.com/400x200',
                    fit: BoxFit.cover),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implemente a funcionalidade de contratacao aqui
                      },
                      icon: const Icon(Icons.check_circle_outline,
                          color: Colors.white),
                      label: const Text('Contratar'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.white, // Cor do texto
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Icon(Icons.share, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
