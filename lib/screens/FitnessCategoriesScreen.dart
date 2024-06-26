import 'package:flutter/material.dart';
import 'Homescreensearch.dart';
import '../utils/icon_mapping.dart';
import '../fitness_api_service.dart';

class FitnessCategoriesScreen extends StatelessWidget {
  final String categoryName;
  final FitnessAPIService apiService = FitnessAPIService();

  FitnessCategoriesScreen(this.categoryName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: apiService.fetchCategories(categoryName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar dados"));
          } else {
            List<Map<String, dynamic>> specialties = snapshot.data ?? [];
            return ListView.builder(
              itemCount: specialties.length,
              itemBuilder: (context, index) {
                final specialty = specialties[index];
                return Card(
                  child: ListTile(
                    leading: Icon(getIcon(specialty['icon'])),
                    title: Text(specialty['name']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomeScreenSearch(title: specialty['name']),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
