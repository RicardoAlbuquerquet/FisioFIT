import 'package:flutter/material.dart';
import 'FitnessCategoriesScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> buttonOptions = [
    {
      'icon': Icons.fitness_center,
      'title': 'Musculação',
      'backgroundImage': 'assets/images/musculacao_bg.jpg',
    },
    {
      'icon': Icons.directions_run,
      'title': 'Corrida',
      'backgroundImage': 'assets/images/corrida_bg.jpg',
    },
    {
      'icon': Icons.directions_bike,
      'title': 'Ciclismo',
      'backgroundImage': 'assets/images/musculacao_bg2.jpg',
    },
    {
      'icon': Icons.pool,
      'title': 'Natação',
      'backgroundImage': 'assets/images/corrida_bg.jpg',
    },
    {
      'icon': Icons.sports_handball,
      'title': 'Handball',
      'backgroundImage': 'assets/images/musculacao_bg.jpg',
    },
    {
      'icon': Icons.sports_soccer,
      'title': 'Futebol',
      'backgroundImage': 'assets/images/corrida_bg.jpg',
    },
  ];

  void navigateToActivityDetails(BuildContext context, String title) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => FitnessCategoriesScreen(title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.white10,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: buttonOptions.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de colunas
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemBuilder: (context, index) {
          final option = buttonOptions[index];

          return GestureDetector(
            onTap: () {
              navigateToActivityDetails(context, option['title']);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(2.0),
                image: option.containsKey('backgroundImage')
                    ? DecorationImage(
                        image: AssetImage(option['backgroundImage']),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Alinhamento à esquerda
                children: [
                  Container(
                    width: double
                        .infinity, // Faz o container ocupar a largura total
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                    color: Color(0xFF66FFCC).withOpacity(
                        0.7), // Fundo semitransparente para destaque
                    child: Text(
                      option['title'],
                      style: themeData.textTheme.subtitle1?.copyWith(
                        color: Colors.black,
                        fontSize: 20, // Tamanho maior do texto
                      ),
                      textAlign:
                          TextAlign.center, // Alinhamento do texto à esquerda
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Icon(
                        option['icon'],
                        color: Color(0xFF66FFCC),
                        size: 70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
