import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';

Future<List<Category>> fetchCategories() async {
  final response =
      await http.get(Uri.parse('https://api.mocklets.com/p6839/explore-cred'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['sections'];
    return data.map((section) => Category.fromJson(section)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
