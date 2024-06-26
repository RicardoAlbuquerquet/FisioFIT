import 'package:amplify_flutter/amplify_flutter.dart';
import 'dart:convert';

class FitnessAPIService {
  Future<List<Map<String, dynamic>>> fetchCategories(String typeName) async {
    List<Map<String, dynamic>> categories = [];

    try {
      String graphQLDocument = '''
        query MyQuery(\$typeName: String!) {
          listFitnessCategories(filter: {string_type_name: {eq: \$typeName}}) {
            items {
              string_imagePath
              string_subtype_name
              string_type_name
            }
          }
        }
      ''';

      var operation = Amplify.API.query(
          request: GraphQLRequest<String>(
        document: graphQLDocument,
        variables: {
          'typeName': typeName,
        },
      ));

      var response = await operation.response;
      var data = jsonDecode(response.data ?? '{}');

      // Processa os dados para transformá-los na lista de categorias
      if (data != null && data['listFitnessCategories'] != null) {
        var items = data['listFitnessCategories']['items'];
        for (var item in items) {
          categories.add({
            'name': item['string_subtype_name'],
            'icon': item['string_imagePath'],
          });
        }
      }
    } catch (e) {
      print('Error performing query: $e');
    }

    return categories;
  }
}
